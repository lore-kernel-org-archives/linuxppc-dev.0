Return-Path: <a.woellert@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.207])
	by ozlabs.org (Postfix) with ESMTP id 8FF4167A79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 19:42:28 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 9so335409nzo
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 02:42:27 -0700 (PDT)
Message-ID: <faba779805071502425552aefc@mail.gmail.com>
Date: Fri, 15 Jul 2005 11:42:27 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050714111941.GC5179@dmt.cnet>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_278_26635838.1121420547509"
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<faba7798050714012370af5e74@mail.gmail.com>
	<20050714202715.GS19321@oops.ghostprotocols.net>
	<20050714111941.GC5179@dmt.cnet>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ptrace on linux 2.6.12 causes oops
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

------=_Part_278_26635838.1121420547509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>=20
> Yep, just that now its the ptraceing process which is faulting in the=20
> page,
> instead of the (ptraced) process itself.
>=20
> So Anton, can you move the _tlbie() call up to
>=20
> && !test_bit(PG_arch_1, &page->flags)) {
> <---------- HERE
> if (vma->vm_mm =3D=3D current->active_mm)
> __flush_dcache_icache((void *) address);
> else
> flush_dcache_icache_page(page);
> set_bit(PG_arch_1, &page->flags);
>=20
> So that it covers both cases instead of just (vma->vm_mm =3D=3D=20
> current->active_mm) ?
>=20
> Its safe to do it because the address space ID is ignored by tlbie=20
> accordingly
> to the manual page:
>=20
> The ASID value in the entry is ignored for the purpose of
> matching an invalidate address, thus multiple entries can be invalidated
> if they have the same effective address and different ASID values.



Well, unfortunately, that doesn't work :(. If i'm right, the=20
__flush_dcache_icache((void *) address) should avoid that the cache says=20
faulting address again.
The flush_dcache_icache_page(page) should flush the cache, where stands,=20
page not mapped. but the flush_dcache_icache_page(page) oopses on my system=
.=20
but instead of this call, the call __flush_dcache_icache(page_address(page)=
)=20
works. for me, that also makes more sence. and also, the=20
flush_dcache_icache_page(page) calls the flush_dcache_icache_phys, which=20
turns off the data virtual address mapping. i found that a bit strange. any=
=20
comments?

------=_Part_278_26635838.1121420547509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Yep, just th=
at now its the ptraceing process which is faulting in the page,<br>instead =
of the (ptraced) process itself.
<br><br>So Anton, can you move the _tlbie() call up to<br><br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;&amp;
!test_bit(PG_arch_1, &amp;page-&gt;flags)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;----------
HERE<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;if
(vma-&gt;vm_mm =3D=3D current-&gt;active_mm)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;__flush_dcache_icache((void
*) address);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flush_dcache_ic=
ache_page(page);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;set_bit(PG_arch_1,
&amp;page-&gt;flags);<br><br>So that it covers both cases instead of just (=
vma-&gt;vm_mm =3D=3D current-&gt;active_mm) ?<br><br>Its safe to do it beca=
use the address space ID is ignored by tlbie accordingly<br>to the manual p=
age:
<br><br>The ASID value in the entry is ignored for the purpose of<br>matchi=
ng an invalidate address, thus multiple entries can be invalidated<br>if th=
ey have the same effective address and different ASID values.</blockquote>
<div><br>
<br>
Well, unfortunately, that doesn't work :(. If i'm right, the
__flush_dcache_icache((void *) address) should avoid that the cache
says faulting address again.<br>
The flush_dcache_icache_page(page) should flush the cache, where
stands, page not mapped. but the flush_dcache_icache_page(page) oopses
on my system. but instead of this call, the call
__flush_dcache_icache(page_address(page)) works. for me, that also
makes more sence. and also, the flush_dcache_icache_page(page) calls
the flush_dcache_icache_phys, which turns off the data virtual address
mapping. i found that a bit strange. any comments? <br>
</div></div><br>

------=_Part_278_26635838.1121420547509--
