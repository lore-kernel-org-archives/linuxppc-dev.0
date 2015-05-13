Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3EBA1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 13:21:52 +1000 (AEST)
Message-ID: <1431487299.3868.1.camel@freescale.com>
Subject: Re: [PATCH v3 3/3] kvm/powerpc: Export HCALL reason codes
From: Scott Wood <scottwood@freescale.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Date: Tue, 12 May 2015 22:21:39 -0500
In-Reply-To: <55522774.5030400@linux.vnet.ibm.com>
References: <1431046385-5772-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1431046385-5772-3-git-send-email-hemant@linux.vnet.ibm.com>
 <1431382467.16357.476.camel@freescale.com>
 <55522774.5030400@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, paulus@samba.org, acme@kernel.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-12 at 21:46 +0530, Hemant Kumar wrote:
> On 05/12/2015 03:44 AM, Scott Wood wrote:
> > On Fri, 2015-05-08 at 06:23 +0530, Hemant Kumar wrote:
> >> For perf to analyze the KVM events like hcalls, we need the
> >> hypervisor calls and their codes to be exported through uapi.
> >>
> >> This patch moves most of the pSeries hcall codes from
> >> arch/powerpc/include/asm/hvcall.h to
> >> arch/powerpc/include/uapi/asm/hcall_codes.h.
> >> It also moves the mapping <hcall_code-to-hcall_reason> from
> >> arch/powerpc/kvm/trace_hv.h to
> >> arch/powerpc/include/uapi/asm/trace_hcall.h.
> >>
> >> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> >> ---
> >>   arch/powerpc/include/asm/hvcall.h           | 120 +--------------------------
> >>   arch/powerpc/include/uapi/asm/hcall_codes.h | 123 ++++++++++++++++++++++++++++
> >>   arch/powerpc/include/uapi/asm/trace_hcall.h | 122 +++++++++++++++++++++++++++
> >>   arch/powerpc/kvm/trace_hv.h                 | 117 +-------------------------
> > When moving to uapi please add proper namespacing to indicate that this
> > is pseries specific.
> >
> 
> Sure, will add that.

Thanks.

> >> diff --git a/arch/powerpc/include/uapi/asm/trace_hcall.h b/arch/powerpc/include/uapi/asm/trace_hcall.h
> >> new file mode 100644
> >> index 0000000..00eac01
> >> --- /dev/null
> >> +++ b/arch/powerpc/include/uapi/asm/trace_hcall.h
> >> @@ -0,0 +1,122 @@
> >> +#ifndef _KVM_TRACE_HCALL_MAP_H
> >> +#define _KVM_TRACE_HCALL_MAP_H
> >> +
> >> +#include "hcall_codes.h"
> >> +
> >> +#define kvm_trace_symbol_hcall\
> >> +	{H_REMOVE,"H_REMOVE"},					\
> >> +	{H_ENTER,"H_ENTER"},					\
> >> +	{H_READ,"H_READ"},					\
> >> +	{H_CLEAR_MOD,"H_CLEAR_MOD"},				\
> > This is a rather odd way of exposing an array to userspace...
> >
> 
> Didn't get you here. Can you please elaborate?
> 
> I see some other files like arch/x86/include/uapi/asm/vmx.h exposing the 
> reasons in a similar way.

It just seemed like sloppy API to not have any typing associated with it
and require the user to wrap it in an actual array; I wasn't aware there
was precedent for this construction in uapi.  I also would have expected
a macro that doesn't behave like a normal element of C syntax (function,
variable name, type, etc) to have been capitalized.

-Scott
