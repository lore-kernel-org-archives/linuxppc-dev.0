Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9B04167A2C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 12:37:38 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1106011958.4533.25.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 19 Jan 2005 02:37:31 +0100
In-Reply-To: <1106011958.4533.25.camel@gaston> (Benjamin Herrenschmidt's
	message of "Tue, 18 Jan 2005 12:32:37 +1100")
Message-ID: <je7jmaurl0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Hi !
>
> This patch updates the PowerMac sleep support. The ability to sleep is now broken
> into 2 different flags, one, "may sleep" is set for all motherboards that we know
> how to put to sleep and wakeup. It gets turned into "can sleep" upon a call from
> the video driver indicating the ability to wakeup the video card. This doesn't
> deal with head-less machines, but this can be improved later. It also adds better
> cache flush code, which improves stability with cpufreq as well as sleep.
>
> This patch actually breaks sleep support until the video drivers for the affected
> machines have been updated. This will come as separate patches.

With all your patches applied I'm getting an oops during wakeup inside
pci_bus_read_config_word on my iBook/G3.  Call trace: pci_set_master,
pci_device_resume, resume_device, dpm_resume, device_resume,
pmac_wakeup_devices, pmu_ioctl, sys_ioctl.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
