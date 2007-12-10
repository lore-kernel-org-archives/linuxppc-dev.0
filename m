Return-Path: <galak@kernel.crashing.org>
Message-Id: <AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <B13201@freescale.com>
In-Reply-To: <6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix rounding bug in emulation for double floatoperating
Date: Mon, 10 Dec 2007 09:00:31 -0600
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
	<6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2007, at 11:25 PM, Liu Yu wrote:

>
>
>
>
>
>> -----Original Message-----
>> From: David Gibson [mailto:david@gibson.dropbear.id.au]
>> Sent: Monday, December 10, 2007 12:56 PM
>> To: Liu Yu
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] Fix rounding bug in emulation for double
>> floatoperating
>>
>>
>> On Mon, Dec 10, 2007 at 01:00:52PM +0800, Liu Yu wrote:
>>>
>>> This patch fixes rounding bug in emulation for double float
>> operating on PowerPC platform.
>>>
>>> When pack double float operand, it need to truncate the
>> tail due to the limited precision.
>>> If the truncated part is not zero, the last bit of work bit
>> (totally 3 bits) need to '|' 1.
>>>
>>> This patch is completed in _FP_FRAC_SRS_2(X,N,sz)
>> (arch/powerpc/math-emu/op-2.h).
>>> Originally the code leftwards rotates the operand to just keep the
>>> truncated part, then check whether it is zero. However, the
>> number it
>>> rotates is not correct when N is not smaller than
>> _FP_W_TYPE_SIZE, and it will cause the work bit '|' 1 in the
>> improper case.
>>>
>>> This patch fixes this issue.
>>>
>>> Signed-off-by: Liu Yu <b13201@freescale.com>
>>
>> Wow someone deciphered the hideous macro hell of the math
>> emulation code enough to fix a bug.  I don't suppose you'd
>> care to fix the millions of warnings that the math-emu code
>> generates...?
>
> Oh, I don't like macro define either. But it's really a bug...


how did you find this?

- k
