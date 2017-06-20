Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wslDy4T8qzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 09:59:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KNwiiL121413
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:59:12 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b70yc35fw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:59:12 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 20 Jun 2017 19:59:11 -0400
Date: Tue, 20 Jun 2017 16:58:58 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC v2 10/12] powerpc: Read AMR only if pkey-violation caused
 the exception.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-11-git-send-email-linuxram@us.ibm.com>
 <87bmpkuti2.fsf@concordia.ellerman.id.au>
 <20170619175919.GD5845@ram.oc3035372033.ibm.com>
 <d403fa09-4eaa-a8ff-26f6-caf407538253@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d403fa09-4eaa-a8ff-26f6-caf407538253@linux.vnet.ibm.com>
Message-Id: <20170620235858.GM17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 12:16:40PM +0530, Anshuman Khandual wrote:
> On 06/19/2017 11:29 PM, Ram Pai wrote:
> > On Mon, Jun 19, 2017 at 09:06:13PM +1000, Michael Ellerman wrote:
> >> Ram Pai <linuxram@us.ibm.com> writes:
> >>
> >>> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >>> ---
> >>>  arch/powerpc/kernel/exceptions-64s.S | 16 ++++++++++------
> >>>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> >>> index 8db9ef8..a4de1b4 100644
> >>> --- a/arch/powerpc/kernel/exceptions-64s.S
> >>> +++ b/arch/powerpc/kernel/exceptions-64s.S
> >>> @@ -493,13 +493,15 @@ EXC_COMMON_BEGIN(data_access_common)
> >>>  	ld	r12,_MSR(r1)
> >>>  	ld	r3,PACA_EXGEN+EX_DAR(r13)
> >>>  	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
> >>> +	std	r3,_DAR(r1)
> >>> +	std	r4,_DSISR(r1)
> >>>  #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> >>> +	andis.  r0,r4,DSISR_KEYFAULT@h /* save AMR only if its a key fault */
> >>> +	beq+	1f
> >>
> >> This seems to be incremental on top of one of your other patches.
> >>
> >> But I don't see why, can you please just squash this into whatever patch
> >> adds this code in the first place.
> > 
> > It was an optimization added later. But yes it can be squashed into an
> > earlier patch.
> 
> Could you please explain what is the optimization this achieves ?

Don't want to read the AMR if it is not a key protection fault. This is a hot-hot-path.
A few cycles saved can accumulate into signficant savings overall.

RP
