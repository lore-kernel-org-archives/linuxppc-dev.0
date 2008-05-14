Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id F3294DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 17:07:32 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1679331nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 00:07:30 -0700 (PDT)
To: Jens Gehrlein <sew_s@tqs.de>
Subject: Re: smc911x: how to call the driver?
References: <4829BC19.5000909@tqs.de>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 14 May 2008 09:07:24 +0200
In-Reply-To: <4829BC19.5000909@tqs.de> (Jens Gehrlein's message of "Tue\,
	13 May 2008 18\:04\:41 +0200")
Message-ID: <87hcd1749f.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-embedded Mailinglist <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Jens" == Jens Gehrlein <sew_s@tqs.de> writes:

 Jens> Hi,
 Jens> on our board a SMSC LAN9215i is connected to an i.MX31 ARM
 Jens> processor. My hope is to get the smc911x driver run on this chip. The
 Jens> LAN921x data sheets say that existing 911x drivers should work.

Why are you asking this in a powerpc list?

 Jens> My next problem is:
 Jens> Where and when get the functions smc911x_drv_probe() and
 Jens> smc911x_init() called? Any hints?

You need to register a struct platform_device in your platform code,
E.G. something like:

static struct resource smc911x_resources[] = {
        [0] = {
                .start  = 0x8e000000,
                .end    = 0x8e0000ff,
                .flags  = IORESOURCE_MEM,
        },
        [1] = {
                .start  = 4,
                .end    = 4,
                .flags  = IORESOURCE_IRQ,
        },
};

static struct platform_device thinlite_eth = {
        .name                   = "smc911x",
        .id                     = 0,
        .num_resources          = ARRAY_SIZE(smc911x_resources),
        .resource               = smc911x_resources,
};

And then do a platform_add_devices with it.

-- 
Bye, Peter Korsgaard
