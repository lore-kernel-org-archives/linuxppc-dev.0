Return-Path: <dwm@enoyolf.org>
Received: from bebe.enoyolf.org (bebe.enoyolf.org [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bebe.enoyolf.org",
	Issuer "CA Cert Signing Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B8B3DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 13:13:26 +1000 (EST)
In-reply-to: <200705112146.35495.rob@landley.net> 
References: <200705092203.26042.rob@landley.net>
	<20070510172806.GE4452@austin.ibm.com>
	<464397B8.408@genesi-usa.com> <200705112146.35495.rob@landley.net>
To: Rob Landley <rob@landley.net>
Subject: Re: Building ppc/powerpc kernel to run under QEMU. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2007 22:00:57 -0500
Message-ID: <14699.1178938857@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 11 May 2007 21:46:35 EDT, Rob Landley wrote:
> On Thursday 10 May 2007 6:07 pm, Matt Sealey wrote:
> > QEMU really really wants a PREP kernel, and that stuff's just not in the new
> > arch/powerpc tree anymore is it?
> 
> In theory I could feed it a power mac kernel, but I'd have to create a 
> partitioned hard drive image to satisfy open hackware.  A prep kernel fakes 
> being a partitioned image sufficiently that I can use -kernel to boot.
> 
> > I'd love to see the device tree once QEMU's kernel has booted :D
> 
> So would I. :)
> 
> I'm told they've got that part working.  I once managed to get a powerpc 
> Ubuntu ISO image to boot under qemu, I just can't _build_ a kernel that does.  
> (I have no idea how to create the specially partitioned hard drive image it 
> wants, and since I got 5 other architectures working without needing to do 
> that, I'm looking for a way to make a prep kernel work so I won't have to.)

Have you tried to use parted (or fdisk) to set the first partition table
entry as type 0x41?   I personally have no experience with qemu, but do
fiddle with loading images with the real IBM firmware (a lot).  

What I usually end up doing is dd'ing a bootloader into the appropriate
sized 0x41 partition.  Am pretty sure no GPL stuff groks PREP partitions
per se, other than seeing the part type.

AIX stores its kernel in the PREP part, and boots from that partition
(no bootloader, loads kernel directly).



++doug
