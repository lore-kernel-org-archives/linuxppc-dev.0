Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 908B4DDED1
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 22:16:12 +1000 (EST)
Date: Tue, 8 Apr 2008 16:16:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Message-ID: <20080408121630.GB26716@polina.dev.rtsoft.ru>
References: <20080311191744.GA10518@localhost.localdomain>
	<200804031545.51834.laurentp@cse-semaphore.com>
	<20080403143052.GA5955@polina.dev.rtsoft.ru>
	<200804071811.19671.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804071811.19671.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 06:11:15PM +0200, Laurent Pinchart wrote:
[...]
> I had a first go at hacking the FHCI driver to make it run on a CPM2 platform. 
> Results so far are quite good. After getting rid of qe-specific APIs as 
> explained above, and adding SOF token generation support, I've been able to 
> access a mass storage device. The driver hasn't been stress-tested yet 
> though.

Wow, awesome! That's great news, really. Looking forward for the patch. :-)

> I ran into an issue with IDLE and RESET interrupts. When the device is first 
> plugged into the USB port, the idle interrupt kicks in and the driver detects 
> the device properly. When the device is then removed, the reset interrupt is 
> generated and the driver handles device removal properly. Right after the 
> reset interrupt, idle interrupts are generated every milliseconds for around 
> 175ms. The status register always reports a non-idle condition when read in 
> the interrupt handler. The flow of idle interrupts then stops, and no idle 
> interrupt is generated when I replug the device. I've checked the interrupts 
> mask register to make sure idle interrupts were enabled.
> 
> Have you noticed a similar behaviour when you tested the driver on your 
> QE-based platform ? I suspected a debouncing issue, but I should then get 
> idle conditions once every other time when reading the status register.

Hm.. nope, I didn't see anything like that, at least not something that
is affecting the driver functionality. Did out_be16(tmr->gtevr, 0xFFFF);
help there? Or it's different problem?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
