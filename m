Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A2872C00A3
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 08:21:39 +1000 (EST)
Message-ID: <1380752480.645.74.camel@pasglop>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Thu, 03 Oct 2013 08:21:20 +1000
In-Reply-To: <20131002143720.GK17294@redhat.com>
References: <524AAFAA.3010801@redhat.com> <20131002050940.GA25363@drongo>
 <524BDD73.3020106@redhat.com> <1380704789.645.57.camel@pasglop>
 <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
 <3CBF5732-E7EE-4C96-8132-6D7B77270DAF@suse.de>
 <20131002100224.GF17294@redhat.com> <1380722275.12149.28.camel@concordia>
 <029A8D6C-C23C-42B2-8C26-D76B59E2C9DD@suse.de>
 <524C2EAE.7090209@redhat.com> <20131002143720.GK17294@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tytso@mit.edu, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, herbert@gondor.hengli.com.au,
 Paul Mackerras <paulus@samba.org>, mpm@selenic.com,
 Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-02 at 17:37 +0300, Gleb Natapov wrote:
> On Wed, Oct 02, 2013 at 04:33:18PM +0200, Paolo Bonzini wrote:
> > Il 02/10/2013 16:08, Alexander Graf ha scritto:
> > > > The hwrng is accessible by host userspace via /dev/mem.
> > > 
> > > A guest should live on the same permission level as a user space
> > > application. If you run QEMU as UID 1000 without access to /dev/mem, why
> > > should the guest suddenly be able to directly access a memory location
> > > (MMIO) it couldn't access directly through a normal user space interface.
> > > 
> > > It's basically a layering violation.
> > 
> > With Michael's earlier patch in this series, the hwrng is accessible by
> > host userspace via /dev/hwrng, no?
> > 
> Access to which can be controlled by its permission. Permission of
> /dev/kvm may be different. If we route hypercall via userspace and
> configure qemu to get entropy from /dev/hwrng everything will fall
> nicely together (except performance).

Yes, except abysmall performance and a lot more code for something
completely and utterly pointless .... nice.

Ben.
