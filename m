Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjXdF1mY3zDwRr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 20:32:48 +1100 (AEDT)
Message-ID: <1482226347.15937.44.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 02/12] powerpc: move set_soft_enabled() and rename
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
Date: Tue, 20 Dec 2016 20:32:27 +1100
In-Reply-To: <f09a9213-9e85-eee0-e212-bd3ee2a3569e@gmail.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-3-git-send-email-maddy@linux.vnet.ibm.com>
 <f09a9213-9e85-eee0-e212-bd3ee2a3569e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-20 at 20:03 +1100, Balbir Singh wrote:
> 
> On 19/12/16 19:06, Madhavan Srinivasan wrote:
> > Move set_soft_enabled() from powerpc/kernel/irq.c to
> > asm/hw_irq.c, to force updates to paca-soft_enabled
> > done via these access function. Add "memory" clobber
> > to hint compiler since paca->soft_enabled memory is the target
> > here
> > +static inline notrace void soft_enabled_set(unsigned long enable)
> > +{
> > +	__asm__ __volatile__("stb %0,%1(13)"
> > +	: : "r" (enable), "i" (offsetof(struct paca_struct,
> > soft_enabled))
> > +	: "memory");
> > +}
> > +
> 
> Can't we just rewrite this in "C"?
> 
> local_paca->soft_enabled = enable

Well, this is digging out another bloody can of baby eating worms...

So the reason we wrote it like that is because we had gcc playing
tricks to us.

It has been proved to move around references to local_paca, even
accross preempt_disable boundaries.

The above prevents it.

I'm about 100% sure we have a bunch of other issues related to PACA
access and gcc playing games though. I remember grepping the kernel
disassembly once for gcc doing funny things with r13 such as copying it
into another register or even saving and restoring it and my grep
didn't come up empty ...

Something we need to seriously look into one day. I have some ideas on
how to clean that up in the code to make hardening it easier, let's
talk next time Nick is in town.

Cheers,
Ben.
