Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF3f40nhzzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 17:23:07 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4P7IYhH011389
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 03:23:05 -0400
Message-Id: <201605250723.u4P7IYhH011389@mx0a-001b2d01.pphosted.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 234qj1hhxp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 03:23:05 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 25 May 2016 12:53:01 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9E532E0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:56:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P7Mv7Q43450610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:52:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P7Mu3k004309
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:52:57 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [v5,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
In-Reply-To: <324850BE-6213-41ED-87B1-33A726D56AD8@linux.vnet.ibm.com>
References: <1464007742-1941-1-git-send-email-felix@linux.vnet.ibm.com>
 <87mvngx7oq.fsf@vajain21.in.ibm.com>
 <324850BE-6213-41ED-87B1-33A726D56AD8@linux.vnet.ibm.com>
Date: Wed, 25 May 2016 12:52:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matt,

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:
> The purpose for the count is so the AFU driver is only called when it
> has something to send. Otherwise we don't want to be called.

Agreed, but this opens up a possible boundary condition where in we have
non-zero event count and deliver_event callback returns a NULL/empty
struct (This isn't handled correctly at the moment). Imo the condition
event-count == number-of-calls-to-deliver_events is bit too rigid.

Instead a more relaxed condition can be number-of-calls-to-deliver_event ==
count-until-deliver_event-returns-NULL. This could be implemented as
boolean flag inside the context to indicate that afu-driver has some
events queued. This flag can be set when cxl_context_events_pending gets
called. The cxl code can simply call deliver_event on each read call
untill it returns NULL in which case this boolean flag is reset.

This should slightly simplify the code flow at the afu-driver end as
enquing to an event need not be paired by a call to
cxl_context_events_pending. It can quite possibly enqueue bunch of
events and then do a single call to cxl_context_events_pending. In this
case the function cxl_context_events_pending essentially works more like
a function named as cxl_context_events_flush.

~ Vaibhav
