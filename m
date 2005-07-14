Return-Path: <a.woellert@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id E1D4B67CA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 01:11:26 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id z6so239622nzd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 08:11:24 -0700 (PDT)
Message-ID: <faba779805071408115179b292@mail.gmail.com>
Date: Thu, 14 Jul 2005 17:11:24 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <faba77980507140809ad923db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19857_11295861.1121353884941"
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<faba7798050714012370af5e74@mail.gmail.com>
	<EA68D741-EF23-461C-9ECB-49BB0D24367D@freescale.com>
	<faba77980507140809ad923db@mail.gmail.com>
Subject: ptrace on linux 2.6.12 causes oops
Reply-To: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_19857_11295861.1121353884941
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 it's on a tqm850l with mpc850. i've done the following:

in update_mmu_cache:

if (!PageReserved(page)
&& !test_bit(PG_arch_1, &page->flags)) {
// if (vma->vm_mm =3D=3D current->active_mm){
// _tlbie(address);
// __flush_dcache_icache((void *) address);
// } else
__flush_dcache_icache(page _address(page));
// flush_dcache_icache_page(page);

set_bit(PG_arch_1, &page->flags);
}

like it is in ppc64. now it works. the flush_dcache_icache_page calls=20
__flush_dcache_icache_phys, which temporary turns off the mmu for=20
data-addressing. a bit strange i think. but unfortunately i have too less=
=20
knowledge about kernel-internal ppc-stuff :(

anton

------=_Part_19857_11295861.1121353884941
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


it's on a tqm850l with mpc850. i've done the following:<br>

<br>

in update_mmu_cache:<br>

<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!PageReserved(page)<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&amp;&amp; !test_bit(PG_arch_1, &amp;page-&gt;flags)) {<br>

//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (vma-&gt;vm_mm =3D=3D current-&gt;active_mm){<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
_tlbie(address);<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
__flush_dcache_icache((void *) address);<br>

//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
} else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
__flush_dcache_icache(page _address(page));<br>
<div id=3D"mb_2">//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
flush_dcache_icache_page(page);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
set_bit(PG_arch_1, &amp;page-&gt;flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
like it is in ppc64. now it works. the flush_dcache_icache_page calls
__flush_dcache_icache_phys, which temporary turns off the mmu for
data-addressing. a bit strange i think. but unfortunately i have too
less knowledge about kernel-internal ppc-stuff :(<br>
<br>
anton<br><span class=3D"sg">
</span></div>
<span class=3D"sg">

</span>

------=_Part_19857_11295861.1121353884941--
