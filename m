Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYs9n1bWqzDqH8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 23:31:09 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v22CT6PC113604
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 07:31:07 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xc5j3ggd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 07:31:06 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 2 Mar 2017 18:01:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 29129125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 18:01:14 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v22CV1PY13041912
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 18:01:01 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v22CV0id029211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 18:01:01 +0530
Subject: Re: [PATCH v2] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1488276702-14646-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87h93ec9bw.fsf@linux.vnet.ibm.com>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Thu, 2 Mar 2017 18:00:55 +0530
MIME-Version: 1.0
In-Reply-To: <87h93ec9bw.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <06aa944f-84c8-7254-265b-53d56a888fd1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stewart/Michael,

Thanks!! for review.

Responses as below:


On Wednesday 01 March 2017 02:38 AM, Stewart Smith wrote:
> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>> Added check for OPAL_WRONG_STATE error code returned from OPAL.
>> Currently Linux flashes "unexpected error" over console for this
>> error. This will avoid throwing such message and return I/O error
>> for such OPAL failures.
>>
>> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
>> ---
>> Changes in v2:
>>   - Added log message indicating sleeping/offline core
>>     for OPAL_WRONG_STATE
>>
>>   arch/powerpc/platforms/powernv/opal.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 86d9fde..8af230e 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -869,8 +869,11 @@ int opal_error_code(int rc)
>>   	case OPAL_UNSUPPORTED:		return -EIO;
>>   	case OPAL_HARDWARE:		return -EIO;
>>   	case OPAL_INTERNAL_ERROR:	return -EIO;
>> +	case OPAL_WRONG_STATE:
>> +		pr_notice("%s: Core sleeping/offline\n", __func__);
>> +		return -EIO;
> Since this is part of opal_error_code() though, this will be printed for
> any OPAL call that returns that.

opal_error_coder is used by functions to handle OPAL error codes
and return Linux error codes. Apart from opal_get_sensor_data ()
in opal-sensor.c, opal_error_code  is also getting invoked from
opal_get_sys_param( ) in opal-sysparam.c.

Handling OPAL_WRONG_STATE in opal_error_code itself, seems
modular  and avoids extra checks for OPAL_WRONG_STATE after
opal_error_code usage in multiple functions.

opal_error_code is already adding a message upon OPAL_WRONG_STATE
return, so its already leaving trace about Sleeping core causing XSCOM
failure. By returning OPAL_WRONG_CODE from opal_error_code are we
planning some action like on-lining back the sleeping or off-lined core ?

>
> Why not have the sensor code do this:
>
> rc = opal_sensor_read(foo)
> if (rc == OPAL_WRONG_STATE)
>     return -EIO;
> else
>     return oal_error_code(rc);
>
> ?
>
>>   	default:
>> -		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
>> +		pr_err("%s: Unexpected OPAL error %d\n", __func__, rc);
> Do we need this?
>

This print helps in alerting about OPAL return codes that aren't 
supported in
running Linux version. Helpful in catching OPAL return code that missed
out detection check in Linux.
Shall we consider reducing message severity from pr_err to pr_warn ?
