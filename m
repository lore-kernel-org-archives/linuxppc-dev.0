Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id 82F9ADDEEF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:12:13 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so13122686agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 07:12:12 -0700 (PDT)
Message-ID: <fa686aa40807070712x77ff7aben4cf51731bb4f5985@mail.gmail.com>
Date: Mon, 7 Jul 2008 08:12:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Andre Schwarz" <andre.schwarz@matrix-vision.de>,
	"David Gibson" <david@gibson.dropbear.id.au>,
	"Segher Boessenkool" <segher@kernel.crashing.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
In-Reply-To: <4871CA6E.9080805@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486E515B.80508@matrix-vision.de>
	<20080706235046.GA6267@yookeroo.seuss>
	<4871CA6E.9080805@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 1:49 AM, Andre Schwarz
<andre.schwarz@matrix-vision.de> wrote:
> David,
>
> thanks - removed "device_type" from the DMA controller.
>
> Which nodes actually require "device_type" and which don't ?
>
> Is there some general rule ?

Segher, David;

In OF, what is the purpose of device_type?  From what I understand
right now, each value of device_type claims a software interface that
the device supports.  So for example, device_type = "serial" means
that firmware supports using the device as a serial port, correct?
So, similarly, if OF did not have a driver for the device, then the
presence a device_type property would be a bug, right?

Does device_type indicated any other information other than firmware
driver interface?

I had an epiphany about device_type this weekend (and by epiphany, I
mean realizing my own stupidity).  If I'm correct about the above
questions, then that would mean it is *always* a bug to have a
device_type property in .dts file because there is no firmware
interface.  So, it seems to me that we shouldn't just be eliminating
undefined device_type values, but also eliminate the ones that are
defined in OF because .dts users do not support the firmware driver
interface.

Am I correct?

The only situation where I can see it being appropriate to specify
device_type is to work around older bindings that are ambiguous with
their other properties.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
