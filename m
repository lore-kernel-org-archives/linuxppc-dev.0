Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8A922C0316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 08:06:36 +1100 (EST)
Message-ID: <1392930384.6733.842.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] irqdomain: add support for creating a continous
 mapping
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 20 Feb 2014 15:06:24 -0600
In-Reply-To: <1392929590-12888-2-git-send-email-bigeasy@linutronix.de>
References: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
 <1392929590-12888-2-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-02-20 at 21:53 +0100, Sebastian Andrzej Siewior wrote:
> A MSI device may have multiple interrupts. That means that the
> interrupts numbers should be continuos so that pdev->irq refers to the
> first interrupt, pdev->irq + 1 to the second and so on.
> This patch adds support for continuous allocation of virqs for a range
> of hwirqs. The function is based on irq_create_mapping() but due to the
> number argument there is very little in common now.

Would it make sense to turn irq_create_mapping() into a call to
irq_create_mapping_block() with num = 1?

-Scott
