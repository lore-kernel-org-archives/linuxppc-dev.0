Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id B5790DDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 03:13:00 +1000 (EST)
Date: Fri, 27 Jul 2007 20:12:46 +0300
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: pq2fads support...
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
References: <op.tv4h01apnhx3hy@phoenix>
	<20070727163529.GA26893@ld0162-tx32.am.freescale.net>
Message-ID: <op.tv4vfiaunhx3hy@phoenix>
In-Reply-To: <20070727163529.GA26893@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for your reply, Scott,

one question though: I am NOT using the bootwrapper, I'm instead feeding  
dtb and uImage directly to u-boot. This probably means that I should fill  
in lots of stuff manually into dts, right? But, (and please forgive my  
ignorance) who does actually fill in stuff (like e.g. clock-frequency or  
bus-frequency), except, of course, from the trivial modifications u-boot  
does to dtb? The wrapper script seems to do nothing more that simply  
running dtc on dts.

Thanks again

Alex

On Fri, 27 Jul 2007 19:35:29 +0300, Scott Wood <scottwood@freescale.com>  
wrote:

> On Fri, Jul 27, 2007 at 03:24:08PM +0300, Alexandros Kostopoulos wrote:
>> In your patch for the pq2fads support, the device tree seems to be  
>> missing
>> a memory node, for which dtc complains loudly. Is this board tested to
>> boot with these patches (because I'm now using this as a template for my
>> board - with your patchset applied to Paul's git)
>
> Sorry about that -- dtc complains about a lot of silly things, falsely
> assuming that the result is intended to be a complete tree ready for
> passing to Linux (which is rarely true).  I'd been running with a patch
> to remove some of those checks, but it got rejected, and I forgot to
> stick the templates back into the dts.
>
> The next patchset will have a dts that works with current dtc; in the
> meantime, you can add the -f flag to dtc in arch/powerpc/boot/wrapper, or
> add the missing nodes based on the mpc8272ads device tree (the actual
> information will be filled in by the bootwrapper).
>
>> PS. What's about this new cpm-serial driver? is this supposed to be a
>> replacement for cpm_uart?
>
> No, it's a minimal driver for the bootwrapper.
>
> -Scott
