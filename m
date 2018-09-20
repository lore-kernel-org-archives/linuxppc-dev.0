Return-Path: <srs0=2cx7=mc=linux.vnet.ibm.com=maddy@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GBzC1F0BzF3JS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 19:59:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42GBzB3s7sz8tH1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 19:59:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42GBz96nNYz9sBv
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2018 19:59:33 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8K9uvd0023765
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2018 05:59:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mm7tgm18d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2018 05:59:31 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 20 Sep 2018 10:59:29 +0100
Subject: Re: [PATCH] powerpc/perf: Add missing break in
 power7_marked_instr_event()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: maddy@linux.ibm.com, paulus@samba.org
References: <20180920094111.4125-1-mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 20 Sep 2018 15:29:22 +0530
MIME-Version: 1.0
In-Reply-To: <20180920094111.4125-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e1868207-7dd4-e6cc-0fce-04e0fd1e5edc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 20 September 2018 03:11 PM, Michael Ellerman wrote:
> In power7_marked_instr_event() there is a switch case that is missing
> a break or an explicit fallthrough, it's not immediately clear which
> it should be.
>
> The function determines based on the PMU event code, whether the event
> is a "marked" event (which then requires us to configure the PMU in a
> certain way). On Power7 there is no specific bit(s) in the event to
> tell us that, we just have to know.
>
> Rather than having a full list of every event and whether they are
> marked, we pull apart the event code and for events with certain
> values of certain fields we can say that those are all marked events.
>
> We take the psel (bits 0-7) of the event, and look at bits 4-7. For a
> value of 6 we say that if the entire psel == 0x64 then if the pmc == 3
> the event is marked, else not, and otherwise we continue.
>
> It is then that we fallthrough to the 8 case, where we return true if
> the unit == 0xd.
>
> The question is should the 6 case also fallthrough and check for
> unit == 0xd, or should it return.
>
> Looking at the full list of events we see that there are zero events
> where (psel >> 4) == 0x6 and unit == 0xd.
>
> So the answer is it doesn't really matter, there are no valid event
> codes that will return a different result whether we fallthrough or
> break.
>
> But equally, testing the 6 case events against unit == 0xd is slightly
> bogus, as there are no such events. So to make the code clearer, and
> avoid any future confusion, have the 6 case break rather than falling
> through.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Just curious to know, how did you find this. Static code checker compiled
or any specific compiler warnings or just by code read?

Maddy
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/perf/power7-pmu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
> index 7963658dbc22..6dbae9884ec4 100644
> --- a/arch/powerpc/perf/power7-pmu.c
> +++ b/arch/powerpc/perf/power7-pmu.c
> @@ -238,6 +238,7 @@ static int power7_marked_instr_event(u64 event)
>   	case 6:
>   		if (psel == 0x64)
>   			return pmc >= 3;
> +		break;
>   	case 8:
>   		return unit == 0xd;
>   	}
