Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D44DFDDF34
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 11:15:28 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Date: Fri, 11 May 2007 21:14:57 -0400
References: <200705092203.26042.rob@landley.net>
	<20070510172806.GE4452@austin.ibm.com>
In-Reply-To: <20070510172806.GE4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705112114.58053.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 May 2007 1:28 pm, Linas Vepstas wrote:
> Hi Rob,
> 
> On Wed, May 09, 2007 at 10:03:25PM -0400, Rob Landley wrote:
> > I've been puttering around with my Firmware Linux project trying to add
> > powerpc as a supported platform.  I can build kernels that qemu can boot 
(such
> > as a "prep" kernel) using ARCH=ppc, but that one doesn't support make
> > headers_install.
> > 
> > Using ARCH=powerpc makes headers_install work, but there's no 
kernel .config 
> > I've been able to come up with that generates a kernel I can boot under 
qemu.
> 
> Hmm. I'm not a boot expert, (although many people on this list are). 
> Any hint of where the boot is failing?  Maybe qemu is not setting up
> a device tree? 

How about "not building a prep kernel at all"?

The Open Hackware bootloader used by QEMU insists on a boot partition, even 
when I use "-kernel" to use the built-in bootloader.  But the prep kernel is 
apparently formatted to look like a boot partition, or close enough for the 
firmware to recognize it.  (The macintosh-style kernels require a hard drive 
image in order for the firmware to like them.  So I can't boot one of those 
with "qemu -kernel filename" even if I build it right.)

Rob
