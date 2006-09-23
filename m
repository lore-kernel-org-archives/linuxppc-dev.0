Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 1818367B6C
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 18:17:49 +1000 (EST)
Date: Sat, 23 Sep 2006 01:18:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060923081836.GA25298@mag.az.mvista.com>
References: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
	<20060922012408.GA13820@mag.az.mvista.com>
	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
	<74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>
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

On Sat, Sep 23, 2006 at 02:54:12AM +0200, Segher Boessenkool wrote:
> >Here is where I think we are for getting the effective base addr
> >of the regs for the console uart in the bootwrapper:
> >
> >1) We add the "fw,address" property to the uart's dt node.  That
> >property provides the effective base address of the uart's registers
> >left over by the firmware.  The format is similar to that of the
> >"reg" property in that it contains an "address size" tuple.
> 
> I completely lost you here, sorry.  Maybe it's me.  Care to
> repeat this in a (perhaps more verbose) way that I might
> understand?

Well, I'm still new to the dt stuff and probably use the wrong
terminology all the time.  I tried to use the same type of description
that is used in ./Documentation/powerpc/booting-without-of.txt.

For example:

	'"reg" properties are always a tuple of the type "address size"
	where the number of cells of address and size is specified by
	the bus #address-cells and #size-cells.'

All I'm try to say is that "fw,address" is just like the "reg" property
except that it holds the effective addr not the physical addr and the
size of the address is determined by the existence of "/cpus/64-bit"
not #address-cells.  That's all.

> >2) The effective address width (32 or 64 bits) (i.e., the # cells in
> >the "address" portion of the tuple) is indicated by the presence of  
> >the
> >"/cpus/64-bit" property.  If it exists, the effective addr space is
> >64-bits wide (2 cells); if not, its 32-bits wide (1 cell).
> 
> Yes.  Except a "cell" is not what you think it is.  A "cell" is the
> size of numbers OF deals with internally; just deal with it.  Of
> course, there's things like "#address-cells", which really mean
> "#-32bit-things-per-address".

Okay, well, when I talked about cells I meant "#-32bit-things-per-address".
Obviously it was silly of me to think that "#address-cells" meant the # of
address cells...

Mark
