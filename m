Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id A5AE7B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 10:16:28 +1000 (EST)
Date: Wed, 1 Jun 2011 17:16:23 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
In-Reply-To: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
Message-ID: <alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: zajec5@gmail.com, linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 May 2011 at 16:50, Christian Kujau wrote:
> trying to boot 3.0-rc1 on powerpc32 only progresses until:
> 
>   > Kernel virtual memory layout:
>   >   * 0xfffcf000..0xfffff000  : fixmap

After hours (and hours!) of git-bisecting, it said:

-----------------------
ccc7c28af205888798b51b6cbc0b557ac1170a49 is the first bad commit
commit ccc7c28af205888798b51b6cbc0b557ac1170a49
Author: Rafał Miłecki <zajec5@gmail.com>
Date:   Fri Apr 1 13:26:52 2011 +0200

    ssb: pci: implement serdes workaround
    
    Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>
-----------------------

When I reverted this one from the gi-bisected tree, the box continued to 
boot (until it got stuck again during IDE/CDROM init, but that may be a 
different story). I'l; try to revert this from a vanilla 3.0-rc1 and see 
if it helps

Thanks,
Christian.

Full gist-bisect-log: http://nerdbynature.de/bits/3.0-rc1/

> And then the system hangs, does not respond to keyboard (sysrq does not 
> seem to work on this PowerBook G4). But after a while the system reboots 
> itself, so I guess the machine panicked but did not print anything on the 
> screen.
> 
> Full messages (picture), config & (working) dmesg:
> 
>    http://nerdbynature.de/bits/3.0-rc1/
> 
-- 
BOFH excuse #406:

Bad cafeteria food landed all the sysadmins in the hospital.
