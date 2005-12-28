Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5B840688DB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 21:42:02 +1100 (EST)
Message-ID: <43B26CA1.4040700@grandegger.com>
Date: Wed, 28 Dec 2005 11:44:49 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
References: <200512271730.28563.david.jander@protonic.nl>
In-Reply-To: <200512271730.28563.david.jander@protonic.nl>
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
> Hi,
> 
> We have developed CAN hardware based on the Philips SJA1000 controller hooked 
> to a MPC8xx based processor board. Now we want to write driver support for 
> it. My first try was lincan-0.3.1, which seemed quite well written at first 
> glance. Porting was easy too, and the driver works fine on our board with the 
> latest kernel (2.6.14).
> But.... this driver lacks a proper way of checking the status of the CAN 
> controller from userspace :-( Not that nice after all!
> 
> Then I see on the DENX website, mention of Rubini's OCAN (mostly useless to 
> us), and Peak's PCAN drivers (there is a port for MPC5200 on DENX's site). No 
> word about lincan, though.

We have looked for "free" CAN software/drivers for Linux already some 
time ago, especially for embedded PowerPC processors. There are various 
implementations out there, but only a few of them are "alive". A natural 
choice for the SJA1000 seems to be the CAN driver from Peak Systems (see
http://www.peak-system.com/linux/index.htm). It already supports 2.6 and 
seems to be well maintained. Porting it to your MPC 8xx bases hardware 
should not be to much effort. The OCAN driver is for the i82527. It's a 
good choice if you use that CAN controller but porting to the SJA1000 
might not be straight-forward as the API uses details of the chips hardware.

> 
> The reason I suppose is, someone already figured out that lincan is not a good 
> choice for whatever reason (status reportability ??), right?

I never tried lincan.

> Before beginning to re-invent wheels and re-discover known problems in certain 
> CAN driver architectures, could someone please point me to the right place to 
> start looking for answers (if that place exists) or just give the answer, 
> opinion or experience with one of PeakCAN, lincan, can4linux, etc...?
> 
> I am again puzzeled about which way to go.

AFAIK, there is no _generic_ embedded CAN driver available which even 
supports real-time extensions.

Wolfgang.

> Thanks for any advice,
> 
