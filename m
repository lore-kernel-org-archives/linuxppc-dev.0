Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 96E06DDF00
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 13:06:09 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so313196hsz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Jun 2008 20:06:07 -0700 (PDT)
Date: Wed, 4 Jun 2008 22:05:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080604220555.658ab13e@vader.jdub.homelinux.org>
In-Reply-To: <20080604225432.1a6c15e4@lappy.seanm.ca>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080604225432.1a6c15e4@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: Josh Boyer <jwboyer@gmail.com>
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

On Wed, 4 Jun 2008 22:54:32 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Wed, 4 Jun 2008 21:19:42 -0500
> "Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > From a device tree perspective, index and cell-index are both
> > incorrect.  The IIC macros don't share register blocks with anything,
> > are enumerated as unique instances per macro in the device tree, and
> > should be able to be distinguished by "regs" and/or unit address.
> 
> So say I have an i2c bus and I want to call i2c_get_adapter.
> Would I have to know the register address of the i2c bus to lookup the
> adapter?
> 
> Or would they have aliases like serial ports do?

I have no idea.  But if you look at the actual driver code, the only
thing the current "index" property is used for is to fill the idx
member of the ibm_iic_private structure.

I'm not proposing we remove that.  I'm just proposing that it can be
derived from something other than an "index" property.  Fill it in
using a static integer that gets incremented for each new device
found.  It's not like we have an indeterminate probe order, or these
IIC macros can be hot-plugged.

josh
