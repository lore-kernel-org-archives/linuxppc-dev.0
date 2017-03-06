Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcVsb31JQzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:56:19 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26Js4IZ053536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 14:56:16 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 291ddethhu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 14:56:16 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 05:56:13 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BF4F63578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:56:10 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26Ju2qF47317232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 06:56:10 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26Jtb76024859
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 06:55:37 +1100
Subject: Re: [PATCH v3] powernv/sensor: Handle OPAL_WRONG_STATE error return
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1488707468-16643-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87lgsipx5l.fsf@concordia.ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Tue, 7 Mar 2017 01:25:20 +0530
MIME-Version: 1.0
In-Reply-To: <87lgsipx5l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <18095c29-2323-1efd-c19a-26abafd9752d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 06 March 2017 03:03 PM, Michael Ellerman wrote:
> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>
>> OPAL returns OPAL_WRONG_STATE upon failing to provide
>> sensor data due to core sleeping/offline. Added check
>> for OPAL_WRONG_STATE rerurn code with sensor read failure.
>> Also added a log message indicating sensor data being
>> queried for sleeping/offline core.
>>
>> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
>> ---
>> Changes in v3:
>>   - Added a new case for OPAL_WRONG_STATE in sensor read
>>     along with a log message indicating sleeping/offline core
>>     causing read fail.
>>
>>   arch/powerpc/platforms/powernv/opal-sensor.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
>> index 308efd1..fb6d6bb 100644
>> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
>> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
>> @@ -64,6 +64,12 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
>>   		*sensor_data = be32_to_cpu(data);
>>   		break;
>>   
>> +	case OPAL_WRONG_STATE:
>> +		pr_notice("%s: Sensor data read failure due to "
>> +				"core sleeping/offline\n", __func__);
> I don't think it should print.
>
> It's not the users fault, or anything they can prevent. It's a
> mis-feature (aka. bug) in the driver that it queries sensors for offline
> CPUs. At least it should be ratelimited.
>
> I thought the entire motivation for the patch in the first place was
> that we were spamming the console with messages?

Yes. Correct.
To avoid flooding console, logged message using pr_notice.
I think, it was suggested in previous reviews to log a message before
returning -EIO.
Shall i directly return -EIO without any log message ?

> cheers
>
