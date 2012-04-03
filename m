Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id B2027B6FD9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 04:53:39 +1000 (EST)
Date: Tue, 3 Apr 2012 11:53:34 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.4.0-rc1: No init found
In-Reply-To: <alpine.DEB.2.01.1204030953320.4930@trent.utfs.org>
Message-ID: <alpine.DEB.2.01.1204031150180.4930@trent.utfs.org>
References: <alpine.DEB.2.01.1204030008080.4930@trent.utfs.org>
 <1333440522.3040.9.camel@pasglop>
 <alpine.DEB.2.01.1204030953320.4930@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 3 Apr 2012 at 10:18, Christian Kujau wrote:
> > > PS: Unfortunately I cannot boot into the old (3.3-rc7) kernel 
> > >     right now (which is still installed via "yaboot" and present in
> > >     /boot), because of this: 
> > >     http://nerdbynature.de/bits/3.4.0-rc1/init/mac-invalid-memory.JPG
> > >     Booting into Debian's "squeeze" kernel (2.6.32) which resides in
> > >     the same /boot directory succeeds.
> > 

FYI, upgrading to yaboot 1.3.16-4 from Debian/testing did the trick, I can 
now boot the "old" (3.3.0) kernel[0].

The "No init found" problem with 3.4.0-rc1 remains of course :-\

Thanks,
Christian.

[0] http://nerdbynature.de/bits/3.4.0-rc1/init/yaboot.conf.txt
    http://nerdbynature.de/bits/3.4.0-rc1/init/ls-boot.txt

> > Hrm, did it used to boot ?
> 
> I'm using the "backup" kernel only when the new one has an issue, so I 
> have not tested it for a while, but it used to work, for sure.
> 
> > Can you do printenv in OF and tell me what
> > your load-base, real-base, virt-base etc... are ?
> 
> load-base is 0x800000, real-base and virt-base is set to "-1", please see
> http://nerdbynature.de/bits/3.4.0-rc1/init/printenv-1.JPG
> 
> Not sure if this is related, but at the end of each kernel compilation, 
> the following messages are printed:
> 
> ------------
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   WRAP    arch/powerpc/boot/zImage.pmac
> INFO: Uncompressed kernel (size 0x6e52f8) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x700000)
>   WRAP    arch/powerpc/boot/zImage.coff
> INFO: Uncompressed kernel (size 0x6e52f8) overlaps the address of the wrapper(0x500000)
> INFO: Fixing the link_address of wrapper to (0x700000)
>   WRAP    arch/powerpc/boot/zImage.miboot
> INFO: Uncompressed kernel (size 0x6d4b80) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x700000)
>   Building modules, stage 2.
>   MODPOST 24 modules
> ------------
> 
> I started to see these messages in January (around Linux 3.2.0), but never 
> investigated what it was since the produced kernels continued to boot just 
> fine.
> 
> > Might also be worth updating yaboot, debian should have 1.3.16 nowadays.
> 
> Debian/stable still has 1.3.13a, I'll try to install 1.3.16 from 
> Debian/testing.
> 
> Thanks for your help,
> Christian.
-- 
BOFH excuse #372:

Forced to support NT servers; sysadmins quit.
