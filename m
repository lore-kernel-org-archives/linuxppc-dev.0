Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9302EB6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 01:41:01 +1000 (EST)
Date: Thu, 14 Jul 2011 17:40:42 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH v2] powerpc32: Kexec support for PPC440X chipsets
Message-ID: <20110714154042.GA14975@linutronix.de>
References: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
Cc: kexec <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Suzuki K. Poulose | 2011-07-12 12:14:16 [+0530]:

>Changes from V1: Uses a tmp mapping in the other address space to setup
>		 the 1:1 mapping (suggested by Sebastian Andrzej Siewior).
>
>Note: Should we do the same for kernel entry code for PPC44x ?

You have one the kernel mapping. Then you make your temporary mapping
which might be just the one valid TLB entry (after you invalidated the
others). After that you setup multiple mappings to cover 0..2GiB address
space. Since the kernel runs at 0xC.... and you need 0x0.. for the same
memory you end up at some point with two mappings for the same memory.
The reference manual says one should not have two active mappings for
piece of memory. That is why the "other address space" is should be
used.
So I think using this "other address space" for the entry code isn't a
bad idea.

However, I'm fine with this patch.

Sebastian
