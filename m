Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C0BB1A0BF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 18:59:04 +1100 (AEDT)
Message-ID: <1419321529.5581.181.camel@freescale.com>
Subject: Re: Ask help about killing irqchip.irq_print_chip on PPC platforms
From: Scott Wood <scottwood@freescale.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Date: Tue, 23 Dec 2014 01:58:49 -0600
In-Reply-To: <5499204B.4040808@linux.intel.com>
References: <54991DE5.5090805@linux.intel.com>
 <5499204B.4040808@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Tudor Laurentiu <b10716@freescale.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-23 at 15:56 +0800, Jiang Liu wrote:
> Hi Scott and Tudor,
> 	Sorry, resend and Ccing the list.

Resending reply...

> 	We are trying to clean up some irqchip interfaces, and
> irqchip.irq_print_chip is a candidate for removal. After some
> changes on x86 side, arch/powerpc/sysdev/fsl_msi.c may be the
> last user of irqchip.irq_print_chip. So could you please help
> to advice on whether we could kill irqchip.irq_print_chip
> by using "fsl-msi" instead of "fsl-msi-%d" for irqchip name?
> Will it break any userspace interfaces?
> Thanks!
> Gerry

fsl-msi-%d was introduced to allow userspace to identify the cascade
interrupt belonging to a particular MSI, for the purpose of setting
affinity, as this cannot be done on the MSI itself due to hardware
limitations.

Removing it would not exactly eliminate a lot of code or complexity...

-Scott
