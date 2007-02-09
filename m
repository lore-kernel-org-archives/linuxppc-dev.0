Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C60CEDDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 16:29:26 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7F80@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7F80@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8EEEA9ED-284B-4201-A8AD-18C3F2F10388@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Thu, 8 Feb 2007 23:28:33 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 11:15 PM, Zhu Ebony-r57400 wrote:

>
>>>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/
>>>>> kernel/head_fsl_booke.S index 66877bd..0d05db0 100644
>>>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>>>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>>>>> @@ -705,7 +705,7 @@ #else
>>>>>  #endif /* CONFIG_SPE */
>>>>>
>>>>>  	/* SPE Floating Point Round */
>>>>> -	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception,
>>>>> EXC_XFER_EE)
>>>>> +	EXCEPTION(0x2050, SPEFloatingPointRound,
>>>>> SPEFloatingPointException_Round, EXC_XFER_EE)
>>>>>
>>>>>  	/* Performance Monitor */
>>>>>  	EXCEPTION(0x2060, PerformanceMonitor,
>>>>> performance_monitor_exception, EXC_XFER_STD) @@ -840,6 +840,8 @@
>>>>> load_up_spe:
>>>>>  	oris	r5,r5,MSR_SPE@h
>>>>>  	mtmsr	r5			/* enable use of SPE now */
>>>>>  	isync
>>>>> +	li	r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE | SPEFSCR_FUNFE |
>>>>> SPEFSCR_FOVFE)
>>>>> +	mtspr   SPRN_SPEFSCR,r5
>>>>
>>>> We should do this via INIT_THREAD, is there a reason that
>> you want to
>>>> set these always?
>>>
>>> I just thought it's the first time that an SPE instruction is
>>> encountered, so I enable the exceptions here.
>>
>> Lets do this via INIT_THREAD instead, its cleaner. (just
>> remember to add the proper ifdef protection for SPE_IEEE
>
> Talking about INIT_THREAD, I'm wondering where is the best place to
> enble the exceptions? Please advice!

What's the issue with enabling via INIT_THREAD?  am I missing something?

> And also, I will put all of your other suggestions into next patches.
> Thank you!

Ok.
