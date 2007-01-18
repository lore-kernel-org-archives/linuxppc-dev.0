Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A192EDDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 23:06:09 +1100 (EST)
Date: Thu, 18 Jan 2007 21:05:58 +0900 (JST)
Message-Id: <200701181205.l0IC5xXL015888@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 8/19] powerpc: supporting interrupts for Celleb
In-Reply-To: <1169079759.4965.7.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

thank you for your comment and consideration.

> On Fri, 2007-01-12 at 10:01 +0900, Ishizaki Kou wrote:
> > This patch creates Celleb platform dependent files to support interrupts.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> > Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> > ---

> There might be ways to make this code simpler and possibily even remove
> the spinlock, I have to think about it a bit more and maybe test when/if
> we get some hardware here.

> One thing is, since you need to mask interrupts while handling them,
> you might as well use something like the level handler instead of
> fasteoi (unless interrupts behave as edge on your HV in which case the
> edge handle woudl do the job though it won't mask the same way).

> Then you might also be able to use atomic operations rather than
> spinlocks for the updates of the various masks.

Please note that the mask should be synchronized to Beat.


> There is nothing urgent about those change though, that I would consider
> more as optimisations, and I need to better understand what your
> hypervisor exactly does to be sure about it, so in the meantime,

On hardware-triggered interrupt of Beat is level-triggered,
i.e. interrupt occurres continuously until 'downcount_of_interrupt'
guest OS interface is called. So we have to mask interrupt until
it is served.

On software-triggered interrupt of Beat is edge-triggered,
but we have to keep the interrupt active to dispatch logical
partition until all services related to the interrupt is served.
Since dispatching of logical parition depends on interrupt
activity, we have to mask (not to acknowledge) the interrupt.

Best regards,
Kou Ishizaki
