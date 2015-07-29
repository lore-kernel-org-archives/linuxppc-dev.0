Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E1341A0EA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 08:22:31 +1000 (AEST)
Message-ID: <1438208530.2993.350.camel@freescale.com>
Subject: Re: [PATCH v5 1/2] perf,kvm/ppc: Add kvm_perf.h for powerpc
From: Scott Wood <scottwood@freescale.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
CC: <maddy@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <acme@kernel.org>, <paulus@samba.org>,
 <warrier@linux.vnet.ibm.com>, <sukadev@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mingo@kernel.org>
Date: Wed, 29 Jul 2015 17:22:10 -0500
In-Reply-To: <55B8ACD9.8090404@linux.vnet.ibm.com>
References: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1437077417.2993.108.camel@freescale.com>
 <55B8ACD9.8090404@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-29 at 16:07 +0530, Hemant Kumar wrote:
> Hi Scott,
> 
> On 07/17/2015 01:40 AM, Scott Wood wrote:
> > On Thu, 2015-07-16 at 21:18 +0530, Hemant Kumar wrote:
> > > To analyze the exit events with perf, we need kvm_perf.h to be added in
> > > the arch/powerpc directory, where the kvm tracepoints needed to trace
> > > the KVM exit events are defined.
> > > 
> > > This patch adds "kvm_perf_book3s.h" to indicate that the tracepoints are
> > > book3s specific. Generic "kvm_perf.h" then can just include
> > > "kvm_perf_book3s.h".
> > > 
> > > Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> > > ---
> > > Changes:
> > > - Not exporting the exit reasons compared to previous patchset 
> > > (suggested
> > > by Paul)
> > > 
> > >   arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 ++++++
> > >   arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 14 ++++++++++++++
> > >   2 files changed, 20 insertions(+)
> > >   create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
> > >   create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > 
> > > diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h
> > > b/arch/powerpc/include/uapi/asm/kvm_perf.h
> > > new file mode 100644
> > > index 0000000..5ed2ff3
> > > --- /dev/null
> > > +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
> > > @@ -0,0 +1,6 @@
> > > +#ifndef _ASM_POWERPC_KVM_PERF_H
> > > +#define _ASM_POWERPC_KVM_PERF_H
> > > +
> > > +#include <asm/kvm_perf_book3s.h>
> > > +
> > > +#endif
> > > diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > new file mode 100644
> > > index 0000000..8c8d8c2
> > > --- /dev/null
> > > +++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > @@ -0,0 +1,14 @@
> > > +#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
> > > +#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
> > > +
> > > +#include <asm/kvm.h>
> > > +
> > > +#define DECODE_STR_LEN 20
> > > +
> > > +#define VCPU_ID "vcpu_id"
> > > +
> > > +#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
> > > +#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
> > > +#define KVM_EXIT_REASON "trap"
> > > +
> > > +#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
> > Again, why is book3s stuff being presented via uapi as generic
> > <asm/kvm_perf.h> with generic symbol names?
> > 
> > -Scott
> 
> Ok.
> 
> We can change the KVM_ENTRY_TRACE macro to something like
> KVM_BOOK3S_ENTRY_TRACE and likewise for KVM_EXIT_TRACE
> and KVM_EXIT_REASON

What about DECODE_STR_LEN and VCPU_ID?

Where is this API documented?

>  and then, to resolve the issue of generic
> macro names in the userspace side, we can handle it using __weak
> modifier.

Does userspace get built differently for book3s versus book3e?  For now it'd 

be fine for userspace to check for book3s and not use the feature if it's 

book3e.  If and when book3e gains this feature, then userspace can be changed.

> What would you suggest?

Another option would be to explain this interface so that we can figure out 
if book3e would even want different values for these, and if not, move it to 
asm/kvm.h.

-Scott
