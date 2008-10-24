Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DABFDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 23:45:58 +1100 (EST)
Message-Id: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: maxk@qualcomm.com
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: default IRQ affinity change in v2.6.27 (breaking several SMP PPC
	based systems)
Date: Fri, 24 Oct 2008 07:45:42 -0500
Cc: LinuxPPC-dev list <linuxppc-dev@ozlabs.org>, tglx@linutronix.de,
	linux-kernel Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It appears the default IRQ affinity changes from being just cpu 0 to  
all cpu's.  This breaks several PPC SMP systems in which only a single  
processor is allowed to be selected as the destination of the IRQ.

What is the right answer in fixing this?  Should we:

	cpumask_t irq_default_affinity = 1;

instead of

	cpumask_t irq_default_affinity = CPU_MASK_ALL?

- k
