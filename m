Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54F34DEC2D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 01:40:52 +1000 (EST)
Message-Id: <F7DB0156-66BA-4E52-9CA6-F1405E3D31C6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <484564EA.8050706@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Make board force selection of PHYLIB
Date: Tue, 3 Jun 2008 10:40:36 -0500
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
	<83820D83-487C-4586-9867-F4226A87A276@freescale.com>
	<48445851.4090105@garzik.org>
	<095F258F-72DD-4F27-A457-A57D9FAA1E76@kernel.crashing.org>
	<48448020.5020407@freescale.com>
	<Pine.LNX.4.64.0806030945540.21537@blarg.am.freescale.net>
	<48455EEA.3040909@freescale.com>
	<57B740A4-A3E0-4D93-A5D9-77B14C6E9E92@kernel.crashing.org>
	<484560C0.2080607@freescale.com>
	<F70B6328-5DF2-4CCC-9AAF-DD49BDA267A5@kernel.crashing.org>
	<484564EA.8050706@freescale.com>
Cc: netdev@vger.kernel.org, adrian.bunk@movial.fi,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2008, at 10:36 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Jun 3, 2008, at 10:18 AM, Scott Wood wrote:
>>> Kumar Gala wrote:
>>>> On Jun 3, 2008, at 10:10 AM, Scott Wood wrote:
>>>>> I'd rather avoid adding another case where the kernel needs to  
>>>>> know what modules are being built, though, especially if the  
>>>>> result of changing the .config and building modules is a  
>>>>> mysterious runtime failure (due to a missing platform fixup)  
>>>>> rather than compile- or insertion-time.
>>>> I don't follow what you are getting at here.  Is this something  
>>>> more than #ifdef PHYLIB in the platform code?
>>>
>>> If you just #ifdef PHYLIB, then things will break if the user does  
>>> this:
>>> make config, GIANFAR=PHYLIB=n
>>> make zImage
>>> make config, GIANFAR=PHYLIB=m
>>> make modules
>>>
>>> And the cause of the failure will not be something that obviously  
>>> points to a build problem, such as unresolved symbols.
>> what you are suggesting will not break with my patch.
>
> Yes, it will -- note the absence of a "make zImage" after the second  
> make config.
>
>> The second case will for PHYLIB=y w/the select.
>
> And that will only make a difference if you rebuild the kernel  
> itself after enabling the module.

I see.  However, I don't like the idea I have to build in the PHYLIB  
if I don't need it at all.  It seems like the type of breakage you are  
talking about exists today all over the place.  I dont like it anymore  
than you do, but it seems to me the lesser of evils is to allow the  
user the ability to config things as they want.

- k
