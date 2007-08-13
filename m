Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21098DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 02:11:43 +1000 (EST)
Date: Mon, 13 Aug 2007 11:11:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yoni Levin <yonil@slydetech.com>
Subject: Re: Power Managment (mpc83xx)
Message-ID: <20070813161135.GA17638@ld0162-tx32.am.freescale.net>
References: <6954FEB9E3130645ABAFEE8D5E2C7C141FE8B6@slydesvr.Slyde.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6954FEB9E3130645ABAFEE8D5E2C7C141FE8B6@slydesvr.Slyde.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 13, 2007 at 02:44:50PM +0300, Yoni Levin wrote:
> I have mpc83xx, and I work with Linux 2.6
> 
> I am trying to use power management states. 
> 
> I succeed to get into D1 state (echo standby > /sys/power/state),

That's actually closer to D3hot than D1.  It uses sleep mode, but does
not power down the core.

> And to waked up by GPIO.
> 
> But when I try tried echo mem > /sys/power/state it waked up by reset
> (that stuck in the middle)

You need u-boot support to resume from deep sleep on 831x.  See the code
in the mpc8313erdb board files.

> Or echo disk > /sys/power/state didn't went to sleep at all.

There's no support for suspend-to-disk in my patchset.

-Scott
