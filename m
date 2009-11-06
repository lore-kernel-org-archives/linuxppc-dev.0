Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 58EFFB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 03:34:38 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Chris Friesen <cfriesen@nortel.com>
Date: Fri, 6 Nov 2009 09:34:30 -0700
Subject: RE: DMA to User-Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0331031240@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
	<4AF0E4A0.30802@windriver.com>
	<BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F033103030E@midas.usurf.usu.edu>
	<4AF3BCC4.6070702@nortel.com>
In-Reply-To: <4AF3BCC4.6070702@nortel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Bo.Liu@windriver.com" <Bo.Liu@windriver.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > One more question about this approach: does the mmap() call
> prevent
> > the kernel from using this memory for other purposes?  Will the
> > kernel be able to "move" this memory elsewhere?  I guess what I am
> > asking is if this memory is locked for all other purposes?
>=20
> You've allocated the memory in the kernel and mapped it to
> userspace.
> If the kernel uses that memory for anything else it will be visible
> to
> userspace.

So, does that mean that the kernel could use that memory for something else=
?  I was under the impression that locking the memory prevented the kernel =
from swapping it out, moving it, *and* using it for other purposes.

This memory that I am mapping is reserved for DMA buffers.  If anything els=
e uses it, then that will corrupt my buffer and make it worthless.  So basi=
cally I want user space to tell the kernel that that portion of memory is o=
ut of bounds.  Is that possible?

Thanks,

Jonathan
