Return-Path: <paulus@ozlabs.org>
Date: Thu, 19 Dec 2013 13:26:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
Message-ID: <20131219022642.GB4002@iris.ozlabs.ibm.com>
References: <1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <0AB88010-F2B7-44A1-8FA9-2A40079706BB@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0AB88010-F2B7-44A1-8FA9-2A40079706BB@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 18, 2013 at 10:44:08PM +0100, Alexander Graf wrote:
> 
> On 11.11.2013, at 15:02, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > Don't try to compute these values.
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > ---
> > 
> > NOTE: I am not sure why we were originally computing dsisr and dar. So may be
> > we need a variant of this patch. But with this and the additional patch
> > "powerpc: book3s: PR: Enable Little Endian PR guest" I am able to get a Little Endian
> > PR guest to boot.
> 
> It's quite easy to find out - git blame tells you all the history and points you to commit ca7f4203b.
> 
> commit ca7f4203b9b66e12d0d9968ff7dfe781f3a9695a
> Author: Alexander Graf <agraf@suse.de>
> Date:   Wed Mar 24 21:48:28 2010 +0100
> 
>     KVM: PPC: Implement alignment interrupt
> 
>     Mac OS X has some applications - namely the Finder - that require alignment
>     interrupts to work properly. So we need to implement them.
> 
>     But the spec for 970 and 750 also looks different. While 750 requires the
>     DSISR and DAR fields to reflect some instruction bits (DSISR) and the fault
>     address (DAR), the 970 declares this as an optional feature. So we need
>     to reconstruct DSISR and DAR manually.
> 
>     Signed-off-by: Alexander Graf <agraf@suse.de>
>     Signed-off-by: Avi Kivity <avi@redhat.com>
> 
> Read this as "on 970, alignment interrupts don't give us DSISR and DAR of the faulting instruction" as otherwise I wouldn't have implemented it.

Although it's optional, all IBM POWER cpus, and as far as I know all
PowerPC cpus, set DAR on an alignment interrupt to the effective
address being accessed.  You have a valid point regarding DSISR, but
it would be nice to skip the computations where either the host CPU
provides the bits, or the virtual CPU doesn't.

Paul.
