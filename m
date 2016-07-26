Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzK7h54HqzDrDt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 23:42:56 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6QDcsAV036732
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 09:42:53 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24e27c99fa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 09:42:53 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 19:12:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8FD2A125805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 19:15:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6QDgZ1X56295580
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 19:12:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6QDgh9Y022627
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 19:12:44 +0530
Subject: Re: [RFC PATCH 0/9]powerpc: "paca->soft_enabled" based local atomic
 operation implementation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au,
 anton@samba.org, paulus@samba.org
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469535674.5978.73.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 19:12:29 +0530
MIME-Version: 1.0
In-Reply-To: <1469535674.5978.73.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <907e6515-1815-61c1-ce6d-ab1855ace7f8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 05:51 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2016-07-25 at 20:22 +0530, Madhavan Srinivasan wrote:
>> But this patchset uses Benjamin Herrenschmidt suggestion of using
>> arch_local_irq_disable_var() to soft_disable interrupts (including PMIs).
>> After finishing the "op", arch_local_irq_restore() called and correspondingly
>> interrupts are replayed if any occured.
> I am not fan of "var", we probably want "level".

Sure. Will do

>
> Also be careful, you might be already soft-disabled at level 1, you
> must restore to level 1, not level 0 in that case. Might want to
> actually return the level in "flags" and restore that.

Yes. Thats correct. I return the current flag value.

Maddy

>
> Cheers,
> Ben.
>
