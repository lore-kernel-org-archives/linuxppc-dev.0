Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CFB1DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 00:49:19 +1100 (EST)
Message-Id: <C33213CA-9EE4-4496-8D32-3832AEA1FB41@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40903170645p43aa4790ve4f48ea472751987@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Enable CPU_FTR_NEED_COHERENT for MPC52xx
Date: Tue, 17 Mar 2009 08:49:11 -0500
References: <20090311222615.63410@gmx.net>
	<1237197925-71727-1-git-send-email-kosmo@semihalf.com>
	<fa686aa40903162054v2d28fc2er53aa4f71837110a2@mail.gmail.com>
	<fa686aa40903162143j5f641d7dob53b96b681737e07@mail.gmail.com>
	<396BE890-40BF-451E-AE3E-2E2E1D440951@freescale.com>
	<fa686aa40903170645p43aa4790ve4f48ea472751987@mail.gmail.com>
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 17, 2009, at 8:45 AM, Grant Likely wrote:

> On Tue, Mar 17, 2009 at 6:10 AM, Kumar Gala  
> <kumar.gala@freescale.com> wrote:
>> On Mar 16, 2009, at 11:43 PM, Grant Likely wrote:
>>> diff --git a/arch/powerpc/include/asm/cputable.h
>>> b/arch/powerpc/include/asm/cput
>>> index 4911104..48d7f5f 100644
>>> --- a/arch/powerpc/include/asm/cputable.h
>>> +++ b/arch/powerpc/include/asm/cputable.h
>>> @@ -348,8 +348,15 @@ extern const char *powerpc_base_platform;
>>>           CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
>>> #define CPU_FTRS_82XX  (CPU_FTR_COMMON | \
>>>           CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
>>> +
>>> +#if defined(CONFIG_PPC_MPC52xx)
>>> +#define CPU_FTRS_G2_LE (CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
>>> +           CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |
>>> CPU_FTR_NEED_COHERENT)
>>> +#else
>>> #define CPU_FTRS_G2_LE (CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
>>>           CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP)
>>> +#endif
>>> +
>>> #define CPU_FTRS_E300  (CPU_FTR_MAYBE_CAN_DOZE | \
>>>           CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
>>>           CPU_FTR_COMMON)
>>
>> Doing this via a static CPU FTR fixup isn't really the best way to  
>> handle
>> it.  I was thinking about this the other day in my patch to  
>> actually make
>> G2/e300 cores respect _PAGE_COHERENT.  We really should set this  
>> via a
>> platform fixup.  Just not sure if that's soon enough.
>
> I agree, but as Ben pointed out last night on IRC, feature fixup
> (early_init) occurs well before platform probe time.  Platform code
> cannot fix it up until someone does the work of making platform probe
> time earlier.  It's non-trivial.
>
> However, I need to get a fix in for this ASAP, otherwise the 5200 will
> be broken in 2.6.29.  I don't see this patch as a final solution, but
> it works as a stop-gap until platform probing can be reworked.

So for .29 lets just go with the easy solution of adding  
CONFIG_PPC_MPC52xx to the list that set CPU_FTR_NEED_COHERENT (10x,  
83xx, etc..).

- k
