Return-Path: <jacmet@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 42720B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 06:55:55 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 1A9D7DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 06:55:52 +1000 (EST)
Received: by fxm22 with SMTP id 22so361894fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 13:55:50 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mpc83xx/usb.c: fix usb mux setup for mpc834x
References: <1244547812-3811-1-git-send-email-jacmet@sunsite.dk>
	<E3FB2692-D60E-4C06-BEDD-45441E67458E@kernel.crashing.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 16 Jul 2009 22:55:47 +0200
In-Reply-To: <E3FB2692-D60E-4C06-BEDD-45441E67458E@kernel.crashing.org> (Kumar
	Gala's message of "Wed\, 10 Jun 2009 22\:32\:39 -0500")
Message-ID: <878wiojqjw.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

Hi,

 Kumar> On Jun 9, 2009, at 6:43 AM, Peter Korsgaard wrote:

 >> usb0 and usb1 mux settings in the sicrl register were swapped (twice!)
 >> in mpc834x_usb_cfg(), leading to various strange issues with fsl-ehci
 >> and full speed devices.
 >> 
 >> The USB port config on mpc834x is done using 2 muxes: Port 0 is
 >> always used for MPH port 0, and port 1 can either be used for MPH
 >> port 1 or DR (unless DR uses TMDI phy or OTG, then it uses both
 >> ports) - See 8349 RM figure 1-4..
 >> 
 >> mpc8349_usb_cfg() had this inverted for the DR, and it also had
 >> the bit positions of the usb0 / usb1 mux settings swapped. It
 >> would basically work if you specified port1 instead of port0 for
 >> the MPH controller (and happened to use ULPI phys), which is what
 >> all the 834x dts have done, even though that configuration is
 >> physically invalid.
 >> 
 >> Instead fix mpc8349_usb_cfg() and adjust the dts files to match
 >> reality.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Kumar> applied.. Please remind me to send this linux-stable for .30 and .29

*Remind*

-- 
Bye, Peter Korsgaard
