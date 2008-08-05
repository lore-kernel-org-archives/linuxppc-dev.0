Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36C02DDF1E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 11:40:43 +1000 (EST)
Subject: Re: PS3 early lock-up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <48979F6F.1050507@am.sony.com>
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
	<1217886287.24157.87.camel@pasglop> <1217886777.24157.91.camel@pasglop>
	<48979F6F.1050507@am.sony.com>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 11:40:30 +1000
Message-Id: <1217900430.24157.142.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Which should be 0x194.
> 
> That is 0x190.
> 
> 0x194 = _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX

Right, _PAGE_EXEC should only be set for the part covering the kernel
text. In any case, it shouldn't be what you showed.
 
> > Can you find out where that stupid value comes from ?
> 
> I didn't have time to look at in detail, but it fails from the
> ioremap call in ps3_map_htab (arch/powerpc/platfroms/ps3/htab.c):
> 
>  htab = (__force struct hash_pte *)ioremap_flags(htab_addr, htab_size,
>      pgprot_val(PAGE_READONLY_X));
> 
> IIRC, lv1 doesn't allow a read/write mapping of the htab, and that is
> why I used pgprot_val(PAGE_READONLY_X) here.

Why are you mapping it in the first place btw ? Do you actually use that
mapping ?

> I guess the value returned from pgprot_val(PAGE_READONLY_X)
> changed in recent kernels, and that is what is causing the failure.

Ok, there's definitely something fishy about passing the PP bits down
to ioremap. The reason it fails is that I no longer let _PAGE_USER
go down to the mapping. However, ioremap passes those bits as-is
to the hash insert code, it should instead perform the same munging
as the asm hashing code does, to turn that into a supervisor only
mapping.

However, there is a deeper issue with what you are doing. With using
only 2 PP bits, as is the case with linux, you -cannot- have a supervisor
read-only mapping that isn't also readable by userspace. It's possible
the newer 3 PPP bits encoding, but I don't know if Cell supports it and
linux currently doesn't use it.

That means that currently, your hash table is user readable... oops :-)

(This is a bug with other early IO mappings too btw, I'll have
to fix that).

However, it appears to me that you don't use the mapping of the hash
table anyway. So just remove the ioremap :-) I'll look at fixing
the attribute parsing for ioremap_prot() in the long run though.

Ben.

> Just FYI, I put these in:
> 
>   printk("%s:%d: flags = %x\n", __func__, __LINE__, (_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX));
>   printk("%s:%d: flags = %x\n", __func__, __LINE__, pgprot_val(PAGE_READONLY_X));
> 
> and got this (and lv1_write_htab_entry failed):
> 
>   ps3_map_htab:288: flags = 190
>   ps3_map_htab:289: flags = 117
> 
> -Geoff
> 
> 
