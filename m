Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f175.google.com (mail-iw0-f175.google.com
	[209.85.223.175]) by ozlabs.org (Postfix) with ESMTP id 27EEFB7BEE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 02:23:25 +1000 (EST)
Received: by iwn5 with SMTP id 5so3929295iwn.9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 09:23:24 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <j2zfa686aa41004280657g49db18d9g563e643e16ca64e9@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
	<u2xed82fe3e1004280635vaeb792d2xf86996cac299ba2b@mail.gmail.com>
	<j2zfa686aa41004280657g49db18d9g563e643e16ca64e9@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 28 Apr 2010 11:20:40 -0500
Message-ID: <k2ped82fe3e1004280920xb1d8ef7ew34f86fd0ae67cf61@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 8:57 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

> I'm just saying move the registration of the machine device out of
> arch/powerpc platform code and into the ssi driver.

But the SSI driver is an OF driver, and it gets probed for every SSI
node in the device tree.  On the 8610, that means being probed twice.
But I should only call platform_device_register_simple() once.

Are you saying that I should call platform_device_register_simple()
from the SSI's driver initialization function, fsl_ssi_init()?

> Then you've got a
> reasonable place to pass shared data (either the ssi device node or
> device instance or name. =A0Whatever you need) to the machine driver.

The problem is that the fabric driver needs much more information from
the device tree than the SSI driver needs.  So if the SSI driver is
going to pass that information to the fabric driver via the platform
data, it's going to have to know what information the fabric driver
needs.  Then the SSI driver is not board-independent.

--=20
Timur Tabi
Linux kernel developer at Freescale
