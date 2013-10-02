Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id C19562C007C
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 20:02:38 +1000 (EST)
Date: Wed, 2 Oct 2013 13:02:24 +0300
From: Gleb Natapov <gleb@redhat.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
Message-ID: <20131002100224.GF17294@redhat.com>
References: <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com>
 <1380620338.645.22.camel@pasglop> <524AAFAA.3010801@redhat.com>
 <20131002050940.GA25363@drongo> <524BDD73.3020106@redhat.com>
 <1380704789.645.57.camel@pasglop>
 <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
 <3CBF5732-E7EE-4C96-8132-6D7B77270DAF@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CBF5732-E7EE-4C96-8132-6D7B77270DAF@suse.de>
Cc: tytso@mit.edu, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 02, 2013 at 11:50:50AM +0200, Alexander Graf wrote:
> 
> On 02.10.2013, at 11:11, Alexander Graf wrote:
> 
> > 
> > On 02.10.2013, at 11:06, Benjamin Herrenschmidt wrote:
> > 
> >> On Wed, 2013-10-02 at 10:46 +0200, Paolo Bonzini wrote:
> >> 
> >>> 
> >>> Thanks.  Any chance you can give some numbers of a kernel hypercall and
> >>> a userspace hypercall on Power, so we have actual data?  For example a
> >>> hypercall that returns H_PARAMETER as soon as possible.
> >> 
> >> I don't have (yet) numbers at hand but we have basically 3 places where
> >> we can handle hypercalls:
> >> 
> >> - Kernel real mode. This is where most of our MMU stuff goes for
> >> example unless it needs to trigger a page fault in Linux. This is
> >> executed with translation disabled and the MMU still in guest context.
> >> This is the fastest path since we don't take out the other threads nor
> >> perform any expensive context change. This is where we put the
> >> "accelerated" H_RANDOM as well.
> >> 
> >> - Kernel virtual mode. That's a full exit, so all threads are out and
> >> MMU switched back to host Linux. Things like vhost MMIO emulation goes
> >> there, page faults, etc...
> >> 
> >> - Qemu. This adds the round trip to userspace on top of the above.
> > 
> > Right, and the difference for the patch in question is really whether we handle in in kernel virtual mode or in QEMU, so the bulk of the overhead (kicking threads out of  guest context, switching MMU context, etc) happens either way.
> > 
> > So the additional overhead when handling it in QEMU here really boils down to the user space roundtrip (plus another random number read roundtrip).
> 
> Ah, sorry, I misread the patch. You're running the handler in real mode of course :).
> 
> So how do you solve live migration between a kernel that has this patch and one that doesn't?
> 
Yes, I alluded to it in my email to Paul and Paolo asked also. How this
interface is disabled? Also hwrnd is MMIO in a host why guest needs to
use hypercall instead of emulating the device (in kernel or somewhere
else?). Another things is that on a host hwrnd is protected from
direct userspace access by virtue of been a device, but guest code (event
kernel mode) is userspace as far as hosts security model goes, so by
implementing this hypercall in a way that directly access hwrnd you
expose hwrnd to a userspace unconditionally. Why is this a good idea? 

--
			Gleb.
