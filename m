Return-Path: <garsilva@embeddedor.com>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.145.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR7R819KczDr4w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 12:50:28 +1100 (AEDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 1713A45BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 19:50:26 -0600 (CST)
Date: Tue, 23 Jan 2018 19:50:25 -0600
Message-ID: <20180123195025.Horde.jFf8cU7S3uOfMDaJ0BJZZXc@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/macintosh: Use true for boolean value
References: <20180123174349.GA19627@embeddedgus>
 <87vafsulq1.fsf@concordia.ellerman.id.au>
 <20180123185735.Horde.bV6oSdW0ZLemZoMF-I0rC1M@gator4166.hostgator.com>
In-Reply-To: <20180123185735.Horde.bV6oSdW0ZLemZoMF-I0rC1M@gator4166.hostgator.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Quoting "Gustavo A. R. Silva" <garsilva@embeddedor.com>:

> Quoting Michael Ellerman <mpe@ellerman.id.au>:
>
>> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
>>
>>> Assign true or false to boolean variables instead of an integer value.
>>>
>>> This issue was detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>> drivers/macintosh/windfarm_pm72.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This seems to be common across all those drivers. Can you please send
>> one patch to fix them all to use bool:
>>
>>  $ git grep "started = " drivers/macintosh/
>>  drivers/macintosh/therm_adt746x.c:              int started = 0;
>>  drivers/macintosh/therm_adt746x.c:                      started = 1;
>>  drivers/macintosh/windfarm_pm112.c:             slots_started = 1;
>>  drivers/macintosh/windfarm_pm112.c:             started = 1;
>>  drivers/macintosh/windfarm_pm121.c:             pm121_started = 1;
>>  drivers/macintosh/windfarm_pm72.c:              started = 1;
>>  drivers/macintosh/windfarm_pm81.c:              wf_smu_started = 1;
>>  drivers/macintosh/windfarm_pm91.c:              wf_smu_started = 1;
>>  drivers/macintosh/windfarm_rm31.c:              started = 1;
>>
>> cheers
>
> Sure, no problem.
>
> By the way, I've just found the following similar case:
>
> --- a/drivers/macintosh/ams/ams-input.c
> +++ b/drivers/macintosh/ams/ams-input.c
> @@ -91,7 +91,7 @@ static int ams_input_enable(void)
>  		return error;
>  	}
>
> -	joystick = 1;
> +	joystick = true;
>
>  	return 0;
>  }
> @@ -104,7 +104,7 @@ static void ams_input_disable(void)
>  		ams_info.idev = NULL;
>  	}
>
> -	joystick = 0;
> +	joystick = false;
>  }
>
> Do you want me to include them all in the same patch?
>

I sent separate patches for this.

Thanks
--
Gustavo
