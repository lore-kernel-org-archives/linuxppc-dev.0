Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZsH6sYVzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:41:55 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8C4bnZl020811
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:41:53 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ccg9ef6c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:41:53 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 12 Sep 2016 14:41:50 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F2632CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:41:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8C4fmsQ459162
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:41:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8C4fmZG006815
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:41:48 +1000
Subject: Re: [PATCH 3/3] powerpc/eeh: Skip finding bus until after failure
 reporting
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20160912041724.16646-1-ruscur@russell.cc>
 <20160912041724.16646-3-ruscur@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 12 Sep 2016 14:41:47 +1000
MIME-Version: 1.0
In-Reply-To: <20160912041724.16646-3-ruscur@russell.cc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <96f9bb45-4191-f3c3-f016-31503ace6313@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/16 14:17, Russell Currey wrote:
> In eeh_handle_special_event(), eeh_pe_bus_get() is called before calling
> eeh_report_failure() on every device under a PE.  If a PE was missing a
> bus for some reason, the error would occur before reporting failure, even
> though eeh_report_failure() doesn't require a bus.
>
> Fix this by moving the bus retrieval and error check after the
> eeh_report_failure() calls.
>
> Cc: stable #3.10+
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
