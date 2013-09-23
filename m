Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B4292C0099
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Sep 2013 19:16:51 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 23 Sep 2013 14:46:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A3CBD394004E
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Sep 2013 14:46:30 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8N9Iual36307036
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Sep 2013 14:48:56 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8N9GfDK001092
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Sep 2013 14:46:41 +0530
Message-ID: <524006C4.3010006@linux.vnet.ibm.com>
Date: Mon, 23 Sep 2013 14:45:48 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
 <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
In-Reply-To: <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2013 12:25 PM, Stephane Eranian wrote:
> On Tue, Sep 10, 2013 at 4:06 AM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
>> >
>> > On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
>>> > >       This patchset is the re-spin of the original branch stack sampling
>>> > > patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>>> > > also enables SW based branch filtering support for PPC64 platforms which have
>>> > > branch stack sampling support. With this new enablement, the branch filter support
>>> > > for PPC64 platforms have been extended to include all these combinations discussed
>>> > > below with a sample test application program.
>> >
>> > ...
>> >
>>> > > Mixed filters
>>> > > -------------
>>> > > (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
>>> > > Error:
>>> > > The perf.data file has no samples!
>>> > >
>>> > > NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
>>> > > branches in that given set. Both the filters are mutually exclussive, so obviously no samples
>>> > > found in the end profile.
>> >
>> > The semantics of multiple filters is not clear to me. It could be an OR,
>> > or an AND. You have implemented AND, does that match existing behaviour
>> > on x86 for example?
>> >
> The semantic on the API is OR. AND does not make sense: CALL & RETURN?
> On x86, the HW filter is an OR (default: ALL, set bit to disable a
> type). I suspect
> it is similar on PPC.

Hey Stephane,

In POWER8 BHRB, we have got three HW PMU filters out of which we are trying
to use two of them PERF_SAMPLE_BRANCH_ANY_CALL and PERF_SAMPLE_BRANCH_COND
respectively.

(1) These filters are exclusive of each other and cannot be OR-ed with each other

(2) The SW filters are applied on the branch record set captured with BHRB
    which have the HW filters applied. So the working set is already reduced
    with the HW PMU filters. SW filter goes through the working set and figures
    out which one of them satisfy the SW filter criteria and gets picked up. The
    SW filter cannot find out branches records which matches the criteria outside
    of BHRB captured set. So we cannot OR the filters.

    This makes the combination of HW and SW filter inherently an "AND" not OR.

(3) But once we have captured the BHRB filtered data with HW PMU filter, multiple SW
    filters (if requested) can be applied either in OR or AND manner.

	It should be either like
		(1) (HW_FILTER_1) && (SW_FILTER_1) && (SW_FILTER_2)
	or like
		(2) (HW_FILTER_1) && (SW_FILTER_1 || SW_FILTER_2)

    NOTE: I admit that the current validate_instruction() function does not do
    either of them correctly. Will fix it in the next iteration.

(4) These combination of filters are not supported right now because

	(a) We are unable to process two HW PMU filters simultaneously
	(b) We have not worked on replacement SW filter for either of the HW filters

	(1) (HW_FILTER_1), (HW_FILTER_2)
	(2) (HW_FILTER_1), (HW_FILTER_2), (SW_FILTER_1)
	(3) (HW_FILTER_1), (HW_FILTER_2), (SW_FILTER_1), (SW_FILTER_2)

   How ever these combination of filters can be supported right now.

	(1) (HW_FILTER_1)
	(2) (HW_FILTER_2)

	(3) (SW_FILTER_1)
	(4) (SW_FILTER_2)
	(5) (SW_FILTER_1), (SW_FILTER_2)

	(6)  (HW_FILTER_1), (SW_FILTER_1)
	(7)  (HW_FILTER_1), (SW_FILTER_2)
	(8)  (HW_FILTER_1), (SW_FILTER_1), (SW_FILTER_2)
	(9)  (HW_FILTER_2), (SW_FILTER_1)
	(10) (HW_FILTER_2), (SW_FILTER_2)
	(11) (HW_FILTER_2), (SW_FILTER_1), (SW_FILTER_2)


Given the situation as explained here, which semantic would be better for single
HW and multiple SW filters. Accordingly validate_instruction() function will have
to be re-implemented. But I believe OR-ing the SW filters will be preferable.

	(1) (HW_FILTER_1) && (SW_FILTER_1) && (SW_FILTER_2)
	or
	(2) (HW_FILTER_1) && (SW_FILTER_1 || SW_FILTER_2)

Please let me know your inputs and suggestions on this. Thank you.

Regards
Anshuman
