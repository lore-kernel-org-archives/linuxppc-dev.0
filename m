Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B4E62C009C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 00:17:55 +1100 (EST)
Date: Sun, 15 Dec 2013 13:59:33 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Hong H. Pham" <hong.pham@windriver.com>
Subject: Re: [PATCH v3] powerpc: Fix PTE page address mismatch in pgtable
 ctor/dtor
Message-ID: <20131215125933.GB31090@linutronix.de>
References: <874n6muuw4.fsf@linux.vnet.ibm.com>
 <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Hong H. Pham | 2013-12-07 09:06:33 [-0500]:

>On PPC32, only SMP kernels are affected.
>
>On PPC64, only SMP kernels with 4K page size are affected.

$ uname -a
Linux mpc8536-1 3.12.1-rt3-00281-g9de268d #76 SMP PREEMPT RT Fri Nov 22 16:53:05 CET 2013 ppc GNU/Linux
$ uptime
 22:01:10 up 22 days, 21:01,  1 user,  load average: 443.08, 563.59, 586.20

This is from a mpc8536 box. The high load comes from a hackbench that was
running for quite some time. Are Book-E (CONFIG_PPC_BOOK3E_MMU without
CONFIG_PPC_BOOK3E set) not affected or is this bug not present if a SMP
kernel is booted on a UP machine?

Sebastian
