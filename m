Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E4868DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:09:07 +1100 (EST)
Date: Wed, 13 Feb 2008 17:09:38 -0800 (PST)
Message-Id: <20080213.170938.34536425.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4]: Respun LMB patches.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I've taken into consideration the various feedback, and
ported the bug fix and other LMB patches posted recently
in an effort to keep the patch churn by others down wrt.
my moving of these files.

1) Use HAVE_LMB as suggested by Sam.

2) Fix potential build errors wrt. asm/prom.h dependencies.

   My algorithm was:

   a) If the file only included asm/lmb.h I added an include
      of both linux/lmb.c and asm/prom.h

   b) If the file already includes asm/prom.h, I merely
      changed the asm/lmb.h to linux/lmb.h

   Header include mimimizations can be done as followon patches.

3) Integrate Kumar Gala's initial region fix.

4) Integrate Becky Bruce's large physical addressing change,
   but using u64 instead of phys_addr_t.

It's all at:

	master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git

like before.
