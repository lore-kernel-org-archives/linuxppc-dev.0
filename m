Return-Path: <aris@ruivo.org>
Received: from lobo.ruivo.org (lobo.ruivo.org [66.92.68.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lobo.ruivo.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41125DDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 11:31:36 +1000 (EST)
Date: Mon, 16 Jul 2007 21:30:22 -0400
From: Aristeu Rozanski <aris@ruivo.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] adb: create class devices for each adb device
Message-ID: <20070717013022.GB20841@cathedrallabs.org>
References: <20070716205319.GC30232@cathedrallabs.org>
	<1184628153.25235.111.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184628153.25235.111.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Benjamin,
> I don't think class device is the right approach. Classes are supposed
> to be a functional binding, ie, in this case, input devices. ADB is a
> bus, and as such, you should create an adb bus type and and adb_device
> that is an extension of struct device, not struct class device.
ok, I'll work on that.

> There's also the question of what to do on ADB resets (such as when
> doing a sleep/wakeup cycle). Should we wipe out all devices and
> re-created them, thus loosing any settings ? Or should we have some way
> to attempt at re-matching existing ones ?
or maybe generate disconnect/connect events so udev rules can reconfigure
each keyboard?

-- 
Aristeu
