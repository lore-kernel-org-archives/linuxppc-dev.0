Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 2A289B7B96
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 03:56:55 +1100 (EST)
Date: Thu, 15 Oct 2009 09:56:50 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Message-ID: <20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/head_8xx.o: In function `FixupDAR':
/home/rfeany/src/lnxnm/linux-dev/arch/powerpc/kernel/head_8xx.S:576: undefined reference to `DARfix'

With all of your patches applied I have this problem:

open("/proc/mounts", O_RDONLY)          = 3
fstat64(0x3, 0x7fc6ad58)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001f000
read(3, 0x3001f000, 1024)               = -1 EFAULT (Bad address)
exit_group(0)                           = ?

but it works fine with /dev/zero:

open("/dev/zero", O_RDONLY)             = 3
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30001000
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024

If I revert "8xx: start using dcbX instructions in various copy
routines" then it works again. I think it is the cache instructions
added to __copy_tofrom_user: reading from /dev/zero is OK (it uses
__clear_user, no dcbX), but copy_to_user() fails.

It seems stable with all but the dcbX patch applied. I haven't been able
to crash it yet, anyway :)

take care!
/rex.
