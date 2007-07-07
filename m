Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92778DE0DC
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 08:08:28 +1000 (EST)
In-Reply-To: <1183827083.3066.64.camel@shinybook.infradead.org>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
	<1183827083.3066.64.camel@shinybook.infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3EADEA0-E7CC-41B9-8F5D-E5D28AB48262@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sun, 8 Jul 2007 00:06:50 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Ok, how about 'sparse16550'? Otherwise identical to ns16550, but with
> the reg-shift property. I'll send a patch shortly, and I'll reorder  
> the
> match table -- if something claims compatibility with both 8250 and
> 16550, shouldn't we drive it as the latter?
>
> Can we add properties to indicate the common high-speed modes too? The
> Natsemi baud-base thing could be autodetected by 8250.c if you'd  
> let it,
> but the SMSC trick just has to be set as a UPF_MAGIC_MULTIPLIER flag.

So just use "compatible" = "smsc,blablabla".  Your device
has extra features over a 16550, namely that extra multiplier
or whatever; so just match those new features from the device
name (i.e., "compatible" property), don't try to retrofit those
features onto an existing driver.

And don't make up names for devices (like "sparse16550") unless
you really really have to, it definitely isn't needed here.

For your new device name, you can either have the register
spacing an implicit property of the device, or you can put
it in a "reg-shift" property if you want.


Segher
