Return-Path: <eranian@google.com>
Received: from mail-oa0-x22d.google.com (mail-oa0-x22d.google.com
 [IPv6:2607:f8b0:4003:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 104312C032D
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 21:14:32 +1000 (EST)
Received: by mail-oa0-f45.google.com with SMTP id o17so477644oag.18
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Sep 2013 04:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <524006C4.3010006@linux.vnet.ibm.com>
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
 <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
 <524006C4.3010006@linux.vnet.ibm.com>
Date: Thu, 26 Sep 2013 13:14:29 +0200
Message-ID: <CABPqkBR0koi7Swzqxg2nhjDsXyfLCSdR5qtB7XuBwxfCxaRO0A@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
From: Stephane Eranian <eranian@google.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
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

On Mon, Sep 23, 2013 at 11:15 AM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> On 09/21/2013 12:25 PM, Stephane Eranian wrote:
>> On Tue, Sep 10, 2013 at 4:06 AM, Michael Ellerman
>> <michael@ellerman.id.au> wrote:
>>> >
>>> > On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
>>>> > >       This patchset is the re-spin of the original branch stack sampling
>>>> > > patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>>>> > > also enables SW based branch filtering support for PPC64 platforms which have
>>>> > > branch stack sampling support. With this new enablement, the branch filter support
>>>> > > for PPC64 platforms have been extended to include all these combinations discussed
>>>> > > below with a sample test application program.
>>> >
>>> > ...
>>> >
>>>> > > Mixed filters
>>>> > > -------------
>>>> > > (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
>>>> > > Error:
>>>> > > The perf.data file has no samples!
>>>> > >
>>>> > > NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
>>>> > > branches in that given set. Both the filters are mutually exclussive, so obviously no samples
>>>> > > found in the end profile.
>>> >
>>> > The semantics of multiple filters is not clear to me. It could be an OR,
>>> > or an AND. You have implemented AND, does that match existing behaviour
>>> > on x86 for example?
>>> >
>> The semantic on the API is OR. AND does not make sense: CALL & RETURN?
>> On x86, the HW filter is an OR (default: ALL, set bit to disable a
>> type). I suspect
>> it is similar on PPC.
>
> Hey Stephane,
>
> In POWER8 BHRB, we have got three HW PMU filters out of which we are trying
> to use two of them PERF_SAMPLE_BRANCH_ANY_CALL and PERF_SAMPLE_BRANCH_COND
> respectively.
>
> (1) These filters are exclusive of each other and cannot be OR-ed with each other
>
So you are saying that the HW filter is exclusive. That seems odd. But
I think it is
because of the choices is ANY. ANY covers all the types of branches. Therefore
it does not make a difference whether you add COND or not. And
vice-versa, if you
set COND, you need to disable ANY. I bet if you add other filters such
as CALL, RETURN,
then you could OR them and say: I want RETURN or CALLS.

But that's okay. The API operates in OR mode but if the HW does not
support it, you
can check the mask and reject if more than one type is set. That is
arch-specific code.
The alternative, if to only capture ANY and emulate the filter in SW.
This will work, of
course. But the downside, is that you lose the way to appreciate how
many, for instance,
COND branches you sampled out of the total number of COND branches
retired. Unless
you can count COND branches separately.





> (2) The SW filters are applied on the branch record set captured with BHRB
>     which have the HW filters applied. So the working set is already reduced
>     with the HW PMU filters. SW filter goes through the working set and figures
>     out which one of them satisfy the SW filter criteria and gets picked up. The
>     SW filter cannot find out branches records which matches the criteria outside
>     of BHRB captured set. So we cannot OR the filters.
>
Yes, you can if you set the HW filter to ANY. And then filter the
branches by type
based on the SW mask. You need to decode each sampled branch for that. This
is done in X86 to work around HW bugs in the HW filter, for instance.

>     This makes the combination of HW and SW filter inherently an "AND" not OR.
>
> (3) But once we have captured the BHRB filtered data with HW PMU filter, multiple SW
>     filters (if requested) can be applied either in OR or AND manner.
>
>         It should be either like
>                 (1) (HW_FILTER_1) && (SW_FILTER_1) && (SW_FILTER_2)
>         or like
>                 (2) (HW_FILTER_1) && (SW_FILTER_1 || SW_FILTER_2)
>
>     NOTE: I admit that the current validate_instruction() function does not do
>     either of them correctly. Will fix it in the next iteration.
>
Just set the HW filter to ANY and filter in SW.
Isn't that possible?

> (4) These combination of filters are not supported right now because
>
>         (a) We are unable to process two HW PMU filters simultaneously
>         (b) We have not worked on replacement SW filter for either of the HW filters
>
>         (1) (HW_FILTER_1), (HW_FILTER_2)
>         (2) (HW_FILTER_1), (HW_FILTER_2), (SW_FILTER_1)
>         (3) (HW_FILTER_1), (HW_FILTER_2), (SW_FILTER_1), (SW_FILTER_2)
>
>    How ever these combination of filters can be supported right now.
>
>         (1) (HW_FILTER_1)
>         (2) (HW_FILTER_2)
>
>         (3) (SW_FILTER_1)
>         (4) (SW_FILTER_2)
>         (5) (SW_FILTER_1), (SW_FILTER_2)
>
>         (6)  (HW_FILTER_1), (SW_FILTER_1)
>         (7)  (HW_FILTER_1), (SW_FILTER_2)
>         (8)  (HW_FILTER_1), (SW_FILTER_1), (SW_FILTER_2)
>         (9)  (HW_FILTER_2), (SW_FILTER_1)
>         (10) (HW_FILTER_2), (SW_FILTER_2)
>         (11) (HW_FILTER_2), (SW_FILTER_1), (SW_FILTER_2)
>
>
> Given the situation as explained here, which semantic would be better for single
> HW and multiple SW filters. Accordingly validate_instruction() function will have
> to be re-implemented. But I believe OR-ing the SW filters will be preferable.
>
>         (1) (HW_FILTER_1) && (SW_FILTER_1) && (SW_FILTER_2)
>         or
>         (2) (HW_FILTER_1) && (SW_FILTER_1 || SW_FILTER_2)
>
> Please let me know your inputs and suggestions on this. Thank you.
>
> Regards
> Anshuman
>
