Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 862C0DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 05:18:41 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so3043059qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Nov 2008 10:18:40 -0800 (PST)
Message-ID: <491091FC.4010707@genesi-usa.com>
Date: Tue, 04 Nov 2008 12:18:36 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<490F73B5.6010004@genesi-usa.com>
	<20081103221546.GA16244@pengutronix.de>
In-Reply-To: <20081103221546.GA16244@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Wolfram Sang wrote:
> On Mon, Nov 03, 2008 at 03:57:09PM -0600, Matt Sealey wrote:
> 
>>> Optionally you can further
>>> reduce impact by checking if CONFIG_PPC_MPC5200_BUGFIX is defined.
>> I would much prefer this.
> 
> I submitted a patch to enable pipelining on a MPC5200B recently. It was
> disabled because of a bug in the MPC5200. The first version of this
> patch used MPC5200_BUGFIX and it was mentioned, that some people might
> want to run the same kernel on both kind of processors. So, the patch
> that went mainline checks for the PVR. Maybe we should stick to this
> here, too?

I would wrap a real chipset errata inside CONFIG_PPC_MPC5200_BUGFIX so
that you have the option to remove all code that fixes these errata, but
also check the PVR and only do the bugfix if you're on that processor,
so.. both :D

The pipelining thing seems to be fixed in the MPC5200B but it actually
makes the bus lock up under certain circumstances with the ATA DMA
task and certain priority selections. I am not sure what we're going
to do about that pipelining support (Tim Yamin's patch removed it! Maybe
we should have a little addition to the BestComm driver which can set
these things from the driver side using a little global API, so that
if an ATA driver loads and wants this configuration, it can get to it)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
