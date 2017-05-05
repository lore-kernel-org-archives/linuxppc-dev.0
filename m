Return-Path: <khoroshilov@ispras.ru>
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.45])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wKS2K06PDzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 08:56:56 +1000 (AEST)
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ldv-project@linuxtesting.org
Subject: Is iounmap(NULL) safe or not?
Date: Sat,  6 May 2017 01:50:08 +0300
Message-Id: <1494024608-10343-1-git-send-email-khoroshilov@ispras.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

It seems thare are many places where code assumes iounmap(NULL) is safe.
Also there are several patches that state it explicitly:
  ff6defa6a8fa ("ALSA: Deletion of checks before the function call "iounmap")
  e24bb0ed8179 ("staging: dgnc: remove NULL test")

At the same time it seems PPC implementation generates a warning in this case:
  3bfafd6b136b ("netxen: avoid invalid iounmap")

  arch/powerpc/mm/pgtable_64.c:
	if ((unsigned long)addr < ioremap_bot) {
		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
		       " at 0x%p\n", addr);
		return;
	}

Could you please clarify if iounmap(NULL) safe or not.
I guess it would be less errorprone if the answer is architecture independent.

--
Thank you,
Alexey Khoroshilov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
