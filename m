Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D98D4DDF07
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 00:42:25 +1000 (EST)
Message-Id: <E91EB0E1-DAEB-4CC5-B601-C12A5D4F2F4F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <7FE83D5F-6D1C-41F2-8823-868B30A2BDE3@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 09:42:12 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
	<B9E4053C-723F-4BB2-B789-F3F18BA04C4B@kernel.crashing.org>
	<7FE83D5F-6D1C-41F2-8823-868B30A2BDE3@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 9:32 AM, Olof Johansson wrote:

> On Jun 17, 2008, at 8:56 AM, Kumar Gala wrote:
>
>>
>> On Jun 16, 2008, at 2:26 PM, Olof Johansson wrote:
>>
>>> On Jun 16, 2008, at 10:46 AM, Kumar Gala wrote:
>>>> +		.machine_check		= machine_check_e500,
>>>> +		.platform		= "ppc4080",
>>>
>>> Do you really want the platform to be this specific?
>>
>> I need to look at how this is being used.  I remember having a  
>> discussion with Paul about this when introduced platform.
>
> It's used by the AUX vector (AT_PLATFORM), i.e. ld.so can use it to  
> load platform-optimized libraries. As such, you probably want it to  
> be e500mc instead.

Yeah, already changed it to ppce500mc.

>>> Why make E500MC a config option, if it's so similar? This way you  
>>> can't make a kernel with SPE support that can boot on both  
>>> e500{,v2} and e500mc...
>>
>> I need it for the various things that are compile time, like cache  
>> line size, and lwsync support.  If we can get rid of it in the  
>> future great.
>
> I got away without doing that on pa6t since we had the same  
> cacheline size but ppc64 has a larger value by default so all that  
> hurt by it was some padding/alignment being larger than required.  
> I'm sure some of the lowend guys won't be happy if you increase the  
> alignment so raising the default is out of the picture, I agree with  
> that.
>
> But: since the cacheline is available in cputable, it can still be  
> used at runtime, so as long as the alignments are large enough,  
> stuff like the dcbz loops should still be OK (might need an audit  
> though to make sure there's nothing missed). With that, you could at  
> least still boot an E500MC kernel on E500.

Its not as simple as that since there are assumptions about how many  
bytes a dcbz will clear.

>> Since I have to have PPC_E500MC I might as well not provide the  
>> option to enable SPE since it doesnt exist on e500mc.
>
> With the above, if the line size is used from cputable you should be  
> able to boot an e500mc kernel on e500.

This is a goal I have, but we need to work towards it.  For example  
LWSYNC vs SYNC is a #define right now.

- k
