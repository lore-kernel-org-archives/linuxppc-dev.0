Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3760D67DE9
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jul 2005 02:21:27 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <42E672B1.7050709@hypersurf.com>
References: <42E672B1.7050709@hypersurf.com>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 18:18:03 +0200
Message-Id: <1122740284.18835.87.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: preliminary 750GX PLL control patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-07-26 at 10:28 -0700, Kevin Diggs wrote:
> Hi,
> 
>          I've attached a patch that adds preliminary access to the HID1 
> register in the 750GX (aka the PLL config register). The patch is 
> against 2.4.30. It has been lightly tested on a PowerMac 8600 with a 
> PowerLogix PowerForce 750GX cpu card.
> 
>          Depending on the values for the pllx_cfg field, this should 
> work on the 750FX as well ... except for the stuff in idle_6xx.S. Since 
> there are plenty of people on this list way more smarterer than me I was 
> hoping someone could answer a question about the powersave modes that 
> some of the PowerPC processors have:
> 
>          Since, as I understand it, the clock is shut off to much of the 
> chip when a powersave mode is engaged does it really buy you that much 
> to switch to a lower clock speed? Wouldn't you be better off shutting 
> off the unused PLL?
> 
>          Also, please note that I am not very experienced creating 
> patches so please use a backup of your source tree.

Well... I replicated what darwin does here. I don't remember completely
but it's possible that there is some kind of CPU errata related to nap
and clock speed... or maybe it still makes a difference :)

You want to wakeup fast from nap too, so switching off/on the unused PLL
might not be that a good idea. But heh, you are welcome to try &
measure.

Ben.
