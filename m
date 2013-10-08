Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93C3B2C00B3
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Oct 2013 18:22:26 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 12:52:21 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C7985E0059
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Oct 2013 12:53:33 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r987MEtM42270906
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Oct 2013 12:52:14 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r987MFhR004838
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Oct 2013 12:52:15 +0530
Message-ID: <5253B26E.3020800@linux.vnet.ibm.com>
Date: Tue, 08 Oct 2013 12:51:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling
 PMU interrupts
References: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
 <20131008042137.GE31666@concordia>
In-Reply-To: <20131008042137.GE31666@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/2013 09:51 AM, Michael Ellerman wrote:
> On Mon, Oct 07, 2013 at 10:00:26AM +0530, Anshuman Khandual wrote:
>> Right now the `config_bhrb` PMU specific call happens after write_mmcr0
>> which actually enables the PMU for event counting and interrupt. So
>> there is a small window of time where the PMU and BHRB runs without the
>> required HW branch filter (if any) enabled in BHRB. This can cause some
>> of the branch samples to be collected through BHRB without any filter
>> being applied and hence affecting the correctness of the results. This
>> patch moves the BHRB config function call before enabling the interrupts.
> 
> Patch looks good.
> 
> But it reminds me I have an item in my TODO list:
>  - "Why can't config_bhrb() be done in compute_mmcr()" ?
> 

compute_mmcr() function deals with generic MMCR* configs for normal PMU
events. Even if BHRB config touches MMCRA register, it's configuration
does not interfere with the PMU config for general events. So its best
to keep them separate. Besides, we can always look at these code consolidation
issues in future. But this patch solves a problem which is happening right now.

Regards
Anshuman
