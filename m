Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D1012C0119
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 19:39:26 +1000 (EST)
Message-ID: <1380620338.645.22.camel@pasglop>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Tue, 01 Oct 2013 19:38:58 +1000
In-Reply-To: <20131001083908.GA17294@redhat.com>
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
 <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tytso@mit.edu, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, agraf@suse.de,
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

On Tue, 2013-10-01 at 11:39 +0300, Gleb Natapov wrote:
> On Tue, Oct 01, 2013 at 06:34:26PM +1000, Michael Ellerman wrote:
> > On Thu, Sep 26, 2013 at 11:06:59AM +0200, Paolo Bonzini wrote:
> > > Il 26/09/2013 08:31, Michael Ellerman ha scritto:
> > > > Some powernv systems include a hwrng. Guests can access it via the
> > > > H_RANDOM hcall.
> > > 
> > > Is there any reason to do this in the kernel?  
> > 
> > It's less code, and it's faster :)
> > 
> > > It does not have to be a particularly fast path;
> > 
> > Sure, but do we have to make it slow on purpose?
> > 
> We do not put non performance critical devices into the kernel.

So for the sake of that dogma you are going to make us do something that
is about 100 times slower ? (and possibly involves more lines of code)

It's not just speed ... H_RANDOM is going to be called by the guest
kernel. A round trip to qemu is going to introduce a kernel jitter
(complete stop of operations of the kernel on that virtual processor) of
a full exit + round trip to qemu + back to the kernel to get to some
source of random number ...  this is going to be in the dozens of ns at
least.

This makes no sense.

Ben.
