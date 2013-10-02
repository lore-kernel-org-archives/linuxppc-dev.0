Return-Path: <michael@ellerman.id.au>
Message-ID: <1380722275.12149.28.camel@concordia>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
From: Michael Ellerman <michael@ellerman.id.au>
To: Gleb Natapov <gleb@redhat.com>
Date: Wed, 02 Oct 2013 23:57:55 +1000
In-Reply-To: <20131002100224.GF17294@redhat.com>
References: <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com> <1380620338.645.22.camel@pasglop>
 <524AAFAA.3010801@redhat.com> <20131002050940.GA25363@drongo>
 <524BDD73.3020106@redhat.com> <1380704789.645.57.camel@pasglop>
 <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
 <3CBF5732-E7EE-4C96-8132-6D7B77270DAF@suse.de>
 <20131002100224.GF17294@redhat.com>
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

On Wed, 2013-10-02 at 13:02 +0300, Gleb Natapov wrote:
> On Wed, Oct 02, 2013 at 11:50:50AM +0200, Alexander Graf wrote:
> > 
> > On 02.10.2013, at 11:11, Alexander Graf wrote:
> > 
> > So how do you solve live migration between a kernel that has this patch and one that doesn't?
> > 
> Yes, I alluded to it in my email to Paul and Paolo asked also. How this
> interface is disabled? 

Yes that is a valid point.

We can't disable the interface at runtime, the guest detects its
presence at boot.

What will happen is the hcall will come through to QEMU, which will
reject it with H_FUNCTION (~= ENOSYS).

The current pseries-rng driver does not handle that case well, which is
exactly why I sent patches to fix it recently.

The only other option would be to feed it with /dev/random.

> Also hwrnd is MMIO in a host why guest needs to
> use hypercall instead of emulating the device (in kernel or somewhere
> else?). 

Because PAPR is a platform specification and it specifies that the
interface is a hypervisor call. We can't just decide we want to do it
differently.

> Another things is that on a host hwrnd is protected from
> direct userspace access by virtue of been a device, but guest code (event
> kernel mode) is userspace as far as hosts security model goes, so by
> implementing this hypercall in a way that directly access hwrnd you
> expose hwrnd to a userspace unconditionally. Why is this a good idea? 

I'm not sure I follow you.

The hwrng is accessible by host userspace via /dev/mem.

cheers
