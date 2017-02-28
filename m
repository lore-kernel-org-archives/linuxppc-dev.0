Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXY2s3rD4zDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 20:20:37 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S9Ihjw023325
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 04:20:35 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28vnaj4rvm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 04:20:35 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 14:50:32 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5220D394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 14:50:29 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S9KS7314221540
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 14:50:28 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S9KRTt003450
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 14:50:28 +0530
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87sho58ifo.fsf@concordia.ellerman.id.au>
 <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
 <87a89qsyxd.fsf@concordia.ellerman.id.au>
 <47cb309b-f33a-9084-ad6c-f68f0e28a428@linux.vnet.ibm.com>
 <87efyz7y9j.fsf@linux.vnet.ibm.com> <87r32th2rt.fsf@concordia.ellerman.id.au>
 <871supftry.fsf@linux.vnet.ibm.com>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Tue, 28 Feb 2017 14:50:22 +0530
MIME-Version: 1.0
In-Reply-To: <871supftry.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8f9b3e08-e680-5200-a80d-5ad1a3e8f866@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks!! for review.

Sending out v2 with  suggested changes.


On Thursday 23 February 2017 09:22 AM, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Stewart Smith <stewart@linux.vnet.ibm.com> writes:
>>
>>> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>>>> On Monday 13 February 2017 06:13 AM, Michael Ellerman wrote:
>>>>> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>>>>>
>>>>>> OPAL returns OPAL_WRONG_STATE for XSCOM operations
>>>>>>
>>>>>> done to read any core FIR which is sleeping, offline.
>>>>> OK.
>>>>>
>>>>> Do we know why Linux is causing that to happen?
>>>> This issue is originally seen upon running STAF (Software Test
>>>> Automation Framework) stress tests and off-lining some cores
>>>> with stress tests running.
>>>>
>>>> It can also be re-created after off-lining few cores and following
>>>> one of below methods.
>>>> 1. Executing Linux "sensors" command
>>>> 2. Reading contents of file /sys/class/hwmon/hwmon0/tempX_input,
>>>>      where X is offline CPU.
>>>>
>>>> Its "opal_get_sensor_data" Linux API that that triggers
>>>> OPAL call "opal_sensor_read", performing XSCOM ops here.
>>>> If core is found sleeping/offline Linux throws up
>>>> "opal_error_code: Unexpected OPAL error" error onto console.
>>>>
>>>> Currently Linux isn't aware about OPAL_WRONG_STATE return code
>>>> from OPAL. Thus it prints "Unexpected OPAL error" message, same
>>>> as it would log for any unknown OPAL return codes.
>>>>
>>>> Seeing this error over console has been a concern for Test and
>>>> would puzzle real user as well. This patch makes Linux aware about
>>>> OPAL_WRONG_STATE return code from OPAL and stops printing
>>>> "Unexpected OPAL error" message onto console for OPAL fails
>>>> with OPAL_WRONG_STATE
>>> Ahh... so this is a DTS sensor, which indeed is just XSCOMs and we
>>> return the xscom_read return code in event of error.
>>>
>>> I would argue that converting to EIO in that instance is probably
>>> correct... or EAGAIN? EAGAIN may be more correct in the situation where
>>> the core is just sleeping.
>>>
>>> What kind of offlining are you doing?
>>>
>>> Arguably, the correct behaviour would be to remove said sensors when the
>>> core is offline.
>> Right, that would be ideal. There appear to be at least two other hwmon
>> drivers that are CPU hotplug aware (coretemp and via-cputemp).
>>
>> But perhaps it's not possible to work out which sensors are attached to
>> which CPU etc., I haven't looked in detail.
> Each core-temp@ sensor has a ibm,pir property, so linking back to what
> core shouldn't be too hard. For mem-temp@ sensors, we have the chip-id.
>
>> In that case changing just opal_get_sensor_data() to handle
>> OPAL_WRONG_STATE would be OK, with a comment explaining that we might be
>> asked to read a sensor on an offline CPU and we aren't able to detect
>> that.
> Agree.
>
