Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B93CE2C0098
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Sep 2013 16:16:23 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Sep 2013 11:46:18 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D11DAE0058
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Sep 2013 11:47:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8P6GADR43515940
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Sep 2013 11:46:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8P6GCA5011213
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Sep 2013 11:46:12 +0530
Message-ID: <52427F76.8040608@linux.vnet.ibm.com>
Date: Wed, 25 Sep 2013 11:45:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
 <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
 <524006C4.3010006@linux.vnet.ibm.com> <1380075585.14938.4.camel@concordia>
In-Reply-To: <1380075585.14938.4.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/25/2013 07:49 AM, Michael Ellerman wrote:
> On Mon, 2013-09-23 at 14:45 +0530, Anshuman Khandual wrote:
>> On 09/21/2013 12:25 PM, Stephane Eranian wrote:
>>> On Tue, Sep 10, 2013 at 4:06 AM, Michael Ellerman
>>> <michael@ellerman.id.au> wrote:
>>>>>
>>>>> On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
>>>>>>>       This patchset is the re-spin of the original branch stack sampling
>>>>>>> patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>>>>>>> also enables SW based branch filtering support for PPC64 platforms which have
>>>>>>> branch stack sampling support. With this new enablement, the branch filter support
>>>>>>> for PPC64 platforms have been extended to include all these combinations discussed
>>>>>>> below with a sample test application program.
>>>>>
>>>>> ...
>>>>>
>>>>>>> Mixed filters
>>>>>>> -------------
>>>>>>> (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
>>>>>>> Error:
>>>>>>> The perf.data file has no samples!
>>>>>>>
>>>>>>> NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
>>>>>>> branches in that given set. Both the filters are mutually exclussive, so obviously no samples
>>>>>>> found in the end profile.
>>>>>
>>>>> The semantics of multiple filters is not clear to me. It could be an OR,
>>>>> or an AND. You have implemented AND, does that match existing behaviour
>>>>> on x86 for example?
>>>
>>> The semantic on the API is OR. AND does not make sense: CALL & RETURN?
>>> On x86, the HW filter is an OR (default: ALL, set bit to disable a
>>> type). I suspect
>>> it is similar on PPC.
>>
>> Given the situation as explained here, which semantic would be better for single
>> HW and multiple SW filters. Accordingly validate_instruction() function will have
>> to be re-implemented. But I believe OR-ing the SW filters will be preferable.
>>
>> 	(1) (HW_FILTER_1) && (SW_FILTER_1) && (SW_FILTER_2)
>> 	or
>> 	(2) (HW_FILTER_1) && (SW_FILTER_1 || SW_FILTER_2)
>>
>> Please let me know your inputs and suggestions on this. Thank you.
> 
> You need to implement the correct semantics, regardless of how the
> hardware happens to work.
> 
> That means if multiple filters are specified you need to do all the
> filtering in software.

Hello Stephane,

I looked at the X86 code on branch filtering implementation.

(1) During event creation intel_pmu_hw_config calls intel_pmu_setup_lbr_filter when LBR sampling
    is required, intel_pmu_setup_lbr_filter calls these two functions 

	(a) intel_pmu_setup_sw_lbr_filter

	"event->hw.branch_reg.reg" contains all the SW filter masks which can be
	supported for the user requested filters event->attr.branch_sample_type (even
	if some of them could implemented in PMU HW)

	(b) intel_pmu_setup_hw_lbr_filter (when HW filtering is present)

	"event->hw.branch_reg.config" contains all the PMU HW filter masks corresponding
	to the requested filters in event->attr.branch_sample_type. One point to note
	here is that if the user has requested for some branch filter which is not supported
	in the HW LBR filter, the event creation request is rejected with EOPNOTSUPP. This
	not true for the filters which can be ignored in the PMU.

(2) When the event is enabled in the PMU

	(a) cpuc->lbr_sel->config gets into the HW register to enable the filtering of branches
	which was determined in the function intel_pmu_setup_hw_lbr_filter. 

(3) After the IRQ happened, intel_pmu_lbr_read reads all the entries from the LBR  HW and then
    applies the filter in the function intel_pmu_lbr_filter.

	(a) intel_pmu_lbr_filter functions take into account cpuc->br_sel (which is nothing but
	event->hw.branch_reg.reg as determined in the function intel_pmu_setup_sw_lbr_filter)
	which contains the entire branch filter request set in terms applicable SW filter. Here
	the semantic is OR when we look at from SW filter implementation point of view.

   BUT what branch record set we are working on right now ? A set which was captured with LBR HW
   with cpuc->lbr_sel->config filters enabled on it. So to me the X86 implementation of the semantics
   look something like this.
	
	A - Branch filter set requested by the user
	B - Subset of A which can be supported in HW
	C - Subset of A which can be supported in SW

	(B) && (C) 

	NOTE: Individual filters are OR-ed inside both B and C sets.

So here the semantics is not a true OR. This is my understanding till now which may be wrong. Please
help me understand if the semantics is something otherwise than what is explained above.

In POWER8 because we cannot OR individual HW PMU supported filters, till now the semantics looked a bit odd.
But as Michael has pointed out here that if there are multiple branch filter requests implement all of them
in SW. Only in case where the user requests for an individual filter and if it happen to be supported in HW
PMU, we will use the PMU filters.

Regards
Anshuman
