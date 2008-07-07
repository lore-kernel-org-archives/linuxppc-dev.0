Return-Path: <jonsmirl@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id 82488DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:51:30 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so503514rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 11:51:28 -0700 (PDT)
Message-ID: <9e4733910807071151m8cac0fob63f9663457da2f1@mail.gmail.com>
Date: Mon, 7 Jul 2008 14:51:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
In-Reply-To: <fa686aa40807070712x77ff7aben4cf51731bb4f5985@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486E515B.80508@matrix-vision.de>
	<20080706235046.GA6267@yookeroo.seuss>
	<4871CA6E.9080805@matrix-vision.de>
	<fa686aa40807070712x77ff7aben4cf51731bb4f5985@mail.gmail.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	Andre Schwarz <andre.schwarz@matrix-vision.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jul 7, 2008 at 1:49 AM, Andre Schwarz
>  <andre.schwarz@matrix-vision.de> wrote:
>  > David,
>  >
>  > thanks - removed "device_type" from the DMA controller.
>  >
>  > Which nodes actually require "device_type" and which don't ?
>  >
>  > Is there some general rule ?
>
>
> Segher, David;
>
>  In OF, what is the purpose of device_type?  From what I understand
>  right now, each value of device_type claims a software interface that
>  the device supports.  So for example, device_type = "serial" means
>  that firmware supports using the device as a serial port, correct?
>  So, similarly, if OF did not have a driver for the device, then the
>  presence a device_type property would be a bug, right?
>
>  Does device_type indicated any other information other than firmware
>  driver interface?
>
>  I had an epiphany about device_type this weekend (and by epiphany, I
>  mean realizing my own stupidity).  If I'm correct about the above
>  questions, then that would mean it is *always* a bug to have a
>  device_type property in .dts file because there is no firmware
>  interface.  So, it seems to me that we shouldn't just be eliminating
>  undefined device_type values, but also eliminate the ones that are
>  defined in OF because .dts users do not support the firmware driver
>  interface.
>
>  Am I correct?
>
>  The only situation where I can see it being appropriate to specify
>  device_type is to work around older bindings that are ambiguous with
>  their other properties.

I experimented with this on my own trees.
			device_type = "serial";
Is current required on the boot console or it will disappear.


-- 
Jon Smirl
jonsmirl@gmail.com
