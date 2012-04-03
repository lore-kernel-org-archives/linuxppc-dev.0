Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 89A3DB6FD9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 18:08:39 +1000 (EST)
Message-ID: <1333440522.3040.9.camel@pasglop>
Subject: Re: 3.4.0-rc1: No init found
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Tue, 03 Apr 2012 18:08:42 +1000
In-Reply-To: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
References: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-03 at 00:20 -0700, Christian Kujau wrote:
> Going from 3.3-rc7 to 3.4-rc1 (with "make oldconfig" inbetween) did not 
> go well on this PowerBook G4 machine:
> 
> Apr  2 15:18:23 [   8.318816] EXT4-fs (hda6): mounted filesystem with ordered data mode. Opts: (null)
> Apr  2 15:18:23 [   8.320286] VFS: Mounted root (ext4 filesystem) readonly on device 3:6.
> Apr  2 15:18:23 [   8.341555] devtmpfs: mounted
> Apr  2 15:18:23 [   8.343384] Freeing unused kernel memory: 204k freed
> Apr  2 15:18:23 [   8.457056] Kernel panic - not syncing: No init found.  Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.
> Apr  2 15:18:23 [   8.459936] Rebooting in 180 seconds..

I have observed this randomly on the G5 ... sometimes, if I try again,
it works... it's very very odd. There is some kind of race maybe with
async startup ? Or a problem with the vfs path walking ? It's certainly
not easily reproducable for me, it goes away from one boot to the next.

It also happens sometimes with an initramfs (cpio), it's not specific to
ext{2,3,4}.

Cheers,
Ben.

> No bootoptions were changed, no disks swapped, no partitions altered 
> whatsoever. Full .config & dmesg:
> 
>  http://nerdbynature.de/bits/3.4.0-rc1/init/
> 
> Thanks,
> Christian.
> 
> PS: Unfortunately I cannot boot into the old (3.3-rc7) kernel 
>     right now (which is still installed via "yaboot" and present in
>     /boot), because of this: 
>     http://nerdbynature.de/bits/3.4.0-rc1/init/mac-invalid-memory.JPG
>     Booting into Debian's "squeeze" kernel (2.6.32) which resides in
>     the same /boot directory succeeds.

Hrm, did it used to boot ? Can you do printenv in OF and tell me what
your load-base, real-base, virt-base etc... are ?

Might also be worth updating yaboot, debian should have 1.3.16 nowadays.

Cheers,
Ben.
