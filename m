Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3D4F1A06B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 18:23:22 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDC0914145D
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:23:22 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 16 Nov 2015 17:23:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2E9152CE8057
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:23:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAG7Mlbq38469740
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:22:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAG7McDH018534
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2015 18:22:38 +1100
Message-ID: <5649842B.9080107@linux.vnet.ibm.com>
Date: Mon, 16 Nov 2015 12:52:19 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
 benh@kernel.crashing.org
CC: linuxppc-dev@ozlabs.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH 1/5] powerpc: Print MSR TM bits in oops message
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1447390652-28355-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/2015 10:27 AM, Michael Neuling wrote:
> Print the MSR TM bits in oops messages.  This appends them to the end
> like this:
>  MSR: 8000000502823031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[TE]>
> 
> You get the TM[] only if at least one TM MSR bit is set.  Inside the
> TM[], E means Enabled (bit 32), S means Suspended (bit 33), and T
> means Transactional (bit 34)
> 
> If no bits are set, you get no TM[] output.
> 
> Include rework of printbits() to handle this case.
> 

Just a small nit, the above commit message can be formatted better.
