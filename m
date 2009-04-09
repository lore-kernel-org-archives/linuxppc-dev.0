Return-Path: <thunderbird2k@gmail.com>
Received: from mail-bw0-f180.google.com (mail-bw0-f180.google.com
	[209.85.218.180]) by ozlabs.org (Postfix) with ESMTP id 15A7CDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 00:06:58 +1000 (EST)
Received: by bwz28 with SMTP id 28so592840bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Apr 2009 07:06:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090409124634.GF18304@zod.rchland.ibm.com>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
	<20090409124634.GF18304@zod.rchland.ibm.com>
Date: Thu, 9 Apr 2009 16:06:56 +0200
Message-ID: <c8485d470904090706t4fd2893tdeaf3710b19bd0f1@mail.gmail.com>
Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001636c5a81cc3beb004671fc2c2
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	Suneel <"[mailto:suneel.garapati@xilinx.com]"@xilinx.com>,
	akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636c5a81cc3beb004671fc2c2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Thu, Apr 9, 2009 at 2:46 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com>wrote:

> On Wed, Apr 08, 2009 at 03:11:25PM -0600, John Linn wrote:
> >From: Suneel <[mailto:suneel.garapati@xilinx.com]>
> >
> >Added support for the new xps tft controller.
> >
> >The new core has PLB interface support in addition to existing
> >DCR interface.
> >
> >The driver has been modified to support this new core which
> >can be connected on PLB or DCR bus.
> >
> >Signed-off-by: Suneel <suneelg@xilinx.com>
> >Signed-off-by: John Linn <john.linn@xilinx.com>
> >---
> > drivers/video/xilinxfb.c |  227
> ++++++++++++++++++++++++++++++++--------------
> > 1 files changed, 160 insertions(+), 67 deletions(-)
> >
> >diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> >index a82c530..a28a834 100644
> >--- a/drivers/video/xilinxfb.c
> >+++ b/drivers/video/xilinxfb.c
> >@@ -1,17 +1,24 @@
> > /*
> >- * xilinxfb.c
> >  *
> >- * Xilinx TFT LCD frame buffer driver
> >+ * Xilinx TFT frame buffer driver
> >  *
> >  * Author: MontaVista Software, Inc.
> >  *         source@mvista.com
> >  *
> >  * 2002-2007 (c) MontaVista Software, Inc.
> >  * 2007 (c) Secret Lab Technologies, Ltd.
> >+ * 2009 (c) Xilinx Inc.
> >  *
> >- * This file is licensed under the terms of the GNU General Public
> License
> >- * version 2.  This program is licensed "as is" without any warranty of
> any
> >- * kind, whether express or implied.
> >+ * This program is free software; you can redistribute it
> >+ * and/or modify it under the terms of the GNU General Public
> >+ * License as published by the Free Software Foundation;
> >+ * either version 2 of the License, or (at your option) any
> >+ * later version.
> >+ *
> >+ * You should have received a copy of the GNU General Public
> >+ * License along with this program; if not, write to the Free
> >+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
> >+ * 02139, USA.
> >  */
>
> What Stephen said.
>
> > #define NUM_REGS      2
> > #define REG_FB_ADDR   0
> >@@ -112,6 +123,11 @@ struct xilinxfb_drvdata {
> >
> >       struct fb_info  info;           /* FB driver info record */
> >
> >+      u32             regs_phys;      /* phys. address of the control
> >+                                              registers */
>
> Is this driver usable on the 440 based Xilinx devices?  If so, is it
> possible
> to have the physical address of the registers above 4GiB, so is common with
> almost all the I/O on the other 440 boards?
>
>
The driver works fine on 440 based Xilinx boards (the ML510 I use has a 440
core). It might be nice to move physical addresses above 4GB for devices but
in all Xilinx tools and reference designs addresses below 4GB are used for
periperhals and I think even below 2GB (or even below 1GB). It depends on
the design.

Roderick Colenbrander

--001636c5a81cc3beb004671fc2c2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Apr 9, 2009 at 2:46 PM, Josh Boy=
er <span dir=3D"ltr">&lt;<a href=3D"mailto:jwboyer@linux.vnet.ibm.com">jwbo=
yer@linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Wed, Apr 08, 2009 at 03:11:25PM -0600,=
 John Linn wrote:<br>
&gt;From: Suneel &lt;[mailto:<a href=3D"mailto:suneel.garapati@xilinx.com">=
suneel.garapati@xilinx.com</a>]&gt;<br>
&gt;<br>
&gt;Added support for the new xps tft controller.<br>
&gt;<br>
&gt;The new core has PLB interface support in addition to existing<br>
&gt;DCR interface.<br>
&gt;<br>
&gt;The driver has been modified to support this new core which<br>
&gt;can be connected on PLB or DCR bus.<br>
&gt;<br>
&gt;Signed-off-by: Suneel &lt;<a href=3D"mailto:suneelg@xilinx.com">suneelg=
@xilinx.com</a>&gt;<br>
&gt;Signed-off-by: John Linn &lt;<a href=3D"mailto:john.linn@xilinx.com">jo=
hn.linn@xilinx.com</a>&gt;<br>
&gt;---<br>
&gt; drivers/video/xilinxfb.c | =A0227 ++++++++++++++++++++++++++++++++----=
----------<br>
&gt; 1 files changed, 160 insertions(+), 67 deletions(-)<br>
&gt;<br>
&gt;diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c<br>
&gt;index a82c530..a28a834 100644<br>
&gt;--- a/drivers/video/xilinxfb.c<br>
&gt;+++ b/drivers/video/xilinxfb.c<br>
&gt;@@ -1,17 +1,24 @@<br>
&gt; /*<br>
&gt;- * xilinxfb.c<br>
&gt; =A0*<br>
&gt;- * Xilinx TFT LCD frame buffer driver<br>
&gt;+ * Xilinx TFT frame buffer driver<br>
&gt; =A0*<br>
&gt; =A0* Author: MontaVista Software, Inc.<br>
&gt; =A0* =A0 =A0 =A0 =A0 <a href=3D"mailto:source@mvista.com">source@mvist=
a.com</a><br>
&gt; =A0*<br>
&gt; =A0* 2002-2007 (c) MontaVista Software, Inc.<br>
&gt; =A0* 2007 (c) Secret Lab Technologies, Ltd.<br>
&gt;+ * 2009 (c) Xilinx Inc.<br>
&gt; =A0*<br>
&gt;- * This file is licensed under the terms of the GNU General Public Lic=
ense<br>
&gt;- * version 2. =A0This program is licensed &quot;as is&quot; without an=
y warranty of any<br>
&gt;- * kind, whether express or implied.<br>
&gt;+ * This program is free software; you can redistribute it<br>
&gt;+ * and/or modify it under the terms of the GNU General Public<br>
&gt;+ * License as published by the Free Software Foundation;<br>
&gt;+ * either version 2 of the License, or (at your option) any<br>
&gt;+ * later version.<br>
&gt;+ *<br>
&gt;+ * You should have received a copy of the GNU General Public<br>
&gt;+ * License along with this program; if not, write to the Free<br>
&gt;+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA<br>
&gt;+ * 02139, USA.<br>
&gt; =A0*/<br>
<br>
</div></div>What Stephen said.<br>
<div class=3D"im"><br>
&gt; #define NUM_REGS =A0 =A0 =A02<br>
&gt; #define REG_FB_ADDR =A0 0<br>
&gt;@@ -112,6 +123,11 @@ struct xilinxfb_drvdata {<br>
&gt;<br>
&gt; =A0 =A0 =A0 struct fb_info =A0info; =A0 =A0 =A0 =A0 =A0 /* FB driver i=
nfo record */<br>
&gt;<br>
&gt;+ =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 regs_phys; =A0 =A0 =A0/* phys.=
 address of the control<br>
&gt;+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0registers */<br>
<br>
</div>Is this driver usable on the 440 based Xilinx devices? =A0If so, is i=
t possible<br>
to have the physical address of the registers above 4GiB, so is common with=
<br>
almost all the I/O on the other 440 boards?<br>
<div class=3D"im"><br></div></blockquote></div><br>The driver works fine on=
 440 based Xilinx boards (the ML510 I use has a 440 core). It might be nice=
 to move physical addresses above 4GB for devices but in all Xilinx tools a=
nd reference designs addresses below 4GB are used for periperhals and I thi=
nk even below 2GB (or even below 1GB). It depends on the design.<br>
<br>Roderick Colenbrander<br>

--001636c5a81cc3beb004671fc2c2--
