Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 767E71A0C14
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 09:42:43 +1000 (AEST)
Message-ID: <1438386140.19345.70.camel@freescale.com>
Subject: Re: [PATCH v5 1/2] perf,kvm/ppc: Add kvm_perf.h for powerpc
From: Scott Wood <scottwood@freescale.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
CC: <maddy@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <acme@kernel.org>, <paulus@samba.org>,
 <warrier@linux.vnet.ibm.com>, <sukadev@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mingo@kernel.org>, <kvm@vger.kernel.org>,
 <kvm-ppc@vger.kernel.org>, <agraf@suse.de>, Mihai Caraman
 <mihai.caraman@freescale.com>
Date: Fri, 31 Jul 2015 18:42:20 -0500
In-Reply-To: <55BB37FE.3040002@linux.vnet.ibm.com>
References: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1437077417.2993.108.camel@freescale.com>
 <55B8ACD9.8090404@linux.vnet.ibm.com>
 <1438208530.2993.350.camel@freescale.com>
 <55BB37FE.3040002@linux.vnet.ibm.com>
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

[Added KVM lists and a couple relevant people]

On Fri, 2015-07-31 at 14:25 +0530, Hemant Kumar wrote:
> On 07/30/2015 03:52 AM, Scott Wood wrote:
> > On Wed, 2015-07-29 at 16:07 +0530, Hemant Kumar wrote:
> > > Hi Scott,
> > > 
> > > On 07/17/2015 01:40 AM, Scott Wood wrote:
> > > > On Thu, 2015-07-16 at 21:18 +0530, Hemant Kumar wrote:
> > > > > To analyze the exit events with perf, we need kvm_perf.h to be 
> > > > > added in
> > > > > the arch/powerpc directory, where the kvm tracepoints needed to 
> > > > > trace
> > > > > the KVM exit events are defined.
> > > > > 
> > > > > This patch adds "kvm_perf_book3s.h" to indicate that the 
> > > > > tracepoints are
> > > > > book3s specific. Generic "kvm_perf.h" then can just include
> > > > > "kvm_perf_book3s.h".
> > > > > 
> > > > > Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> > > > > ---
> > > > > Changes:
> > > > > - Not exporting the exit reasons compared to previous patchset
> > > > > (suggested
> > > > > by Paul)
> > > > > 
> > > > >    arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 ++++++
> > > > >    arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 14 
> > > > > ++++++++++++++
> > > > >    2 files changed, 20 insertions(+)
> > > > >    create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
> > > > >    create mode 100644 
> > > > > arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > > > 
> > > > > diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h
> > > > > b/arch/powerpc/include/uapi/asm/kvm_perf.h
> > > > > new file mode 100644
> > > > > index 0000000..5ed2ff3
> > > > > --- /dev/null
> > > > > +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
> > > > > @@ -0,0 +1,6 @@
> > > > > +#ifndef _ASM_POWERPC_KVM_PERF_H
> > > > > +#define _ASM_POWERPC_KVM_PERF_H
> > > > > +
> > > > > +#include <asm/kvm_perf_book3s.h>
> > > > > +
> > > > > +#endif
> > > > > diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > > > b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > > > new file mode 100644
> > > > > index 0000000..8c8d8c2
> > > > > --- /dev/null
> > > > > +++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> > > > > @@ -0,0 +1,14 @@
> > > > > +#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
> > > > > +#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
> > > > > +
> > > > > +#include <asm/kvm.h>
> > > > > +
> > > > > +#define DECODE_STR_LEN 20
> > > > > +
> > > > > +#define VCPU_ID "vcpu_id"
> > > > > +
> > > > > +#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
> > > > > +#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
> > > > > +#define KVM_EXIT_REASON "trap"
> > > > > +
> > > > > +#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
> > > > Again, why is book3s stuff being presented via uapi as generic
> > > > <asm/kvm_perf.h> with generic symbol names?
> > > > 
> > > > -Scott
> > > Ok.
> > > 
> > > We can change the KVM_ENTRY_TRACE macro to something like
> > > KVM_BOOK3S_ENTRY_TRACE and likewise for KVM_EXIT_TRACE
> > > and KVM_EXIT_REASON
> > What about DECODE_STR_LEN and VCPU_ID?
> 
> DECODE_STR_LEN can be common, we can give a big enough size to it, if
> we need to.
> And, VCPU_ID depends on the field in the tracepoint payload data which is
> specific to that tracepoint. This field is used to maintain the per vcpu 
> record
> and this field gives us the vcpu id. So, yeah, I guess, since, I can't 
> find any
> such field as "vcpu_id" in the kvm_exit tracepoint for book3e, we have to
> make this specific to book3s.

