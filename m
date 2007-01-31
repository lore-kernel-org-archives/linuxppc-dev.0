Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2C5CDDEB7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 01:50:02 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E85DCAD@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E85DCAD@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1B425F03-C72C-44C5-8AD0-177DFA184305@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Wed, 31 Jan 2007 08:48:55 -0600
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

>> On Jan 29, 2007, at 4:00 AM, Zhu Ebony-r57400 wrote:
>>
>>> Hi Kumar,
>>>
>>> I think enabling SPEFSCR[FINXE] or SPEFSCR[FRMC]=0b10/0b11
>> to enable
>>> FP round interrupt will cause the exception occurring very often,
>>> which will dramatically decrease the performance of SPE
>> instructions.
>>> Do you think putting an option in menuconfig to let user choose
>>> whether to enable FP round simulation is a reasonable idea?
>>
>> I don't see any issue with it, but I have to believe if you
>> want full IEEE results, you want full IEEE results for everything.
>>
>> - k
>>
>
> Agreed, we need to fully comply with IEEE754. So let's talk something
> about the handler.
>
> The round exceptions can be put into 2 categories:
>
> 1. SPEFSCR[FRMC] = 0b10 or 0b11 (rounding toward +Inf and -Inf)
> We need to handle this exception to comply with IEEE
>
> 2. SPEFSCR[FINXE] = 1
> If we enable this, round exception will occurs when inaccurate results
> are
> generated. However, I think we don't need to do so. With FINXE=0,  
> if SPE
> data
> exception occurs, we can handle the exception by existing handler,  
> which
> is fully IEEE complied, including rounding. If no data exception  
> occurs,
> HW
> can implement "round to nearest" and "round toward zero" with IEEE
> complied,
> and "round toward +Inf/-Inf" can be handled by the handler of point 1.
> So all
> the situations are covered, we do have to enable FINXE.
>
> Could you make some comments on this? Thanks!

While I agree with most of what you're saying there is one issue.  If  
the user want's an exception reported on inexact results when the  
rounding mode is set to "round to nearest" or "round towards zero".   
Of course we know when the user requests this and can enable/disable  
this exception at that point if we want to.

On a side node, wondering if you've come across this test suite:
http://www.jhauser.us/arithmetic/TestFloat.html

- k
