Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E0BC1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 19:42:50 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 14:12:48 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6E023394005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 14:12:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB28giBq6422922
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 14:12:44 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB28gi3F018969
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 14:12:44 +0530
Message-ID: <565EAF03.5010104@linux.vnet.ibm.com>
Date: Wed, 02 Dec 2015 14:12:43 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mikey@neuling.org,
 cyrilbur@gmail.com, scottwood@freescale.com
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/19] Context switch improvements
References: <1446079451-8774-1-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/29/2015 06:13 AM, Anton Blanchard wrote:
> Here are various improvements to our context switch path. Some of the
> highlights:
> 
> - Group all mfsprs and mtsprs in __switch_to(), which gives us a
>   10% improvement on POWER8.
> 
> - Create giveup_all() and flush_all_to_thread() so we only write the
>   MSR once, which gives us a 3% improvement on POWER8.
> 
> - Create disable_kernel_{fp,altivec,vsx,spe}() and add a debug boot
>   option (ppc_strict_facility_enable) to minimise kernel code running
>   with floating point and vector bits enabled.
> 
> - Make giveup_vsx() and flush_vsx_to_thread() handle FP and Altivec
>   state, so they behave more like their sister functions.
> 
> Scott: There are changes to the SPE code here which I have only been
> able to compile test.

Hey Anton,

Wondering if you have a git tree hosted some where to pull these patches ?

-- Anshuman
