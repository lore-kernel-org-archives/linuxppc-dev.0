Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 67C7A68949
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 22:50:39 +1100 (EST)
Message-ID: <43B3CE3C.3050601@grandegger.com>
Date: Thu, 29 Dec 2005 12:53:32 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
References: <200512271730.28563.david.jander@protonic.nl>
	<43B26CA1.4040700@grandegger.com>
	<200512281302.46210.david.jander@protonic.nl>
In-Reply-To: <200512281302.46210.david.jander@protonic.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
> Hi again,
> 
> On Wednesday 28 December 2005 11:44, Wolfgang Grandegger wrote:
> 
>>AFAIK, there is no _generic_ embedded CAN driver available which even
>>supports real-time extensions.
> 
> 
> Yes, lincan does. Well, it supports RTlinux and OCERA's RTlinux (GPL) 
> modifications, which somehow reinvent ADEOS (or is it the other way around?), 
> but since RTlinux is an option only for i386, and anyway almost dead right 
> now, you could say it doesn't support real-time extensions.

Well, ADEOS uses a different method of handling interrupts and 
exceptions to avoid the infamous RTLinux patent. Better let's say: it 
doesn't support really "free" real-time extensions.

> The problem of saying "Peak-CAN for SJA1000" and "OCAN for intel" is that you 
> can basically forget about writing portable code because they are both very 
> different.

I agree.

> Maybe you should have a look at Pavel Pisa's lincan. After trying it out you 
> might end up as confused as I am, because it doesn't look that bad at all, 
> it's almost platform independent, supports all kernels (2.2 to latest 2.6), 
> and supports a great amount of cards with intel and/or philips chips (yes, 
> both of them on one card is also an option). The driver is designed with 
> performance and throughput in mind, but I am not so sure about the API which 
> is still a little too simple (maybe that's actually good) and doesn't support 
> properly checking chip- or  bus-status yet. Also honorable is their effort of 
> staying compatible with at least one other player: can4linux.

In the meantime I had a closer look and it looks like the most advanced 
in terms of portability, indeed. My experience is, that the chip- or 
bus-status, apart from the bus-off state, is very hardware specific and 
it's difficult to provide a generic API. Still need to dig more in 
lincan to make a reasonable judgment, though.

> Greetings, and thanks for the comments,
> 
> Btw, how's ELDK-4 coming along?

Please ask Wolfgang Denk directly.

Wolfgang.
