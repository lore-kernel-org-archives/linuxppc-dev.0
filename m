Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNyLF3YL7zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 11:52:37 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G0mscm146279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 19:52:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28my6xwf17-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 19:52:35 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 19:52:33 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
In-Reply-To: <47cb309b-f33a-9084-ad6c-f68f0e28a428@linux.vnet.ibm.com>
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87sho58ifo.fsf@concordia.ellerman.id.au>
 <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
 <87a89qsyxd.fsf@concordia.ellerman.id.au>
 <47cb309b-f33a-9084-ad6c-f68f0e28a428@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 11:52:24 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efyz7y9j.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
> On Monday 13 February 2017 06:13 AM, Michael Ellerman wrote:
>> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>>
>>> OPAL returns OPAL_WRONG_STATE for XSCOM operations
>>>
>>> done to read any core FIR which is sleeping, offline.
>> OK.
>>
>> Do we know why Linux is causing that to happen?
>
> This issue is originally seen upon running STAF (Software Test
> Automation Framework) stress tests and off-lining some cores
> with stress tests running.
>
> It can also be re-created after off-lining few cores and following
> one of below methods.
> 1. Executing Linux "sensors" command
> 2. Reading contents of file /sys/class/hwmon/hwmon0/tempX_input,
>     where X is offline CPU.
>
> Its "opal_get_sensor_data" Linux API that that triggers
> OPAL call "opal_sensor_read", performing XSCOM ops here.
> If core is found sleeping/offline Linux throws up
> "opal_error_code: Unexpected OPAL error" error onto console.
>
> Currently Linux isn't aware about OPAL_WRONG_STATE return code
> from OPAL. Thus it prints "Unexpected OPAL error" message, same
> as it would log for any unknown OPAL return codes.
>
> Seeing this error over console has been a concern for Test and
> would puzzle real user as well. This patch makes Linux aware about
> OPAL_WRONG_STATE return code from OPAL and stops printing
> "Unexpected OPAL error" message onto console for OPAL fails
> with OPAL_WRONG_STATE

Ahh... so this is a DTS sensor, which indeed is just XSCOMs and we
return the xscom_read return code in event of error.

I would argue that converting to EIO in that instance is probably
correct... or EAGAIN? EAGAIN may be more correct in the situation where
the core is just sleeping.

What kind of offlining are you doing?

Arguably, the correct behaviour would be to remove said sensors when the
core is offline.

>> It's also returned from many of the XIVE routines if we're in the wrong
>> xive mode, all of which would indicate a fairly bad Linux bug.
>>
>> Also the skiboot patch which added WRONG_STATE for XSCOM ops did so
>> explicitly so we could differentiate from other errors:
>>
>>      commit 9c2d82394fd2303847cac4a665dee62556ca528a
>>      Author:     Russell Currey <ruscur@russell.cc>
>>      AuthorDate: Mon Mar 21 12:00:00 2016 +1100
>>
>>      xscom: Return OPAL_WRONG_STATE on XSCOM ops if CPU is asleep
>>      
>>      xscom_read and xscom_write return OPAL_SUCCESS if they worked, and
>>      OPAL_HARDWARE if they didn't.  This doesn't provide information about why
>>      the operation failed, such as if the CPU happens to be asleep.
>>      
>>      This is specifically useful in error scanning, so if every CPU is being
>>      scanned for errors, sleeping CPUs likely aren't the cause of failures.
>>      
>>      So, return OPAL_WRONG_STATE in xscom_read and xscom_write if the CPU is
>>      sleeping.
>>      
>>      Signed-off-by: Russell Currey <ruscur@russell.cc>
>>      Reviewed-by: Alistair Popple <alistair@popple.id.au>
>>      Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>>
>>
>>
>> So I'm still not convinced that quietly swallowing this error and
>> mapping it to -EIO along with several of the other error codes is the
>> right thing to do.
>
> How about returning -ENXIO upon receiving OPAL_WRONG_STATE ?

I think ENXIO would be incorrect, as it is "No such device or address"
when that almost certainly isn't the case. It's a solvable error -
there's just some XSCOMS you can't do at certain times.


-- 
Stewart Smith
OPAL Architect, IBM.
