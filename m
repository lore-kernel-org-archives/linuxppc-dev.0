Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 89BC0DED2C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:53:35 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so139758anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 08:53:34 -0700 (PDT)
Message-ID: <fa686aa40806050853g43482583oc5dabc9d80ed0779@mail.gmail.com>
Date: Thu, 5 Jun 2008 09:53:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <48480BA0.2060500@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480BA0.2060500@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 9:52 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Grant,
>
>> if you need explicit indexing then use an alias.  My opinion however
>> is that explicit indexing is unnecessary and is just an artifact of
>> current i2c subsystem internals.  There is already enough information
>> in the device tree to match i2c devices with i2c busses without
>> resorting to indexes.
>
> True. However, there are currently drivers which need platform data for
> its initialisation (like drivers/gpio/pca953x.c). Unless these drivers
> are rewritten, they can't be loaded just by parsing the device tree, so
> they must be loaded from platform init code and here the adapter index
> is needed to attach the driver.

... which means that platform code is responsible to figure it out.
Don't encode it into the device tree.

Besides, this is just a binding.  I see absolutely no problem adding
probe code to the bindings to extract data from the device tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
