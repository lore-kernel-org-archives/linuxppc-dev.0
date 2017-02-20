Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRWKx5mQNzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 15:46:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Subject: Re: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
In-Reply-To: <cecc8a28-4e2f-8e03-0b1a-8a9ac60c0c71@linux.vnet.ibm.com>
References: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <87shnek9hd.fsf@concordia.ellerman.id.au>
 <72cfff06-bd93-a727-0b93-31dfa3a7ac65@linux.vnet.ibm.com>
 <8466dffc-d75c-d83a-2a4f-d567721db7d5@linux.vnet.ibm.com>
 <87h93tjqrn.fsf@concordia.ellerman.id.au>
 <cecc8a28-4e2f-8e03-0b1a-8a9ac60c0c71@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:46:13 +1100
Message-ID: <87tw7ph3l6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pan Xinhui <xinhui@linux.vnet.ibm.com> writes:

> =E5=9C=A8 2017/2/17 14:05, Michael Ellerman =E5=86=99=E9=81=93:
>> Pan Xinhui <xinhui@linux.vnet.ibm.com> writes:
>>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>>> index 9c0e17c..f6e5c3d 100644
>>> --- a/arch/powerpc/xmon/xmon.c
>>> +++ b/arch/powerpc/xmon/xmon.c
>>> @@ -76,6 +76,7 @@ static int xmon_gate;
>>>   #endif /* CONFIG_SMP */
>>>
>>>   static unsigned long in_xmon __read_mostly =3D 0;
>>> +static int xmon_off =3D !IS_ENABLED(CONFIG_XMON_DEFAULT);
>>
>> I think the logic would probably clearer if we invert this to become
>> xmon_on.
>>
> yep, make sense.
>
>>> @@ -3266,16 +3269,16 @@ static int __init setup_xmon_sysrq(void)
>>>   __initcall(setup_xmon_sysrq);
>>>   #endif /* CONFIG_MAGIC_SYSRQ */
>>>
>>> -static int __initdata xmon_early, xmon_off;
>>> +static int __initdata xmon_early;
>>>
>>>   static int __init early_parse_xmon(char *p)
>>>   {
>>>   	if (!p || strncmp(p, "early", 5) =3D=3D 0) {
>>>   		/* just "xmon" is equivalent to "xmon=3Dearly" */
>>> -		xmon_init(1);
>>>   		xmon_early =3D 1;
>>> +		xmon_off =3D 0;
>>>   	} else if (strncmp(p, "on", 2) =3D=3D 0)
>>> -		xmon_init(1);
>>> +		xmon_off =3D 0;
>>
>> You've just changed the timing of when xmon gets enabled for the above
>> two cases, from here which is called very early, to xmon_setup() which
>> is called much later in boot.
>>
>> That effectively disables xmon for most of the boot, which we do not
>> want to do.
>>
> Although it is not often that kernel got stucked during boot.

I hope you're joking! :)

cheers
