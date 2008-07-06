Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 9BA52DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 03:56:57 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so861762ywh.39
	for <linuxppc-dev@ozlabs.org>; Sun, 06 Jul 2008 10:56:48 -0700 (PDT)
Message-ID: <9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
Date: Sun, 6 Jul 2008 13:56:48 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
In-Reply-To: <20080701235335.16923.43253.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
>  This is an I2S bus driver for the MPC5200 PSC device.  It is probably
>  will not be merged as-is because it uses v1 of the ASoC API, but I want
>  to get it out there for comments.
>  ---

The driver is assuming a capture stream exists. My codec is output only.

I'm using external clocking, but the driver should support using the
mpc5200 for clocking. That's a little complicated since you have to
compute the divisors. For example the Phytec pcm030 board has a
33.3333Mhz xtal and runs at 400Mhz.

In order to reduce options, can the psc-i2s driver always try to use
mpc5200 clocking, then let the codec or fabric driver override it?

-- 
Jon Smirl
jonsmirl@gmail.com
