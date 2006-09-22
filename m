Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 3DB8F67B71
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 04:58:36 +1000 (EST)
Date: Fri, 22 Sep 2006 11:59:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060922185923.GB25738@mag.az.mvista.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
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

On Fri, Sep 22, 2006 at 10:43:42AM +0200, Segher Boessenkool wrote:
> >>How about you check whether the "64-bit" property exists in the CPU
> >>nodes?
> >
> >That seemed like the right thing until I realized, its still  
> >specifying
> >the physical size, not the virtual size.
> 
> No, it says that the CPU supports the full PowerPC arch, not just the
> 32-bit subset.  Every 64-bit PowerPC has a 64-bit effective address,
> every 32-bit PowerPC has a 32-bit effective address.  There's no way
> around that unless you change most of the instruction set ;-)

Oh, okay.  I didn't realize there was an actual "64-bit" property.
I thought you just meant "/cpus/#address-cells = <2>".
I should've googled first.

So, yes, that probably does give us the info we need.
--

Here is where I think we are for getting the effective base addr
of the regs for the console uart in the bootwrapper:

1) We add the "fw,address" property to the uart's dt node.  That
property provides the effective base address of the uart's registers
left over by the firmware.  The format is similar to that of the
"reg" property in that it contains an "address size" tuple.

2) The effective address width (32 or 64 bits) (i.e., the # cells in
the "address" portion of the tuple) is indicated by the presence of the
"/cpus/64-bit" property.  If it exists, the effective addr space is
64-bits wide (2 cells); if not, its 32-bits wide (1 cell).

3) The number of cells in the "size" portion of the tuple is indicated
by the nearest #size-cells as you go up the tree.  Just like the "reg"
property.

Comments?

Mark
