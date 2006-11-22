Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAD3567C1E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 05:50:41 +1100 (EST)
In-Reply-To: <1164220570.8536.8.camel@localhost>
References: <1164208814.1954.372.camel@goblue>
	<AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
	<1164211565.4932.7.camel@otta>
	<F14C95DA-2BC6-4922-B995-ECC6CDB8306E@kernel.crashing.org>
	<1164220570.8536.8.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9C3E9F3-D229-4C2F-895A-94A5B49AB708@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] CAS DFP support
Date: Wed, 22 Nov 2006 12:51:13 -0600
To: will_schmidt@vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, Peter Bergner <bergner@rchmail.rchland.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 22, 2006, at 12:36 PM, Will Schmidt wrote:

> On Wed, 2006-22-11 at 10:41 -0600, Kumar Gala wrote:
>> On Nov 22, 2006, at 10:06 AM, Peter Bergner wrote:
>>
>>> On Wed, 2006-11-22 at 09:46 -0600, Kumar Gala wrote:
>>>> On Nov 22, 2006, at 9:20 AM, Jake Moilanen wrote:
>>>>
>>>>> When booting a Power6 in compat mode, the DFP bit must be set  
>>>>> in the
>>>>> client architecture call, or else firmware will downgrade the
>>>>> compliance
>>>>> to P5 compat mode, thus removing VMX and DFP instructions.
>>>>>
>>>>> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
>>>>>
>>>>> --- 2.6/arch/powerpc/kernel/prom_init.c~	2006-11-13
>>>>> 15:01:13.000000000
>>>>> -0600
>>>>> +++ 2.6/arch/powerpc/kernel/prom_init.c	2006-11-21
>>>>> 18:38:27.000000000
>>>>> -0600
>>>>> @@ -627,6 +627,7 @@ static void __init early_cmdline_parse(v
>>>>>  /* Option vector 3: processor options supported */
>>>>>  #define OV3_FP			0x80	/* floating point */
>>>>>  #define OV3_VMX			0x40	/* VMX/Altivec */
>>>>> +#define OV3_DFP			0x20	/* decimal floating point */
>>>>
>>>> Can we make the flag OV3_DECFP to distinguish it from Double FP.
>>>
>>> One thing OV3_DFP has going for it is that is matches the  
>>> nomenclature
>>> used by GCC, binutils.  I'm not sure what you mean by Double FP,
>>> unless
>>> you're referring to the double wide FP unit on the Blue Gene/L 440
>>> processor, but they don't refer to it as Double FP.
>>
>> I'm referring to plain old double precision floating point.  The e500
>> core from Freescale has version that provide embedded single
>> precision floating point (EFP_SINGLE) and versions that provide both
>> embedded double precision floating point (EFP_DOUBLE).  I just want
>> use to be clear the DFP could mean either double or decimal as far as
>> I'm concerned.
>
> the comment on the #define "/* decimal floating point */"  should be
> sufficient for that clarification tho, right?

For this one case it is, but I'm sure we are going to end up with  
some other defines for related to Decimal FP and I'd like them to be  
clear.

>> Also, I think the 602 (may have never seen the light of day) only
>> implemented single precision floating point.
>>
>> - k
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
