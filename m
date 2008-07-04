Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id AFD91DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 00:37:15 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1296821wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 07:37:14 -0700 (PDT)
Date: Fri, 4 Jul 2008 08:36:19 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: GPIO @ MPC5200
Message-ID: <20080704143619.GA15751@secretlab.ca>
References: <486DF3FA.3010806@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486DF3FA.3010806@matrix-vision.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 11:57:14AM +0200, Andre Schwarz wrote:
> Sascha, Grant,
> 
> I'm running on 2.6.26-rc6 with an MPC5200B based system.
> 
> Looks like some (for me) crucial GPIO are touched during boot.
> Is this possible ?
> 
> Of course I have compiled in GPIO-Lib and specified the GPIOs in the dts.
> But no access yet - I'd like to preserve the setup from u-boot...

The GPIO driver only writes to the GPIO registers when a driver actually
requests to use them.  At probe time, the gpio drivers read the current
values from the GPIO registers, so current config should be preserved.

However, the gpiochip_dir hook explicitly sets the output value when it
is called.  It may be that when you are claiming the GPIO line it is
getting set with a default (and wrong) value.

Another possibility; have you verified that it is the GPIO regs getting
clobbered?  Or is port_config getting changed on you?  Which GPIO pins?

g.
