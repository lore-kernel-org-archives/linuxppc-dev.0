Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYYy10ZWpzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 12:04:56 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2213nT7017842
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:04:54 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28wxr1my0s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 20:04:54 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Mar 2017 11:04:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F5C33578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 12:04:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2214dL742860638
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:04:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2214D0N006483
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:04:14 +1100
Subject: Re: [RESEND-RFC v2 1/3] powerpc/eeh: Refactor
 eeh_pe_update_time_stamp() to update freeze_count
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Russell Currey <ruscur@russell.cc>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Mar 2017 12:03:47 +1100
MIME-Version: 1.0
In-Reply-To: <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <955a274e-55ff-7e8c-2ba8-c88b9be3a47e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/17 22:24, Vaibhav Jain wrote:
> This patch introduces a new function eeh_pe_update_freeze_counter()
> replacing existing function eeh_pe_update_time_stamp(). The new
> function also manages the value of reeze_count along with tstamp to
> track the number of times the PE roze in last one hour and if the
> freeze_count > eeh_max_freezes then eports an error(-ENOTRECOVERABLE)
> to indicate that the PE should be ermanently disabled.
>
> This patch should not introduce any behavioral change.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Thanks for addressing Russell's comments. Per Guilherme, your commit 
message is missing a few letters, a couple of minor style points below, 
otherwise:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

>  /**
> - * eeh_pe_update_time_stamp - Update PE's frozen time stamp
> + * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
> + * and freeze counter
>   * @pe: EEH PE
>   *
> - * We have time stamp for each PE to trace its time of getting
> - * frozen in last hour. The function should be called to update
> - * the time stamp on first error of the specific PE. On the other
> - * handle, we needn't account for errors happened in last hour.
> + * We have a freeze counter and time stamp for each PE to trace
> + * number of times the PE was frozen in the last hour. This function
> + * updates the PE's freeze counter and returns an error if its greater

it's

> + * than eeh_max_freezes. The function should be called to once every
> + * time a specific PE freezes.

"The function should be called every time the PE freezes"


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
