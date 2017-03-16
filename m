Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQqC106LzDrMd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:14:46 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GBDVbd094835
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 07:14:44 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297r0cwj1t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 07:14:43 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 07:14:43 -0400
Date: Thu, 16 Mar 2017 16:44:38 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] powerpc/64s: stop using bit in HSPRG0 to test winkle
Reply-To: ego@linux.vnet.ibm.com
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314092349.10981-3-npiggin@gmail.com>
Message-Id: <20170316111438.GA16462@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Tue, Mar 14, 2017 at 07:23:43PM +1000, Nicholas Piggin wrote:
> The POWER8 idle code has a neat trick of programming the power on engine
> to restore a low bit into HSPRG0, so idle wakeup code can test and see
> if it has been programmed this way and therefore lost all state, and
> avoiding the expensive full restore if not.
> 
> However this messes with our r13 PACA pointer, and requires HSPRG0 to
> be written to throughout the exception handlers and idle wakeup, rather
> than just once on kernel entry.
> 
> Remove this complexity and assume winkle sleeps always require a state
> restore. This speedup is later re-introduced by counting per-core winkles
> and setting a bitmap of threads with state loss when all are in winkle.
>

Looks good to me.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


--
Thanks and Regards
gautham.
