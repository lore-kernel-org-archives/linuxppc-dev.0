Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id E6671DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 10:32:00 +1000 (EST)
Message-ID: <48979F6F.1050507@am.sony.com>
Date: Mon, 4 Aug 2008 17:31:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: PS3 early lock-up
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>	
	<1217886287.24157.87.camel@pasglop>
	<1217886777.24157.91.camel@pasglop>
In-Reply-To: <1217886777.24157.91.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Benjamin Herrenschmidt wrote:
>> > ps3_hpte_insert() seems to be called during system initialization with the
>> > following values of rflags:
>> >   - first call: 0x190
>> >   - initial memory: 0x194 (455 times)
>> >   - hotplug memory:
>> >       o crash: 0x115
>> >       o OK: 0x117
>> > 
>> > Do you have an idea of what's really going on?
>> 
>> Weird... Both look incorrect. In fact, it's a bit scary...
>> 
>> The one with the 7 at the end means that user space as RO access to
>> the segment (oops !) and supervisor too. The one with the 5 means
>> RO for user and RW for supervisor.
>> 
>> That is unless your HV is munging them in strange ways... I don't
>> know why LV1 is refusing a combination though.
>> 
>> As for the flags, it depends what htab_bolt_mapping() is called
>> with.
>> 
>> Do you have a backtrace ? I'm a bit lots in the mem hotswap code
>> trying to figure out where the mapping comes from..
> 
> Ah, found it... It should be ok... both the mapping of the RAM itself
> and vmemmap_populate() should be passing 
> 
>   _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX;
> 
> Which should be 0x194.

That is 0x190.

0x194 = _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX

> 
> Can you find out where that stupid value comes from ?

I didn't have time to look at in detail, but it fails from the
ioremap call in ps3_map_htab (arch/powerpc/platfroms/ps3/htab.c):

 htab = (__force struct hash_pte *)ioremap_flags(htab_addr, htab_size,
     pgprot_val(PAGE_READONLY_X));

IIRC, lv1 doesn't allow a read/write mapping of the htab, and that is
why I used pgprot_val(PAGE_READONLY_X) here.

I guess the value returned from pgprot_val(PAGE_READONLY_X)
changed in recent kernels, and that is what is causing the failure.

Just FYI, I put these in:

  printk("%s:%d: flags = %x\n", __func__, __LINE__, (_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX));
  printk("%s:%d: flags = %x\n", __func__, __LINE__, pgprot_val(PAGE_READONLY_X));

and got this (and lv1_write_htab_entry failed):

  ps3_map_htab:288: flags = 190
  ps3_map_htab:289: flags = 117

-Geoff
