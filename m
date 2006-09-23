Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A263E67BA4
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 11:34:26 +1000 (EST)
In-Reply-To: <20060922185923.GB25738@mag.az.mvista.com>
References: <20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
	<20060922012408.GA13820@mag.az.mvista.com>
	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Sat, 23 Sep 2006 02:54:12 +0200
To: Mark A. Greer <mgreer@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>, Matt Porter <mporter@embeddedalley.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Oh, okay.  I didn't realize there was an actual "64-bit" property.
> I thought you just meant "/cpus/#address-cells = <2>".
> I should've googled first.

No, cpus/"#address-cells" is required to be 1, as that's the number
of address cells required to identify a CPU itself.

> So, yes, that probably does give us the info we need.

> Here is where I think we are for getting the effective base addr
> of the regs for the console uart in the bootwrapper:
>
> 1) We add the "fw,address" property to the uart's dt node.  That
> property provides the effective base address of the uart's registers
> left over by the firmware.  The format is similar to that of the
> "reg" property in that it contains an "address size" tuple.

I completely lost you here, sorry.  Maybe it's me.  Care to
repeat this in a (perhaps more verbose) way that I might
understand?

> 2) The effective address width (32 or 64 bits) (i.e., the # cells in
> the "address" portion of the tuple) is indicated by the presence of  
> the
> "/cpus/64-bit" property.  If it exists, the effective addr space is
> 64-bits wide (2 cells); if not, its 32-bits wide (1 cell).

Yes.  Except a "cell" is not what you think it is.  A "cell" is the
size of numbers OF deals with internally; just deal with it.  Of
course, there's things like "#address-cells", which really mean
"#-32bit-things-per-address".

> 3) The number of cells in the "size" portion of the tuple is indicated
> by the nearest #size-cells as you go up the tree.  Just like the "reg"
> property.

Yes, sounds fine.


Segher
