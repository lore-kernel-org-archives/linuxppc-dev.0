Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 31F66DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 13:16:43 +1000 (EST)
Date: Wed, 4 Jun 2008 23:16:41 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080604231641.786bb2dd@lappy.seanm.ca>
In-Reply-To: <20080604220555.658ab13e@vader.jdub.homelinux.org>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080604225432.1a6c15e4@lappy.seanm.ca>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, Stefan,
	Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jun 2008 22:05:55 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> I'm not proposing we remove that.  I'm just proposing that it can be
> derived from something other than an "index" property.  Fill it in
> using a static integer that gets incremented for each new device
> found.  It's not like we have an indeterminate probe order, or these
> IIC macros can be hot-plugged.

That's how it used to work by default. It was decided to drop that and
enforce an index. The following is a quote from Jean Delvare from a
post from 8/2/16 4:31:

> I don't like this static index thing much. Can't you just make the
> "index" OF property mandatory? Mixing ways to number things can become
> very confusing. In particular as you are using dev->idx later to call
> i2c_add_numbered_adapter(), the caller is really supposed to know what
> they are doing with the bus numbers.

Maybe it is time to remove the index, or maybe we should go back to
using both a static and the index. But at the time we decided to enforce
an index.

Cheers,
   Sean
