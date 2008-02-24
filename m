Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44609DDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 11:59:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1O0xFvU024487
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 19:59:15 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1O0xeRr103710
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:59:40 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1O0xdtb022354
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:59:40 -0700
Date: Sat, 23 Feb 2008 18:59:04 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: sfr@canb.auug.org.au, davem@davemloft.net, benh@kernel.crashing.org
Subject: Re: [PATCH 1/2][OF] Add of_device_is_disabled function
Message-ID: <20080223185904.757c2884@zod.rchland.ibm.com>
In-Reply-To: <20080223155823.2c85d829@zod.rchland.ibm.com>
References: <20080223155823.2c85d829@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 23 Feb 2008 15:58:23 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> IEEE 1275 defined a standard "status" property to indicate the operational
> status of a device.  The property has four possible values: okay, disabled,
> fail, fail-xxx.  The absence of this property means the operational status
> of the device is unknown or okay.
> 
> This adds a function called of_device_is_disabled that checks to see if a
> node has the status property set to "disabled".  This can be quite useful
> for devices that may be present but disabled due to pin sharing, etc.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Talking with Ben H a bit, he suggested to reverse this API.  Basically,
create an of_device_is_available that returns 1 if the status property
is completely missing, or if it's set to "okay" or "ok".  The latter is
to cope with some broken firmwares.

I can do either really.  Eventually you could embed the is_available
check in the of_platform code so that devices don't even get presented
to drivers if they aren't available.

Dave, I'm not sure how applicable this all is to sparc.  But for some
of the "newer" embedded ports that are coming into powerpc I can see it
being very useful.

Thoughts?

josh
