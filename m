Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CAE5B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:53:51 +1100 (EST)
In-Reply-To: <4B0D6DA3.9060906@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
	<BEFB28A5-8BA2-43F8-B917-0C838246B962@kernel.crashing.org>
	<4B0D6DA3.9060906@yaho! o.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77B73EBA-CC84-4978-993E-57DC28A74280@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 17/19] powerpc: wii: bootmii starlet 'mini' firmware
	support
Date: Thu, 26 Nov 2009 23:00:45 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Add support for the BootMii 'mini' firmware replacement for the
>>> Starlet processor.
>>>
>>> 'mini' is an open source IOS replacement written from scratch by
>>> Team Twiizers.
>>
>> It's not a replacement, it doesn't have any of the same  
>> functionality.
>
> I didn't know 'replacement' had that semantics.

It's ambiguous.

> My intention was to say that 'mini' firmware is an alternative to  
> the stock IOS firmware, not trying to imply that it behaves like it  
> or it is compatible with it.
> Point taken.
>
> I'll use 'mini' alternate firmware if that's ok.

"Alternative firmware" is fine.

>>> +enum starlet_ipc_flavour {
>>> +    STARLET_IPC_IOS,
>>> +    STARLET_IPC_MINI,
>>> +};
>>
>> I thought you don't support IOS at all anymore?
>>
>
> I don't plan to mainline IOS support.
> But to make runtime decisions I need to know if we are running  
> along the 'mini' firmware or the default IOS firmware.
> That's the intention of that enum.

>> Modern mini will always have AHBPROT set up to give you full access,
>> so this isn't needed either.
>>
>
> So we have two options here:
> - assume that whatever firmware is running properly sets AHBPROT  
> and hope it works
> - or try to use the existing firmware interfaces to check and make  
> sure that AHBPROT is indeed properly set
>
> I chose the second option here.

It is much much simpler to simply require a new enough mini :-)

>> Do you need this driver to boot?  If not, it might be best to  
>> leave it
>> out for now.
>
> Strictly speaking, we don't need the driver to boot if we asume  
> that AHBPROT is properly set.
> But we'll need it later to shutdown 'mini' drivers, unless 'mini'  
> is changed to boot PowerPC code with all hardware already  
> relinquished.
>
> That is not true for the last available version of 'mini' firmware.  
> That version still boots PowerPC code with at least the SDHCI  
> controller driven by 'mini'.

I'll fix this.


Segher
