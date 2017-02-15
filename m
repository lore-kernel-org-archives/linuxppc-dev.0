Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNr8d6rCFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 07:13:52 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FK4N0u017291
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:13:49 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mstf2yn7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:13:49 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 06:13:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BEC883578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 07:13:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FKDawS33685658
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 07:13:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FKDCZs022314
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 07:13:12 +1100
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87sho58ifo.fsf@concordia.ellerman.id.au>
 <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
 <87a89qsyxd.fsf@concordia.ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 01:42:49 +0530
MIME-Version: 1.0
In-Reply-To: <87a89qsyxd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <47cb309b-f33a-9084-ad6c-f68f0e28a428@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks!! for review.

Answers to your questions as below:


On Monday 13 February 2017 06:13 AM, Michael Ellerman wrote:
> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>
>> OPAL returns OPAL_WRONG_STATE for XSCOM operations
>>
>> done to read any core FIR which is sleeping, offline.
> OK.
>
> Do we know why Linux is causing that to happen?

This issue is originally seen upon running STAF (Software Test
Automation Framework) stress tests and off-lining some cores
with stress tests running.

It can also be re-created after off-lining few cores and following
one of below methods.
1. Executing Linux "sensors" command
2. Reading contents of file /sys/class/hwmon/hwmon0/tempX_input,
    where X is offline CPU.

Its "opal_get_sensor_data" Linux API that that triggers
OPAL call "opal_sensor_read", performing XSCOM ops here.
If core is found sleeping/offline Linux throws up
"opal_error_code: Unexpected OPAL error" error onto console.

Currently Linux isn't aware about OPAL_WRONG_STATE return code
from OPAL. Thus it prints "Unexpected OPAL error" message, same
as it would log for any unknown OPAL return codes.

Seeing this error over console has been a concern for Test and
would puzzle real user as well. This patch makes Linux aware about
OPAL_WRONG_STATE return code from OPAL and stops printing
"Unexpected OPAL error" message onto console for OPAL fails
with OPAL_WRONG_STATE

>
> It's also returned from many of the XIVE routines if we're in the wrong
> xive mode, all of which would indicate a fairly bad Linux bug.
>
> Also the skiboot patch which added WRONG_STATE for XSCOM ops did so
> explicitly so we could differentiate from other errors:
>
>      commit 9c2d82394fd2303847cac4a665dee62556ca528a
>      Author:     Russell Currey <ruscur@russell.cc>
>      AuthorDate: Mon Mar 21 12:00:00 2016 +1100
>
>      xscom: Return OPAL_WRONG_STATE on XSCOM ops if CPU is asleep
>      
>      xscom_read and xscom_write return OPAL_SUCCESS if they worked, and
>      OPAL_HARDWARE if they didn't.  This doesn't provide information about why
>      the operation failed, such as if the CPU happens to be asleep.
>      
>      This is specifically useful in error scanning, so if every CPU is being
>      scanned for errors, sleeping CPUs likely aren't the cause of failures.
>      
>      So, return OPAL_WRONG_STATE in xscom_read and xscom_write if the CPU is
>      sleeping.
>      
>      Signed-off-by: Russell Currey <ruscur@russell.cc>
>      Reviewed-by: Alistair Popple <alistair@popple.id.au>
>      Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>
>
>
> So I'm still not convinced that quietly swallowing this error and
> mapping it to -EIO along with several of the other error codes is the
> right thing to do.

How about returning -ENXIO upon receiving OPAL_WRONG_STATE ?

while -EIO remains to be returned for OPAL_HARDWARE.

I can send out new patch doing pr_notice for fails with supported OPAL
return codes and pr_err for any unexpected OPAL return code. So this way
we will have logging of any OPAL call failure onto Linux log and only
unexpected OPAL error codes would get flashed onto console.

>
> cheers
>
