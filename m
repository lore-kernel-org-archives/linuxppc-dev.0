Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC122DE1F1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:28:43 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Thu, 25 Jan 2007 02:28:30 -0600
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2007, at 2:25 AM, Zhu Ebony-r57400 wrote:

>
>> No, I think the round handler should try to do the rounding
>> by hand.
>> Since you have the non rounded information provided by HW,
>> its much simpler to just do the rounding step.
>
> Hi Kumar,
>
> I have some new thoughts about rounding handler.
> Suppose we set SPEFSCR[FRMC]=0b10 (rounding towards +Inf) and
> a normal "efsmul" may generate rounding interrupt. At this time,
> according
> to manual, unrounded (truncated) result is placed in the target
> register. Please
> note the target register contains a hexadecimal representation of a
> floating point number. Since it represents a floating point number
> exactly
> so we can not round it anymore.

I don't follow what you mean by not being able to round it anymore.

> Maybe we still need to emulate the whole "efsmul" instruction by
> software.

You can't always do that.  Think about the following instruction:

	efsmul	r3, r3, r3

You'll have lost the original value of r3 when the exception occurs.

- k
