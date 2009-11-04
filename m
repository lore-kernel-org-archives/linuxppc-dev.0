Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55066B7B9F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 17:25:31 +1100 (EST)
Subject: Re: mpc8548 does not make use of DMA when doing memory copy?
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <389deec70911030638g4a90dae7hd5a164e3d2bd178f@mail.gmail.com>
Date: Wed, 4 Nov 2009 00:25:06 -0600
Message-Id: <FC64291C-9A7E-486A-991E-6CB2A5D8CA27@kernel.crashing.org>
References: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>
	<15E6E326-D17B-42D7-AA22-2CA319C2A808@kernel.crashing.org>
	<389deec70911021635v6e12a976t9e20fb5f12d8987b@mail.gmail.com>
	<4AEFEC64.3070608@neli.hopto.org>
	<389deec70911030638g4a90dae7hd5a164e3d2bd178f@mail.gmail.com>
To: hank peng <pengxihan@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 3, 2009, at 8:38 AM, hank peng wrote:

> 2009/11/3 Micha Nelissen <micha@neli.hopto.org>:
>> hank peng wrote:
>>>
>>> I remember normal memory copy can also be done (chosen by user) by  
>>> DMA
>>> engine on IOP80331(Intel embedded cpu, xscale arch), so why ppc
>>> platform didn't make use of DMA doing memory copy, I think it can
>>> increase performance, please correct me if I am wrong!
>>
>> AFAIK the DMA engine has only an asynchronous mode (not very smart  
>> IMHO).
>> This means you always have the overhead of context switch +  
>> interrupt +
>> context switch, so the transfer has to be quite large for this to  
>> pay off.
>>
> but if the amount of data I want to copy is big enough? can we benefit
> from using DMA in such case?

Correct, we just don't make normal memcpy do this.  There isn't  
anything stopping specific call from using the async DMA API to get  
memcpy behavior.

- k
