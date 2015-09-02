Return-Path: <ananth@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B1A21A2A7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 12:38:12 +1000 (AEST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CC98F140281
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2015 12:38:11 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 1 Sep 2015 20:38:09 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 126363E4003E
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2015 20:38:07 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t822bwBa35389470
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2015 19:38:07 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t822bXXK013358
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2015 20:37:34 -0600
Date: Wed, 2 Sep 2015 08:07:13 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>,
 "Paul Mackerras" <paulus@samba.org>, <ego@linux.vnet.ibm.com>
Subject: Re: powerpc: Add user-return-notifier support
Message-ID: <20150902023713.GB1196@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20150825054110.GD3815@in.ibm.com>
 <20150831103517.96D1A1401E7@ozlabs.org>
 <20150901064113.GA1196@in.ibm.com>
 <1441152192.4966.103.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441152192.4966.103.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 01, 2015 at 07:03:12PM -0500, Scott Wood wrote:
> On Tue, 2015-09-01 at 12:11 +0530, Ananth N Mavinakayanahalli wrote:
> > On Mon, Aug 31, 2015 at 08:35:17PM +1000, Michael Ellerman wrote:
> > > On Tue, 2015-25-08 at 05:41:10 UTC, Ananth N Mavinakayanahalli wrote:
> > > > Add user return notifier support for powerpc. Similar to x86, this 
> > > > feature
> > > > keys off of the KVM Kconfig.
> > > 
> > > Please flesh this out.
> > > 
> > > What is it, why do we want it, why is your implementation correct.
> > 
> > The only current in-kernel user of the infrastructure is KVM on x86. It
> > is useful for optimizations when MSR values can continue to be used
> > between the host and guest. Commit log for 18863bdd60f8 upstream has a
> > more complete explanation.
> >
> > I do not know the inner details of the KVM implementation on Power,
> > perhaps Paul/Gautham can comment on if a similar optimization will
> > benefit Power systems too?
> 
> "MSR" is x86-specific terminology and is pretty vague.  What specifically is 
> the functionality being optimized, in terms of things that actually exist on 
> PPC?
>
> In any case, that commit log doesn't explain what user-return-notifier is or 
> how it works, just that it's being used.

User return notifier is a simple mechanism to fire a one-shot custom handler in
the context of the thread its registered against, just before it returns to
userspace. It works by setting a TIF flag to indicate that a handler needs to
run, and on the userspace return path (do_notify_resume()), this flag is checked
to call any registered handlers.

> > We could certainly make this a generic config option.. but I am yet to
> > see a real usecase outside of the KVM thingy. We do use TIF_UPROBE for
> > something very similar, though that needs to fire much before the
> > outstanding signals get handled. The user-return notifier is the last
> > thing executed before return to userspace -- the two cannot be merged.
> > 
> > Ananth
> > 
> > PS: I am not sure having an 'ok' against the Documentation/features/ for
> > powerpc is a valid enough argument for this :-)
> 
> So how did you test this?  What platforms did you test it on?  What hardware 
> support does it need?

Simple kernel module below... Its fairly evident from the patch that the
feature is a software only construct and no specific hardware support is
needed. I've tested this on a P7.

Ananth

---
/* uret test module */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/user-return-notifier.h>

struct user_return_notifier urn;
static int count;

static void test_on_user_return(struct user_return_notifier *urn)
{
	count++;
}


static int init_urn(void)
{
	urn.on_user_return = test_on_user_return;
	user_return_notifier_register(&urn);
	printk("urn registered\n");
	return 0;
}
	
static void cleanup_urn(void)
{
	user_return_notifier_unregister(&urn);
	printk("urn unregistered; count = %d\n", count);
}

module_init(init_urn);
module_exit(cleanup_urn);
MODULE_LICENSE("GPL");
