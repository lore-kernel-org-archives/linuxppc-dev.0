Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD2FE67B53
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 23:13:58 +1000 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4856A73A-BB23-4850-A697-1CE7C385DE42@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Wed, 19 Jul 2006 08:14:06 -0500
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2006, at 1:30 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, July 18, 2006 9:53 PM
>> To: Li Yang-r58472
>> Cc: Dan Malek; linuxppc-dev@ozlabs.org;
> linux-usb-devel@lists.sourceforge.net
>> Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
>>
>> [snip]
>>
>>>> Well, I think there is a coupling that exists between whatever your
>>>> boot rom is and the kernel.  If you are trying to optimize boot
> time
>>>> I'd say one thing you would want is to avoid multiple writing the
>>>> same configuration registers.
>>>>
>>>> I dont have an issue if a fixed function board decides to do these
>>>> things in their kernel init instead of their boot rom.  I however,
>>>> don't want thousand and one config options to support all the
> various
>>>> ways one can configure the Freescale board.
>>>
>>> We won't have the thousand and one config options, making use of the
>>> device
>>> tree.  So this is not a problem.
>>
>> I'm talking about opening the door to a ton of options, not that we
>> have them now.  For example, your patch doesnt handle the USB PHYs if
>> they are on the MDS instead of the SYS board.  It doesn't handle
>> setting SCCR properly for different frequency choices.  I'm concerned
>> about where to draw the line because of all the ways a user can
>> configure the MDS board.
>
> My understanding is that in embedded world only this kind of versatile
> development boards needs to have Linux port in mainstream kernel.  A
> fixed function customer board used in embedded product will never get
> into kernel source.

This is an incorrect assumption.  Its more often that people dont  
post their ports to the Linux kernel for acceptance.  We will accept  
any port that is willing to work with the community.   for example

> The reasons for Freescale to provide this kind of boards are: first,
> verify functions on chip; second, demonstrate chip functions to
> customer; third, validate customer application on reference board;
> forth, help customer to build their own product by cutting down the
> board and software.
>
> Doing that, we do need some configure options to demonstrate main
> functions.  But there won't be too many options to confuse the user.
> Only key working modes are needed.  In your example, I think making  
> USB
> PHYs configurable for MDS is reasonable, but for SCCR it isn't as  
> it is
> well commented in code and is not likely to be modified.  Keep in mind
> that our only purpose is making customers easier and faster in
> developing their own products.

That's fine, however Freescale should figure out what the "common"  
modes of usage are before hand and document them.  Then the community  
can have a sense of the scope of what is needed and how to try to  
best accomplish that, and if anything is missing.

I disagree about the SCCR, I think its very reasonable for a customer  
to set the frequencies of their MDS board to match what their  
production system is going to be, which means the SCCR would need to  
be modified to match.

At the end of the day we will get some version of your patch into the  
kernel.  I just wanted to get some discussion on how we handle the  
reference boards that are extremely configurable.

- kumar
