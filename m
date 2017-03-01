Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vY4mm5cLrzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 17:10:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
In-Reply-To: <87h93ec9bw.fsf@linux.vnet.ibm.com>
References: <1488276702-14646-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87h93ec9bw.fsf@linux.vnet.ibm.com>
Date: Wed, 01 Mar 2017 17:10:13 +1100
Message-ID: <877f495xyy.fsf@concordia.ellerman.id.au>
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

Stewart Smith <stewart@linux.vnet.ibm.com> writes:

> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>> Added check for OPAL_WRONG_STATE error code returned from OPAL.
>> Currently Linux flashes "unexpected error" over console for this
>> error. This will avoid throwing such message and return I/O error
>> for such OPAL failures.
>>
>> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
>> ---
>> Changes in v2:
>>  - Added log message indicating sleeping/offline core
>>    for OPAL_WRONG_STATE
>>
>>  arch/powerpc/platforms/powernv/opal.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 86d9fde..8af230e 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -869,8 +869,11 @@ int opal_error_code(int rc)
>>  	case OPAL_UNSUPPORTED:		return -EIO;
>>  	case OPAL_HARDWARE:		return -EIO;
>>  	case OPAL_INTERNAL_ERROR:	return -EIO;
>> +	case OPAL_WRONG_STATE:
>> +		pr_notice("%s: Core sleeping/offline\n", __func__);
>> +		return -EIO;
>
> Since this is part of opal_error_code() though, this will be printed for
> any OPAL call that returns that.
>
> Why not have the sensor code do this:
>
> rc = opal_sensor_read(foo)
> if (rc == OPAL_WRONG_STATE)
>    return -EIO;
> else
>    return oal_error_code(rc);
>
> ?

Yeah, that's exactly what I said to do, though perhaps I didn't say it
clearly enough?

   ... changing just opal_get_sensor_data() to handle
   OPAL_WRONG_STATE would be OK, with a comment explaining that we might be
   asked to read a sensor on an offline CPU and we aren't able to detect
   that.

cheers
