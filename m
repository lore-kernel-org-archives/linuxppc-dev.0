Return-Path: <csnook@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 60B6A474C1
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 05:18:38 +1100 (EST)
Message-ID: <4902116B.50509@redhat.com>
Date: Fri, 24 Oct 2008 14:18:19 -0400
From: Chris Snook <csnook@redhat.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: default IRQ affinity change in v2.6.27 (breaking several SMP
	PPC	based systems)
References: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>	<4901E6FB.4070200@redhat.com>	<36A821E7-7F37-42AF-9A05-7205FCBF89EE@kernel.crashing.org>	<4901F31E.9040007@redhat.com>
	<5967704E-0117-46B8-8505-6A002502C38C@kernel.crashing.org>
	<4902086E.6030900@freescale.com>
In-Reply-To: <4902086E.6030900@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC-dev list <linuxppc-dev@ozlabs.org>, tglx@linutronix.de,
	maxk@qualcomm.com, linux-kernel Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Kumar Gala wrote:
>> So why not just have x86 startup code set irq_default_affinity = 
>> CPU_MASK_ALL than?
> 
> That doesn't really solve the problem, as a user could still manually 
> set an invalid affinity.  The MPIC driver should reduce the affinity 
> itself to what the hardware can handle.

Does the MPIC code actually allow that to happen?  I can't quite tell, but I 
noticed this:

[csnook@bernoulli sysdev]$ fgrep '#ifdef CONFIG_' mpic.c | sort -u
#ifdef CONFIG_IRQ_ALL_CPUS
#ifdef CONFIG_MPIC_BROKEN_REGREAD
#ifdef CONFIG_MPIC_U3_HT_IRQS
#ifdef CONFIG_MPIC_WEIRD
#ifdef CONFIG_PCI_MSI
#ifdef CONFIG_PM
#ifdef CONFIG_PPC32     /* XXX for now */
#ifdef CONFIG_PPC_DCR
#ifdef CONFIG_SMP

Do any of those config options (or combinations thereof) imply an MPIC that 
can't handle an IRQ masked to multiple CPUs?  If so, this can be fixed rather 
easily at build time, without having to muck around with arch-specific 
initialization code.

-- Chris
