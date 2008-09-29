Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66F9BDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Sep 2008 16:03:39 +1000 (EST)
Message-ID: <48E0E981.60703@freescale.com>
Date: Mon, 29 Sep 2008 09:43:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: embedded <embedded@akb.net>
Subject: Re: FCC1 failing on large packet PINGS, while FCC2 is successful
References: <bfa0697f0809261600p7e1af4a6va360d0782cec8257@mail.gmail.com>
In-Reply-To: <bfa0697f0809261600p7e1af4a6va360d0782cec8257@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

embedded wrote:
> We've found a way to get ping to fail all of the time by increasing
> the size of the ping messages.  When we use the max in Windows of
> 65500, every ping to the first FCC1 Ethernet is dropped.  However,
> when we ping with a size of 65500 to the second FCC2 Ethernet
> everything is fine and all echos are successful.
> 
> In windows:
> ping -l 64000 172.24.100.11  -t
> 
> It definitely seems to be a problem with the mpc, but I'm not sure
> where to look.  Board? KErnel? boot loader?  The two Ethernet devices
> should be configured identically, and looking through the kernel code,
> it seems that there aren't any preferred treatment differences.  Could
> the problem be in the bit-banging mdio control, or should I look
> within fs_enet?  We've got this reproducing on all of our boards and
> it could also reside in the board setup...
> 
> Does anyone with experience on the ep8248 and/or mpc8272 family,
> fs_enet-* code have any ideas where I should look next?

It looks very similar to what I was seeing on ep8248 -- the first 
ethernet port would fail when attempting to receive back-to-back 
packets.  I didn't look into it too closely since I thought it was 
probably a board issue (I had only one, and the firmware never generated 
any traffic that resulted in back-to-back receives).

I'd be very interested if you ever figure out what's wrong.

-Scott
