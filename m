Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvBlt0DYNzDq7N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 04:42:17 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2UHcpaS049917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 13:42:11 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29gfr2y0ax-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 13:42:10 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Fri, 31 Mar 2017 03:42:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2UHfvof51052700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 04:42:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2UHfWM7017876
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 04:41:32 +1100
Subject: Re: [PATCH v4] powernv/sensor: Handle OPAL_WRONG_STATE error return
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1489147052-9590-1-git-send-email-vipin@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 23:11:14 +0530
MIME-Version: 1.0
In-Reply-To: <1489147052-9590-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <04fa0398-8583-547d-6d33-128087bbd8ec@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Any feedback/outlook with this patch ?

Regards,
Vipin


On Friday 10 March 2017 05:27 PM, Vipin K Parashar wrote:
> OPAL returns OPAL_WRONG_STATE upon failing to provide
> sensor data due to core sleeping/offline. Added check
> in opal_get_sensor_data() for sensor read failure with
> OPAL_WRONG_STATE return code and returned -EIO.
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
> Changes in v4:
>   - Removed sleeping core log message with KERN_NOTICE priority.
>
> Changes in v3:
>   - Added a new case for OPAL_WRONG_STATE in sensor read
>     along with a log message indicating sleeping/offline core
>     causing read fail.
>
>   arch/powerpc/platforms/powernv/opal-sensor.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
> index 308efd1..aa267f1 100644
> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
> @@ -64,6 +64,10 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
>   		*sensor_data = be32_to_cpu(data);
>   		break;
>
> +	case OPAL_WRONG_STATE:
> +		ret = -EIO;
> +		break;
> +
>   	default:
>   		ret = opal_error_code(ret);
>   		break;
