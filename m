Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 6C684DDF19
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 09:24:10 +1000 (EST)
Message-ID: <4898E112.8020903@am.sony.com>
Date: Tue, 5 Aug 2008 16:24:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: PS3 early lock-up
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>	
	<1217886287.24157.87.camel@pasglop>
	<1217886777.24157.91.camel@pasglop>	 <48979F6F.1050507@am.sony.com>
	<1217900430.24157.142.camel@pasglop>	
	<Pine.LNX.4.64.0808051142160.18419@vixen.sonytel.be>
	<1217932117.24157.185.camel@pasglop>
In-Reply-To: <1217932117.24157.185.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
>> arch/powerpc/platfroms/ps3/htab.c:ps3_hpte_updatepp() uses `htab[slot]=
.v'.
>=20
> Ok, that leaves us with 2 options:
>=20
>  - Change ps3_hpte_updatepp() to not read from the hash table via that
> mapping (ie, do you have an LV1 call to read an HPTE ? Do you measure
> any significant performance loss using that instead ? updatepp shouldn'=
t
> be something called -that- often).

Yes, we have lv1_read_htab_entries().  Mokuno-san started some work to
convert to using it and removing the htab mapping:

  http://git.kernel.org/?p=3Dlinux/kernel/git/geoff/ps3-linux-patches.git=
;a=3Dblob;f=3Dps3-wip/ps3-htab-rework.diff;hb=3DHEAD

Unfortunately, this week Mokuno-san is on holiday, and I am busy preparin=
g
for SIGGRAPH (next week).

>  - Add a way to setup HPTEs using 3 PPP bits. I'm not going to implemen=
t
> that for the main hash code just yet though (the assembly) but it might
> be possible to implement it specifically for mappings bolted. That
> means it would only work when the mapping is done early but on PS3, we
> know that the hash table is always mapped early.
>=20
> The later would be a matter of taking my =EF=BB=BFhtab_convert_pte_flag=
s() function
> and making it capable, when _PAGE_USER is _not_ set and _PAGE_RW is not
> set neither, to set PPP to 110.
>=20
> You could do that by adding:
>=20
> 	if (!(pteflags & (_PAGE_USER | _PAGE_RW)))
> 		rflags |=3D (1 << 1) | (1 << 63);
>=20
> Dbl check that the resulting mapping isn't accessible to user space tho=
ugh.

If we can't remove the htab mapping with lv1_read_htab_entries(), I'll
look into this way.

-Geoff
