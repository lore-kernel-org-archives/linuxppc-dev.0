Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp4Yv5sCXzDrFm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 14:45:23 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u943hSIG016750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 23:45:21 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25uy9kjwde-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 23:45:21 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 4 Oct 2016 13:45:18 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 70E793578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 14:45:16 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u943jG1860358854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 14:45:16 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u943jF8h026171
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 14:45:16 +1100
Subject: Re: [PATCH] cxl: Flush PSL cache before resetting the adapter
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
References: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 4 Oct 2016 14:45:15 +1100
MIME-Version: 1.0
In-Reply-To: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5bb4389d-c76a-0d10-08a5-2d8ef6bae5c3@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/16 06:36, Frederic Barrat wrote:
> If the capi link is going down while the PSL owns a dirty cache line,
> any access from the host for that data could lead to an Unrecoverable

IIRC, s/Unrecoverable/Uncorrectable/

> Error.
> So when resetting the capi adapter through sysfs, make sure the PSL
> cache is flushed. It won't help if there are any active Process
> Elements on the card, as the cache would likely get new dirty cache
> lines immediately, but if resetting an idle adapter, it should avoid
> any bad surprises from data left over from terminated Process Elements.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Otherwise looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
