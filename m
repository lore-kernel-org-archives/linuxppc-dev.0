Return-Path: <ben.menchaca@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id 809FCDDF6F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 16:38:28 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so237994ele.3
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 21:38:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
Date: Thu, 5 Mar 2009 23:38:25 -0600
Message-ID: <64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Ben Menchaca <ben.menchaca@gmail.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: multipart/alternative; boundary=002215046c8b9697d704646cb1c8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--002215046c8b9697d704646cb1c8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

1.  BAT2 in linux is set to WIMG=0010, and covers all 64M
2.  PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): 0x1020
3.  PEX_xDMA_CTRL is set to 0x00000401 at the initiation of the DMA.
4.  OWAR0 is set to 0xFFFFF005, so NSNP is 0.
5.  The DMA descriptor (randomly chosen when I hit a trigger...just ignore
the size...) contains 0002AFF3 at offset 0, so nosnoops are cleared.

Core is 400MHz, and CSB is 133MHz.

- Ben

On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:

> and what settings  is DMA description bit 3?
>
> > -----Original Message-----
> > From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
> > [mailto:linuxppc-dev-bounces+daveliu <linuxppc-dev-bounces%2Bdaveliu>=
> freescale.com@ozlabs.org]
> >  On Behalf Of Liu Dave-R63238
> > Sent: Friday, March 06, 2009 1:22 PM
> > To: Ben Menchaca; linuxppc-dev@ozlabs.org
> > Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
> >
> > Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and
> > PEX_RDMA_CTRL[SNOOP]?
> >
> > What is the freq settings? CORE/CSB bus.
> >
> > Thanks, Dave
> >
> > ________________________________
> >
> >       From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
> > [mailto:linuxppc-dev-bounces+daveliu <linuxppc-dev-bounces%2Bdaveliu>=
> freescale.com@ozlabs.org]
> >  On Behalf Of Ben Menchaca
> >       Sent: Friday, March 06, 2009 12:33 PM
> >       To: linuxppc-dev@ozlabs.org
> >       Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
> >
> >
> >       I am working on a Freescale 8314e design, and the
> > embedded device is configured as a PCI-e endpoint running a
> > 2.6.27-5 kernel.  For context, we have written a kernel
> > module which, among other things, uses the RDMA/WDMA engine
> > in the PCI-e IP block.  On the host side, these DMAs are
> > coherent.  However, on the embedded side, things are quite a
> > bit less rosy; we must manually flush/invalidate cache lines
> > for WDMA/RDMAs to occur successfully.  After speaking with
> > (several) FAEs at Freescale, we believe there is a
> > configuration issue that is the cause, but we have yet to
> > have anyone successfully point to it.
> >
> >       Disabling the data cache altogether resolves the issue
> > entirely, but of course, also completely tanks performance.
> > As a temporary workaround, I would like to simply mark the
> > pages (obtained currently via dma_alloc_coherent) involved as
> > cache-inhibited.  I have attempted to do this via some
> > snippets remaining in fec.c (va_to_pte, uncache_pte to set
> > _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is
> > almost certainly braindead; va_to_pte is not a part of the
> > 83xx source, as far as I can tell; 8xx only.
> >
> >       A quick pointer in the correct direction for marking
> > pages as cache-inhibited on a 2.6.27-5 kernel would be
> > appreciated, or if my approach to a workaround is flawed, a
> > pointer to the correct way would be great.
> >
> >       Ben Menchaca
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
>

--002215046c8b9697d704646cb1c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-s=
ize: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-famil=
y: Tahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;"><font sty=
le=3D"font-size: 10pt; font-family: Tahoma;">1.=A0 BAT2 in linux is set to =
WIMG=3D0010, and covers=20
all 64M<br>2.=A0 PEX_DEVICE_CONTROL in PCI-E Config Space (0x54):=20
0x1020<br>3.=A0 PEX_xDMA_CTRL is set to <span></span>0x00000401 at the init=
iation of the=20
DMA.<br>4.=A0 OWAR0 is set to 0xFFFFF005, so NSNP is 0.<br>5.=A0
The DMA descriptor (randomly chosen when I hit a trigger...just ignore
the size...) contains 0002AFF3 at offset 0, so nosnoops are cleared.</font>=
</font></font></font></font><font style=3D"font-size: 10pt; font-family: Ta=
homa;"><font style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D=
"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; fon=
t-family: Tahoma;">=A0 <br>

<br>Core is 400MHz, and CSB is 133MHz.</font></font></font></font><br><font=
 color=3D"#888888"><br>- Ben<br></font><br><div class=3D"gmail_quote">On Th=
u, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238 <span dir=3D"ltr">&lt;<a href=
=3D"mailto:DaveLiu@freescale.com">DaveLiu@freescale.com</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">and what settings=
 =A0is DMA description bit 3?<br>
<div class=3D"im"><br>
&gt; -----Original Message-----<br>
&gt; From: linuxppc-dev-bounces+daveliu=3D<a href=3D"http://freescale.com" =
target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" target=3D=
"_blank">ozlabs.org</a><br>
&gt; [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu">linuxppc-dev=
-bounces+daveliu</a>=3D<a href=3D"http://freescale.com" target=3D"_blank">f=
reescale.com</a>@<a href=3D"http://ozlabs.org" target=3D"_blank">ozlabs.org=
</a>]<br>

</div><div><div></div><div class=3D"h5">&gt; =A0On Behalf Of Liu Dave-R6323=
8<br>
&gt; Sent: Friday, March 06, 2009 1:22 PM<br>
&gt; To: Ben Menchaca; <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-=
dev@ozlabs.org</a><br>
&gt; Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited<br>
&gt;<br>
&gt; Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and<br>
&gt; PEX_RDMA_CTRL[SNOOP]?<br>
&gt;<br>
&gt; What is the freq settings? CORE/CSB bus.<br>
&gt;<br>
&gt; Thanks, Dave<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; =A0 =A0 =A0 From: linuxppc-dev-bounces+daveliu=3D<a href=3D"http://fre=
escale.com" target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.or=
g" target=3D"_blank">ozlabs.org</a><br>
&gt; [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu">linuxppc-dev=
-bounces+daveliu</a>=3D<a href=3D"http://freescale.com" target=3D"_blank">f=
reescale.com</a>@<a href=3D"http://ozlabs.org" target=3D"_blank">ozlabs.org=
</a>]<br>

&gt; =A0On Behalf Of Ben Menchaca<br>
&gt; =A0 =A0 =A0 Sent: Friday, March 06, 2009 12:33 PM<br>
&gt; =A0 =A0 =A0 To: <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-de=
v@ozlabs.org</a><br>
&gt; =A0 =A0 =A0 Subject: 83xx: Marking or Allocating Pages as Cache-Inhibi=
ted<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 I am working on a Freescale 8314e design, and the<br>
&gt; embedded device is configured as a PCI-e endpoint running a<br>
&gt; 2.6.27-5 kernel. =A0For context, we have written a kernel<br>
&gt; module which, among other things, uses the RDMA/WDMA engine<br>
&gt; in the PCI-e IP block. =A0On the host side, these DMAs are<br>
&gt; coherent. =A0However, on the embedded side, things are quite a<br>
&gt; bit less rosy; we must manually flush/invalidate cache lines<br>
&gt; for WDMA/RDMAs to occur successfully. =A0After speaking with<br>
&gt; (several) FAEs at Freescale, we believe there is a<br>
&gt; configuration issue that is the cause, but we have yet to<br>
&gt; have anyone successfully point to it.<br>
&gt;<br>
&gt; =A0 =A0 =A0 Disabling the data cache altogether resolves the issue<br>
&gt; entirely, but of course, also completely tanks performance.<br>
&gt; As a temporary workaround, I would like to simply mark the<br>
&gt; pages (obtained currently via dma_alloc_coherent) involved as<br>
&gt; cache-inhibited. =A0I have attempted to do this via some<br>
&gt; snippets remaining in fec.c (va_to_pte, uncache_pte to set<br>
&gt; _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is<br>
&gt; almost certainly braindead; va_to_pte is not a part of the<br>
&gt; 83xx source, as far as I can tell; 8xx only.<br>
&gt;<br>
&gt; =A0 =A0 =A0 A quick pointer in the correct direction for marking<br>
&gt; pages as cache-inhibited on a 2.6.27-5 kernel would be<br>
&gt; appreciated, or if my approach to a workaround is flawed, a<br>
&gt; pointer to the correct way would be great.<br>
&gt;<br>
&gt; =A0 =A0 =A0 Ben Menchaca<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>=
<br>
&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D=
"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
&gt;<br>
&gt;<br>
</blockquote></div><br>

--002215046c8b9697d704646cb1c8--