Or maybe we could add kvm_guest_enter/kvm_guest_leave, with vcpu_id, to 
book3e... though the kvm-hv would be a problem for book3s-pr, if anyone cares 
about this feature there.

I'm not sure why the strings are present both in the UAPI header, as well as 
in kvm_events_tp[] in kvm-stat.c.

> > Where is this API documented?
> > 
> > >   and then, to resolve the issue of generic
> > > macro names in the userspace side, we can handle it using __weak
> > > modifier.
> > Does userspace get built differently for book3s versus book3e?  For now 
> > it'd
> > 
> > be fine for userspace to check for book3s and not use the feature if it's
> > 
> > book3e.  If and when book3e gains this feature, then userspace can be 
> > changed.
> 
> Well, I couldn't find any way to build user space differently for book3s and
> book3e.
> 
> How about keeping this as it is after modifying the tracepoint macro names
> to book3s specific in the uapi? And as and when booke decides to implement
> this feature, a runtime check for event availability can be added then, 
> IMHO.
> 
> What do you think?

What does userspace use, at runtime, to determine if this feature is present 
and whether the book3s symbols should be used?

Deferring the implementation of book3e support is fine, but from a uapi 
perspective it should be discoverable at runtime whether the feature exposed 
by asm/kvm_perf_book3s.h is available.  Otherwise, if it is implemented (or 
even if it isn't), you have the potential for user confusion if an older perf 
tool is used.  This sort of discovery is done all the time in the KVM APIs 
themselves.

FWIW, on x86 cpu_isa_init() uses cpuid to select an exit table.  Using PVR 
seems like it would be a bit cumbersome though compared to the kernel 
directly exporting which subarch it is (and it wouldn't help with HV versus 
PR).

> > > What would you suggest?
> > Another option would be to explain this interface so that we can figure 
> > out
> > if book3e would even want different values for these, and if not, move it 
> > to
> > asm/kvm.h.
> 
> Here is my understanding of the interface. We need to add handlers for
> "is_begin_event", "is_end_event" and "decode_key" for any event type
> (for which we want to collect the stats).
> The first two handlers check when the respective events started/ended
> and hence, the time difference stats, event start/end time etc. is 
> calculated
> in these functions. To check if the event has started or ended, they make
> use of the macros KVM_ENTRY_TRACE and KVM_EXIT_TRACE. These
> macros are exported from the kernel as uapi. Atleast, that's how x86 and
> s390 do it.

It really seems like something that would have been better handled via some 
sort of dynamic discovery rather than uapi header file constants.

> "decode_key" hanlder is used to find out the reason for
> that event (in case of book3s, its "trap" field of kvm_hv:kvm_guest_exit
> payload) in semantic terms. It maps an info of interest found in that
> particular tracepoint's data to a name(string) through a
> table kvm_trace_symbol_exit. All the events are then classified into groups
> based on this info.

So it tells you what field to use, but not how to decode that field.  What's 
the point?  If userspace has inherent knowledge that 0xe20 means 
"H_INST_STORAGE" why can't it have inherent knowledge that the field to use 
is "trap"?

-Scott
