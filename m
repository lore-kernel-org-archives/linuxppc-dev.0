Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F249DDDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 08:53:09 +1100 (EST)
Message-ID: <47757040.4020508@am.sony.com>
Date: Fri, 28 Dec 2007 13:53:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: torvalds@linux-foundation.org
Subject: Re: Please pull powerpc.git merge branch
References: <18292.49574.906807.484581@cargo.ozlabs.ibm.com>
In-Reply-To: <18292.49574.906807.484581@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, rrnelson@linux.vnet.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Linus,
> 
> Please do
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge


This broke Cell builds.

arch/powerpc/platforms/cell/spufs/sched.c:200: multiple definition of `.notify_spus_active'
arch/powerpc/platforms/cell/spu_syscalls.c:149: first defined here


commit aed3a8c9bb1a8623a618232087c5ff62718e3b9a
Author: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Date:   Sat Dec 15 01:27:30 2007 +1100

    [POWERPC] Oprofile: Remove dependency on spufs module


Looking at the code, it seems just when CONFIG_SPU_FS=y, not when =m.

I'll try to make a fix.

-Geoff
