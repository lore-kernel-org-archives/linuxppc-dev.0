Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYccp2szqzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 16:04:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rYccn6Jycz9ssP
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 16:04:25 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L644uk025813
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 02:04:24 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2cqxxxg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 02:04:23 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 16:04:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4AFD22CE8056
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 16:04:18 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L64IEi2490812
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 16:04:18 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L64Hda027877
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 16:04:18 +1000
Date: Tue, 21 Jun 2016 16:04:16 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc/powernv: Exclude MSI region in extended bridge window
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1466476865-13425-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <3rYZXm3HTnz9sxS@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3rYZXm3HTnz9sxS@ozlabs.org>
Message-Id: <20160621060416.GA30118@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 02:30:48PM +1000, Michael Ellerman wrote:
>On Tue, 2016-21-06 at 02:41:05 UTC, Gavin Shan wrote:
>> The windows of root port and bridge behind that are extended to
>> the PHB's windows to accomodate the PCI hotplug happening in
>> future. The PHB's 64KB 32-bits MSI region is included in bridge's
>> M32 windows (in hardware) though it's excluded in the corresponding
>> resource, as the bridge's M32 windows have 1MB as their minimal
>> alignment. We observed EEH error during system boot when the MSI
>> region is included in bridge's M32 window.
>> 
>> This excludes top 1MB (including 64KB 32-bits MSI region) region
>> from bridge's M32 windows when extending them.
>
>AFAICS you added that code in "powerpc/powernv: Extend PCI bridge resources", so
>I'll squash it into that. That way there is no window of breakage.
>

Yeah, I guess it's the best way to go. Thanks a lot, Michael.

Thanks,
Gavin
