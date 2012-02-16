Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E701CB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 10:28:46 +1100 (EST)
Date: Thu, 16 Feb 2012 23:26:48 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 00/27] irq_domain generalization and rework
Message-ID: <20120216232648.GM27825@n2100.arm.linux.org.uk>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <20120216145219.0f1c1b98.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120216145219.0f1c1b98.akpm@linux-foundation.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 02:52:19PM -0800, Andrew Morton wrote:
> On Thu, 16 Feb 2012 02:09:01 -0700
> Grant Likely <grant.likely@secretlab.ca> wrote:
> > This series generalizes the "irq_host" infrastructure from powerpc
> > so that it can be used by all architectures and renames it to "irq_domain".
> 
> drivers/mfd/twl-core.c is fairly horked on i386 allmodconfig:
> 
> drivers/mfd/twl-core.c: In function 'twl_probe':
> drivers/mfd/twl-core.c:1218: error: implicit declaration of function 'irq_alloc_descs'
> drivers/mfd/twl-core.c:1226: error: implicit declaration of function 'irq_domain_add_legacy'
> drivers/mfd/twl-core.c:1227: error: 'irq_domain_simple_ops' undeclared (first use in this function)
> drivers/mfd/twl-core.c:1227: error: (Each undeclared identifier is reported only once
> drivers/mfd/twl-core.c:1227: error: for each function it appears in.)
> 
> This is today's linux-next so it has rmk's "ARM: omap: fix broken
> twl-core dependencies and ifdefs" in there, which looks like it
> attempts to repair this stuff.

Yes, you're the third to report this breakage.

Grant's response on Tuesday over this was:
| This is irq_domain related.  It's related to an API change.  I'm
| tracking to get it solved, either by moving the twl commit into the
| irqdomain branch or by deferring the api change to v3.5.
|
| I've also got a patch that converts x86 over to the new api, but I
| don't have sufficient review to put it into the irqdomain tree yet.

> btw, Russell, regarding this comment in include/linux/irq.h:
> 
> /*
>  * Please do not include this file in generic code.  There is currently
>  * no requirement for any architecture to implement anything held
>  * within this file.
>  *
>  * Thanks. --rmk
>  */
> 
> A quick grep indicates that we've lost this battle ;) Is the comments
> still true?  Should we stop discouraging inclusion of linux/irq.h? 
> Does anyone even know that it's discouraged ;)

It's still true for any platform which hasn't been converted to genirq,
as such a platform would not have asm/hw_irq.h.  That said, since
genirq, it's now necessary for any driver which contains interrupt
controller code like GPIO drivers.  So I suspect the comment should now
be lost, even though it's not really a replacement for asm/irq.h.
