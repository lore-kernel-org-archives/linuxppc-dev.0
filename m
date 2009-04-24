Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 97504DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 20:50:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable
	drivers for Microblaze
Date: Fri, 24 Apr 2009 12:49:48 +0200
References: <764365e7af2e476e43cd674738e51f13b306979b.1239874968.git.monstr@monstr.eu>
	<fa686aa40904200748t4fc0b623naf7fd8c34a743733@mail.gmail.com>
	<1d3f23370904201924n4ab592cdq49a4a4c8ec78d1df@mail.gmail.com>
In-Reply-To: <1d3f23370904201924n4ab592cdq49a4a4c8ec78d1df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-00=_NlZ8Jr6788VPglS"
Message-Id: <200904241249.49870.arnd@arndb.de>
Cc: Stephen Neuendorffer <stephenn@xilinx.com>, linux-kernel@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, John Linn <John.Linn@xilinx.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_NlZ8Jr6788VPglS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tuesday 21 April 2009, John Williams wrote:
> Some (most?) of the Xilinx drivers currently have this construct:
> 
> #ifdef CONFIG_OF
> 
> // probe using OF
> 
> #else

If there are multiple ways of detecting the device, then
the driver should be compilable on any system that allows
either one.

At the very least, it should be restricted to CONFIG_HAS_IOMEM,
which is probably required for any of these, but not provided
on stuff like UML or s390.

Drivers that use of_* functions unconditionally need to
depend on CONFIG_OF.

Also, some of the xilinx drivers apparantly use DCR, which in turn is
only defined when you have CONFIG_PPC_DCR, and these
have so far only been used on powerpc. If other architectures
start using DCR (I hope that never happens), we will need a
global CONFIG_DCR option.

	Arnd <><

--Boundary-00=_NlZ8Jr6788VPglS
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'DejaVu Sans Light'; font-size:8pt; font-weight:200; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Tuesday 21 April 2009, John Williams wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Some (most?) of the Xilinx drivers currently have this construct:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; #ifdef CONFIG_OF</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; // probe using OF</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; #else</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">If there are multiple ways of detecting the device, then</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">the driver should be compilable on any system that allows</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">either one.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">At the very least, it should be restricted to CONFIG_HAS_IOMEM,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">which is probably required for any of these, but not provided</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">on stuff like UML or s390.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Drivers that use of_* functions unconditionally need to</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">depend on CONFIG_OF.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Also, some of the xilinx drivers apparantly use DCR, which in turn is</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">only defined when you have CONFIG_PPC_DCR, and these</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">have so far only been used on powerpc. If other architectures</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">start using DCR (I hope that never happens), we will need a</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">global CONFIG_DCR option.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	Arnd &lt;&gt;&lt;</p></body></html>
--Boundary-00=_NlZ8Jr6788VPglS--
