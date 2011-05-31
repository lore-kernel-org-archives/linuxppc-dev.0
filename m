Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id A4C1FB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 09:57:56 +1000 (EST)
Date: Tue, 31 May 2011 16:50:36 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
Message-ID: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

trying to boot 3.0-rc1 on powerpc32 only progresses until:

  > Kernel virtual memory layout:
  >   * 0xfffcf000..0xfffff000  : fixmap

And then the system hangs, does not respond to keyboard (sysrq does not 
seem to work on this PowerBook G4). But after a while the system reboots 
itself, so I guess the machine panicked but did not print anything on the 
screen.

Full messages (picture), config & (working) dmesg:

   http://nerdbynature.de/bits/3.0-rc1/

I'm currently trying to bisect this, so far I have:

----------------------
git bisect start
# good: [61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf] Linux 2.6.39
git bisect good 61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf
# bad: [55922c9d1b84b89cb946c777fddccb3247e7df2c] Linux 3.0-rc1
git bisect bad 55922c9d1b84b89cb946c777fddccb3247e7df2c
# bad: [c44dead70a841d90ddc01968012f323c33217c9e] Merge branch 'usb-next' 
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6
git bisect bad c44dead70a841d90ddc01968012f323c33217c9e
# bad: [d93515611bbc70c2fe4db232e5feb448ed8e4cc9] macvlan: fix panic if 
lowerdev in a bond
git bisect bad d93515611bbc70c2fe4db232e5feb448ed8e4cc9
----------------------

Any ideas?

Thanks,
Christian.
-- 
BOFH excuse #263:

It's stuck in the Web.
