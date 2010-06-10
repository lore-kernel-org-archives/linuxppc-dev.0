Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 98FAD1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 08:03:12 +1000 (EST)
Received: by gyd10 with SMTP id 10so344652gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 15:03:10 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276097965-6592-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1276097965-6592-1-git-send-email-emillbrandt@dekaresearch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 16:02:50 -0600
Message-ID: <AANLkTimF4LId2swnWtxQ9WXs7KM30_eskpXSFzxsoRlw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] sound/soc: mpc5200_psc_ac97: Use gpio pins for
	cold reset.
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 9, 2010 at 9:39 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> The implementation of the ac97 "cold" reset is flawed. =A0If the sync and
> output lines are high when reset is asserted the attached ac97 device
> may go into test mode. =A0Avoid this by reconfiguring the psc to gpio mod=
e
> and generating the reset manually.

Hi Eric,

Thanks for the patch.  Given a) that this is essentially a silicon
bug, b) that AC97 only works on PSCs 1 & 2 which cannot be relocated
to different pins, c) that I really want to avoid giving drivers
access to port_config even through an API, and d) All mpc5200 AC97
systems will probably have the same issue, I think this is something
that shouldn't require a change to the device tree, and can probably
be contained within arch/powerpc/platforms/52xx.

Overall, I have no problem with the function of the change, but I'd
like to see these two changes:
- Add a helper function ot arch/powerpc/platforms/52xx to perform an
AC97 reset using GPIOs (select GPIO in port_config, toggle reset,
select PSC in port_config).  Something like
mpc5200_psc_ac97_gpio_reset(int psc_number).  Just move the GPIO bits.
 The PSC mode setting can be left in the driver.
- Go ahead and hardcode the GPIO numbers into the platform code.  It
is definitely a hardware bug workaround, and it isn't something that
would normally be described in the device tree (though you probably
need to make the gpio_lock spinlock non-static to maintain mutual
exclusion).

g.
