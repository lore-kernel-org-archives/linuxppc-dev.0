Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 457B5DE100
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:13:41 +1000 (EST)
Message-Id: <FA468435-A799-4EB9-8DA1-EC8F3B58EAEB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49EF560F.90208@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3] powerpc/85xx: Add P2020DS board support
Date: Wed, 22 Apr 2009 13:11:29 -0500
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
	<20090422164400.GA9592@ld0162-tx32.am.freescale.net>
	<6EC8B59D-62C8-4D9B-B548-4833A06F13AB@kernel.crashing.org>
	<49EF4E27.9020203@freescale.com>
	<95BA4C47-8B99-4E94-9855-4333BB4A751C@kernel.crashing.org>
	<49EF50EC.1040608@freescale.com>
	<E25C4315-A3BA-42DF-B2D2-B1CD2D76A03F@kernel.crashing.org>
	<49EF560F.90208@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 12:38 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Apr 22, 2009, at 12:16 PM, Scott Wood wrote:
>>> Kumar Gala wrote:
>>>> On Apr 22, 2009, at 12:04 PM, Scott Wood wrote:
>>>>> Kumar Gala wrote:
>>>>>>> If this has an elbc more recent than 1.0 (looks like it), we  
>>>>>>> should
>>>>>>> indicate that here.
>>>>>> that might be the case, but I leave it to u-boot to do that.
>>>>>
>>>>> Why?  There's no p2020 with an older eLBC, and there's no block  
>>>>> version register.
>>>> But there might be a p2020 w/a newer eLBC version in the future.
>>>
>>> At which point we can add something to u-boot -- but magic SVR  
>>> tables seem a step backward from the dts except where needed to  
>>> avoid the creation of extra dts files.
>> I don't see the value of complicating u-boot
>
> But complicating u-boot is just what you're suggesting.  Put it in  
> the dts, and u-boot has *zero* code to deal with this unless we find  
> ourselves wanting to share the dts with another board rev with a  
> newer chip with a newer elbc.
>
>> to have to parse and "fixup" the compatible instead of just having  
>> to prepend to it.  Especially since I don't believe there is  
>> anything specific we care about in the 1.2 version of elbc at this  
>> point.
>
> If the new elbc is compatible with the current one, then you will  
> still just be prepending.  If it is not, then it very likely isn't  
> compatible with 1.0 either, so you'll have to remove fsl,elbc anyway.
>
> What "we care about" at this point is irrelevant, given the PITA it  
> would be to change the device trees (or u-boot) that are already in  
> use once we do begin to care.

Which is exactly why I didn't put it in the .dts right now.  Today we  
know NO code exists that cares about "fsl,elbc-1.2". Once someone adds  
such code they can also update the .dts to match it.

- k
