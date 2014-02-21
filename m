Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C0EE2C0324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 19:04:49 +1100 (EST)
Message-ID: <53070898.601@linutronix.de>
Date: Fri, 21 Feb 2014 09:04:40 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] irqdomain: add support for creating a continous
 mapping
References: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>	
 <1392929590-12888-2-git-send-email-bigeasy@linutronix.de>
 <1392930384.6733.842.camel@snotra.buserror.net>
In-Reply-To: <1392930384.6733.842.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2014 10:06 PM, Scott Wood wrote:
> On Thu, 2014-02-20 at 21:53 +0100, Sebastian Andrzej Siewior wrote:
>> A MSI device may have multiple interrupts. That means that the
>> interrupts numbers should be continuos so that pdev->irq refers to the
>> first interrupt, pdev->irq + 1 to the second and so on.
>> This patch adds support for continuous allocation of virqs for a range
>> of hwirqs. The function is based on irq_create_mapping() but due to the
>> number argument there is very little in common now.
> 
> Would it make sense to turn irq_create_mapping() into a call to
> irq_create_mapping_block() with num = 1?

There are few things different and I didn't like it. Now I that I look
at it again I've found a bug the way irq_find_mapping() is called.
Let me redo it with your suggestion and we will see if it makes sense.

> -Scott
> 
> 
Sebastian
