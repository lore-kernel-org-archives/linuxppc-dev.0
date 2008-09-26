Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11F3CDDDE0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Sep 2008 02:34:00 +1000 (EST)
Message-ID: <48DD0E7D.6030107@freescale.com>
Date: Fri, 26 Sep 2008 11:31:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Beamonte <dbeamonte@telnet-ri.es>
Subject: Re: Interrupts get disabled on USB access on MPC8272
References: <48DD0169.7090709@telnet-ri.es>
In-Reply-To: <48DD0169.7090709@telnet-ri.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

David Beamonte wrote:
> I have debugged the kernel and what I can see is that, once the 
> processor tries to send a buffer of the USB controller, interrupts get 
> disabled. And so, there is no ethernet, serial port, or whatever way of 
> communication to the processor. With my debugger I can see that the 
> kernel keeps running and executing cpu_idle() and so on. Furtheremore, 
> jiffies increase, but no other interrupts occur.

It's probably waiting for an interrupt that never came.

> It seems to happen when buffers try to access external memory. Can it be 
> related to bus arbitration?

Probably not; usually that sort of problem results in a hard lock-up.

-Scott
