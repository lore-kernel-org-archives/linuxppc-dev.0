Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76FCD2C0095
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 19:06:53 +1000 (EST)
Message-ID: <1380704789.645.57.camel@pasglop>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 02 Oct 2013 19:06:29 +1000
In-Reply-To: <524BDD73.3020106@redhat.com>
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
 <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com> <1380620338.645.22.camel@pasglop>
 <524AAFAA.3010801@redhat.com> <20131002050940.GA25363@drongo>
 <524BDD73.3020106@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tytso@mit.edu, kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 agraf@suse.de, herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-02 at 10:46 +0200, Paolo Bonzini wrote:

> 
> Thanks.  Any chance you can give some numbers of a kernel hypercall and
> a userspace hypercall on Power, so we have actual data?  For example a
> hypercall that returns H_PARAMETER as soon as possible.

I don't have (yet) numbers at hand but we have basically 3 places where
we can handle hypercalls:

 - Kernel real mode. This is where most of our MMU stuff goes for
example unless it needs to trigger a page fault in Linux. This is
executed with translation disabled and the MMU still in guest context.
This is the fastest path since we don't take out the other threads nor
perform any expensive context change. This is where we put the
"accelerated" H_RANDOM as well.

 - Kernel virtual mode. That's a full exit, so all threads are out and
MMU switched back to host Linux. Things like vhost MMIO emulation goes
there, page faults, etc...

 - Qemu. This adds the round trip to userspace on top of the above.

Cheers,
Ben.
