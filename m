Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 407F02C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 06:51:56 +1100 (EST)
Date: Fri, 21 Feb 2014 20:51:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] rapidio/tsi721: fix tasklet termination in dma channel
 release
In-Reply-To: <1393010358-6837-1-git-send-email-alexandre.bounine@idt.com>
Message-ID: <alpine.DEB.2.02.1402212047080.21251@ionos.tec.linutronix.de>
References: <1393010358-6837-1-git-send-email-alexandre.bounine@idt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Galbraith <bitbucket@online.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Xiaotian Feng <xtfeng@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Feb 2014, Alexandre Bounine wrote:
> This patch is a modification of the patch originally proposed
> by Xiaotian Feng <xtfeng@gmail.com>: https://lkml.org/lkml/2012/11/5/413
> This new version disables DMA channel interrupts and ensures that the tasklet
> wil not be scheduled again before calling tasklet_kill().
> 
> Unfortunately the updated patch was not released at that time due to planned
> rework of Tsi721 mport driver to use threaded interrupts (which has yet to
> happen).
> Recently the issue was reported again: https://lkml.org/lkml/2014/2/19/762.
> 
> Description from the original Xiaotian's patch:
> 
> "Some drivers use tasklet_disable in device remove/release process, 
> tasklet_disable will inc tasklet->count and return. If the tasklet is 
> not handled yet under some softirq pressure, the tasklet will be 
> placed on the tasklet_vec, never have a chance to be excuted. This 
> might lead to a heavy loaded ksoftirqd, wakeup with pending_softirq, 
> but tasklet is disabled. tasklet_kill should be used in this case."
> 
> This patch is applicable to kernel versions starting from v3.5.
> 
> Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Xiaotian Feng <xtfeng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Galbraith <bitbucket@online.de>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
