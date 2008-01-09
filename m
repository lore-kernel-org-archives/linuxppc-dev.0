Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0AEADE03D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:21:13 +1100 (EST)
Message-Id: <1658343B-6560-4175-AF35-ACC237A87E50@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <6EBEC19BF4A8F843BCD6B9155BBE2515D1B70D@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix remainder calculating bug in single floating
	pointdivision
Date: Wed, 9 Jan 2008 10:19:50 -0600
References: <11996296134110-git-send-email-Yu.Liu@freescale.com><1199650065.7291.81.camel@pasglop><66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
	<C387A6C8-3FC9-4DD9-A79D-3ADAB1F5A73F@kernel.crashing.org>
	<6EBEC19BF4A8F843BCD6B9155BBE2515D1B70D@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 9:38 AM, Liu Yu wrote:

>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+b13201=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+b13201=freescale.com@ozlabs.org]
>> On Behalf Of Kumar Gala
>> Sent: Tuesday, January 08, 2008 2:20 PM
>> To: Dan Malek
>> Cc: Liu Yu; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] Fix remainder calculating bug in single
>> floating pointdivision
>>
>>
>> On Jan 6, 2008, at 2:44 PM, Dan Malek wrote:
>>
>>>
>>> On Jan 6, 2008, at 12:07 PM, Benjamin Herrenschmidt wrote:
>>>
>>>> It's nice to see somebody digging in that scary math emu stuff. If
>>>> you could also get rid of the warnings, it would be perfect :-)
>>>
>>> Yes, it is :-)  I didn't think it would have a life beyond MPC8xx.
>>>
>>>> .... that this code was lifted from
>>>> somewhere else (glibc ? gcc soft-float ?),
>>>
>>> It seems like a lifetime ago....  I copied the framework
>> from Sparc,
>>> and the internals from gcc soft-float.  I didn't change any of the
>>> internal emulation functions (hence, some of the warnings),
>> just the
>>> calling interface.
>>>
>>> While it's convenient, I still don't think kernel float emulation
>>> should be a solution.  The tools should generate soft-float for the
>>> applications and libraries.
>>
>> If we think this is really true, we could move to using include/math-
>> emu/* instead of the files in powerpc/math-emu.
>
> Why it's better to move to using include/math-emu.
> I found they have similar framework, is powerpc/math-emu evolved from
> include/math-emu?

* We dont really need more than one way in the kernel source tree to  
do math-emu
* include/math-emu is used by more archs so gets more review
* include/math-emu is closer to glibc soft-fp code so fixes to one  
apply cleanly to the other

- k
