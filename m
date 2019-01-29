Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250BC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:49:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841EF2184D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841EF2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pvBm3qpjzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 04:49:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=embeddedor.com
 (client-ip=192.185.66.3; helo=gateway20.websitewelcome.com;
 envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=embeddedor.com
X-Greylist: delayed 1499 seconds by postgrey-1.36 at bilbo;
 Wed, 30 Jan 2019 04:47:16 AEDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com
 [192.185.66.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pv8N3CltzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 04:47:16 +1100 (AEDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway20.websitewelcome.com (Postfix) with ESMTP id 92B32400C50DE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:00:14 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id oWkAgG6ZdiQeroWkAgYHt0; Tue, 29 Jan 2019 11:00:14 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=36348 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1goWkA-003PHZ-6p; Tue, 29 Jan 2019 11:00:14 -0600
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <1548338509-628-1-git-send-email-leitao@debian.org>
 <43b1ccd5-ec7f-32de-4f30-d67dbea02d9e@embeddedor.com>
 <c9996eb1-d77d-acc4-2f7c-32893ba8a8e5@debian.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 mQINBFssHAwBEADIy3ZoPq3z5UpsUknd2v+IQud4TMJnJLTeXgTf4biSDSrXn73JQgsISBwG
 2Pm4wnOyEgYUyJd5tRWcIbsURAgei918mck3tugT7AQiTUN3/5aAzqe/4ApDUC+uWNkpNnSV
 tjOx1hBpla0ifywy4bvFobwSh5/I3qohxDx+c1obd8Bp/B/iaOtnq0inli/8rlvKO9hp6Z4e
 DXL3PlD0QsLSc27AkwzLEc/D3ZaqBq7ItvT9Pyg0z3Q+2dtLF00f9+663HVC2EUgP25J3xDd
 496SIeYDTkEgbJ7WYR0HYm9uirSET3lDqOVh1xPqoy+U9zTtuA9NQHVGk+hPcoazSqEtLGBk
 YE2mm2wzX5q2uoyptseSNceJ+HE9L+z1KlWW63HhddgtRGhbP8pj42bKaUSrrfDUsicfeJf6
 m1iJRu0SXYVlMruGUB1PvZQ3O7TsVfAGCv85pFipdgk8KQnlRFkYhUjLft0u7CL1rDGZWDDr
 NaNj54q2CX9zuSxBn9XDXvGKyzKEZ4NY1Jfw+TAMPCp4buawuOsjONi2X0DfivFY+ZsjAIcx
 qQMglPtKk/wBs7q2lvJ+pHpgvLhLZyGqzAvKM1sVtRJ5j+ARKA0w4pYs5a5ufqcfT7dN6TBk
 LXZeD9xlVic93Ju08JSUx2ozlcfxq+BVNyA+dtv7elXUZ2DrYwARAQABtCxHdXN0YXZvIEEu
 IFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPokCPQQTAQgAJwUCWywcDAIbIwUJ
 CWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBHBbTLRwbbMZ6tEACk0hmmZ2FWL1Xi
 l/bPqDGFhzzexrdkXSfTTZjBV3a+4hIOe+jl6Rci/CvRicNW4H9yJHKBrqwwWm9fvKqOBAg9
 obq753jydVmLwlXO7xjcfyfcMWyx9QdYLERTeQfDAfRqxir3xMeOiZwgQ6dzX3JjOXs6jHBP
 cgry90aWbaMpQRRhaAKeAS14EEe9TSIly5JepaHoVdASuxklvOC0VB0OwNblVSR2S5i5hSsh
 ewbOJtwSlonsYEj4EW1noQNSxnN/vKuvUNegMe+LTtnbbocFQ7dGMsT3kbYNIyIsp42B5eCu
 JXnyKLih7rSGBtPgJ540CjoPBkw2mCfhj2p5fElRJn1tcX2McsjzLFY5jK9RYFDavez5w3lx
 JFgFkla6sQHcrxH62gTkb9sUtNfXKucAfjjCMJ0iuQIHRbMYCa9v2YEymc0k0RvYr43GkA3N
 PJYd/vf9vU7VtZXaY4a/dz1d9dwIpyQARFQpSyvt++R74S78eY/+lX8wEznQdmRQ27kq7BJS
 R20KI/8knhUNUJR3epJu2YFT/JwHbRYC4BoIqWl+uNvDf+lUlI/D1wP+lCBSGr2LTkQRoU8U
 64iK28BmjJh2K3WHmInC1hbUucWT7Swz/+6+FCuHzap/cjuzRN04Z3Fdj084oeUNpP6+b9yW
 e5YnLxF8ctRAp7K4yVlvA7kCDQRbLBwMARAAsHCE31Ffrm6uig1BQplxMV8WnRBiZqbbsVJB
 H1AAh8tq2ULl7udfQo1bsPLGGQboJSVN9rckQQNahvHAIK8ZGfU4Qj8+CER+fYPp/MDZj+t0
 DbnWSOrG7z9HIZo6PR9z4JZza3Hn/35jFggaqBtuydHwwBANZ7A6DVY+W0COEU4of7CAahQo
 5NwYiwS0lGisLTqks5R0Vh+QpvDVfuaF6I8LUgQR/cSgLkR//V1uCEQYzhsoiJ3zc1HSRyOP
 otJTApqGBq80X0aCVj1LOiOF4rrdvQnj6iIlXQssdb+WhSYHeuJj1wD0ZlC7ds5zovXh+FfF
 l5qH5RFY/qVn3mNIVxeO987WSF0jh+T5ZlvUNdhedGndRmwFTxq2Li6GNMaolgnpO/CPcFpD
 jKxY/HBUSmaE9rNdAa1fCd4RsKLlhXda+IWpJZMHlmIKY8dlUybP+2qDzP2lY7kdFgPZRU+e
 zS/pzC/YTzAvCWM3tDgwoSl17vnZCr8wn2/1rKkcLvTDgiJLPCevqpTb6KFtZosQ02EGMuHQ
 I6Zk91jbx96nrdsSdBLGH3hbvLvjZm3C+fNlVb9uvWbdznObqcJxSH3SGOZ7kCHuVmXUcqoz
 ol6ioMHMb+InrHPP16aVDTBTPEGwgxXI38f7SUEn+NpbizWdLNz2hc907DvoPm6HEGCanpcA
 EQEAAYkCJQQYAQgADwUCWywcDAIbDAUJCWYBgAAKCRBHBbTLRwbbMdsZEACUjmsJx2CAY+QS
 UMebQRFjKavwXB/xE7fTt2ahuhHT8qQ/lWuRQedg4baInw9nhoPE+VenOzhGeGlsJ0Ys52sd
 XvUjUocKgUQq6ekOHbcw919nO5L9J2ejMf/VC/quN3r3xijgRtmuuwZjmmi8ct24TpGeoBK4
 WrZGh/1hAYw4ieARvKvgjXRstcEqM5thUNkOOIheud/VpY+48QcccPKbngy//zNJWKbRbeVn
 imua0OpqRXhCrEVm/xomeOvl1WK1BVO7z8DjSdEBGzbV76sPDJb/fw+y+VWrkEiddD/9CSfg
 fBNOb1p1jVnT2mFgGneIWbU0zdDGhleI9UoQTr0e0b/7TU+Jo6TqwosP9nbk5hXw6uR5k5PF
 8ieyHVq3qatJ9K1jPkBr8YWtI5uNwJJjTKIA1jHlj8McROroxMdI6qZ/wZ1ImuylpJuJwCDC
 ORYf5kW61fcrHEDlIvGc371OOvw6ejF8ksX5+L2zwh43l/pKkSVGFpxtMV6d6J3eqwTafL86
 YJWH93PN+ZUh6i6Rd2U/i8jH5WvzR57UeWxE4P8bQc0hNGrUsHQH6bpHV2lbuhDdqo+cM9eh
 GZEO3+gCDFmKrjspZjkJbB5Gadzvts5fcWGOXEvuT8uQSvl+vEL0g6vczsyPBtqoBLa9SNrS
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] powerpc/ptrace: Mitigate potential Spectre v1
Message-ID: <2db8261a-f955-23a5-7c87-bb55e59ef444@embeddedor.com>
Date: Tue, 29 Jan 2019 11:00:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c9996eb1-d77d-acc4-2f7c-32893ba8a8e5@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1goWkA-003PHZ-6p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:36348
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Breno,

On 1/29/19 10:38 AM, Breno Leitao wrote:
> Hi Gustavo,
> 
> On 1/24/19 3:25 PM, Gustavo A. R. Silva wrote:
>>
>>
>> On 1/24/19 8:01 AM, Breno Leitao wrote:
>>> 'regno' is directly controlled by user space, hence leading to a potential
>>> exploitation of the Spectre variant 1 vulnerability.
>>>
>>> On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
>>> register number that would be read or written. This register number is
>>> called 'regno' which is part of the 'addr' syscall parameter.
>>>
>>> This 'regno' value is checked against the maximum pt_regs structure size,
>>> and then used to dereference it, which matches the initial part of a
>>> Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
>>> is returned to userspace in the GETREGS case.
>>>
>>
>> Was this reported by any tool?
> 
> It was not. I was writing an userspace tool, which required me to read the
> Ptrace subsystem carefully, then, I just found this case.
> 

Great. Good catch.

>> If so, it might be worth mentioning it.
>>
>>> This patch sanitizes 'regno' before using it to dereference pt_reg.
>>>
>>> Notice that given that speculation windows are large, the policy is
>>> to kill the speculation on the first load and not worry if it can be
>>> completed with a dependent load/store [1].
>>>
>>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>  arch/powerpc/kernel/ptrace.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>>> index cdd5d1d3ae41..3eac38a29863 100644
>>> --- a/arch/powerpc/kernel/ptrace.c
>>> +++ b/arch/powerpc/kernel/ptrace.c
>>> @@ -33,6 +33,7 @@
>>>  #include <linux/hw_breakpoint.h>
>>>  #include <linux/perf_event.h>
>>>  #include <linux/context_tracking.h>
>>> +#include <linux/nospec.h>
>>>  
>>>  #include <linux/uaccess.h>
>>>  #include <linux/pkeys.h>
>>> @@ -298,6 +299,9 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
>>>  #endif
>>>  
>>>  	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
>>
>> I would use a variable to store sizeof(struct user_pt_regs) / sizeof(unsigned long).
> 
> Right.
> 
>>
>>> +		regno = array_index_nospec(regno,
>>> +				(sizeof(struct user_pt_regs) /
>>> +				 sizeof(unsigned long)));
>>
>> See the rest of my comments below.
>>
>>>  		*data = ((unsigned long *)task->thread.regs)[regno];
>>>  		return 0;
>>>  	}
>>> @@ -321,6 +325,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
>>>  		return set_user_dscr(task, data);
>>>  
>>>  	if (regno <= PT_MAX_PUT_REG) {
>>> +		regno = array_index_nospec(regno, PT_MAX_PUT_REG);
>>
>> This is wrong.  array_index_nospec() will return PT_MAX_PUT_REG - 1 in case regno is equal to
>> PT_MAX_PUT_REG, and this is not what you want.
> 
> Right, this is really wrong. It would be correct if the comparison was
> regno < PT_MAX_PUT_REG. Since it is PT_MAX_PUT_REGS is a valid array entry,
> then I need to care about this case also. Doing something as:
> 
> 	regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);
> 

This is the right way.

> Other than that, I think that for the regno = PT_MAX_PUT_REG base,
> array_index_nospec() will redefine regno to 0, not PT_MAX_PUT_REG - 1.
> 
>> Similar reasoning applies to the case above.
> 
> I understand that the case above does not seem to have the same problem,
> since it does not address over the array as done in the case above. Does it
> make sense?
> 

Yeah. I was wrong about that.  If regno is out of bounds, array_index_nospec()
will return 0.

> Anyway, this is how I am thinking the v2 of the patch:
> 

V2 looks good.

Thanks
--
Gustavo

> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index cdd5d1d3ae41..7535f89e08cd 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -33,6 +33,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/perf_event.h>
>  #include <linux/context_tracking.h>
> +#include <linux/nospec.h>
> 
>  #include <linux/uaccess.h>
>  #include <linux/pkeys.h>
> @@ -274,6 +275,8 @@ static int set_user_trap(struct task_struct *task,
> unsigned long trap)
>   */
>  int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
>  {
> +	unsigned int regs_max;
> +
>  	if ((task->thread.regs == NULL) || !data)
>  		return -EIO;
> 
> @@ -297,7 +300,9 @@ int ptrace_get_reg(struct task_struct *task, int regno,
> unsigned long *data)
>  	}
>  #endif
> 
> -	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
> +	regs_max = sizeof(struct user_pt_regs) / sizeof(unsigned long);
> +	if (regno < regs_max) {
> +		regno = array_index_nospec(regno, regs_max);
>  		*data = ((unsigned long *)task->thread.regs)[regno];
>  		return 0;
>  	}
> @@ -321,6 +326,7 @@ int ptrace_put_reg(struct task_struct *task, int regno,
> unsigned long data)
>  		return set_user_dscr(task, data);
> 
>  	if (regno <= PT_MAX_PUT_REG) {
> +		regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);
>  		((unsigned long *)task->thread.regs)[regno] = data;
>  		return 0;
>  	}
> 
