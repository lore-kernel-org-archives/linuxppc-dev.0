Return-Path: <david-b@pacbell.net>
Received: from smtp124.sbc.mail.sp1.yahoo.com (smtp124.sbc.mail.sp1.yahoo.com
	[69.147.64.97]) by ozlabs.org (Postfix) with SMTP id 7808DDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:48:00 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Li Yang-R58472" <LeoLi@freescale.com>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controllerdriver
Date: Wed, 24 Sep 2008 13:26:29 -0700
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<1220342239.7762.14.camel@gentoo-jocke.transmode.se>
	<0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
In-Reply-To: <0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809241326.30167.david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 September 2008, Li Yang-R58472 wrote:
> 
> > Does RNDIS work too? If not, is it possible to add or doesn't 
> > the HW support it?
> 
> RNDIS is a gadget(protocol) level thing.  I believe it can work with
> this driver although not tested myself.

It should, so long as the QE hardware doesn't try to manage
too many USB protocol details.  Examples would be caring
at all about "config change events" -- SET_CONFIGURATION
picking between one of N configurations, and SET_INTERFACE
picking between altsettings of a given interface.


> Noted:  AFAIK, RNDIS gadget in Linux doesn't interoperate with windows
> well enough to be production level.  Use at your own risk.

Something in the past few releases broke so it may not be
operating much at all, for that matter...

However, it's a fair point that the interoperation requirements
for RNDIS are so badly defined that non-Microsoft code has a
very hard time being robust.

Somewhere in the linux-usb archives is someone's fairly careful
summary of a dozen extremely rude ways the MSFT RNDIS stack
misbehaves.  It'll do things like deciding to stop forwarding
packets to certain applications for a while ... then continuing
after a few minutes as if nothing was wrong.  Blue screens are
a possibility.  Best to wait a few minutes between plugging
and unplugging, while the races between the USB and NET stacks
sort themselves out.

- Dave
