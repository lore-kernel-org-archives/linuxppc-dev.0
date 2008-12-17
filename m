Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22476DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 08:04:10 +1100 (EST)
Date: Wed, 17 Dec 2008 13:01:54 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: MTD: Add cached map support to physmap_of MTD
	driver
In-Reply-To: <1229417816.7319.4.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0812171211390.28806@t2.domain.actdsltmp>
References: <1229365518-20538-1-git-send-email-tpiepho@freescale.com>
	<18758.62580.416920.482077@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0812151653050.28806@t2.domain.actdsltmp>
	<1229417816.7319.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Trent Piepho <xyzzy@speakeasy.org>,
	MTD mailing list <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Dec 2008, Benjamin Herrenschmidt wrote:
> On Mon, 2008-12-15 at 17:11 -0800, Trent Piepho wrote:
>> Shame, as it provides a huge speed up.  I suppose an alternative would be
>> to map the chip twice at different physical addresses, by just configuring
>> the chip select to be twice the size it should be, and giving them
>> different cacheability.
>
> Nice trick. That would probably work.

Thinking about it more, this is probably the way to do it.  Mapping the
same address twice appeared to worked for me, but it looks like it's a bad
thing to do.  To bad I didn't have time to finish this.

Creating two copies of the flash chip will take twice the physical address
space, but the virtual address space used is the same as mapping the chip
twice.  Since kernel virtual address space <= physical address space, there
really shouldn't be a problem with that.

Probably do something like this to the dts:

  localbus {
-	ranges = <0x1 0x0 0xe8000000 0x08000000>;
+	ranges = <0x1 0x0 0xe0000000 0x10000000>;  /* CS size x2 */
-       nor@1,0 {
+       nor@1,0x08000000 {
 		compatible = "cfi-flash";
-		reg = <0x1 0x0 0x08000000>;
+		reg = <0x1 0x08000000 0x08000000>;
+		cached-alias = <&cached_nor>;
         };
+	cached_nor: nor@1,0 {
+		compatible = "alias";
+		reg = <0x1 0 0x08000000>;
+	};
  }

Since physmap_of is an openfirmware driver, it won't be a problem to have
if look for "cached-alias" to get the range to map as cached.  The MTD
layer only supports one "map->phys" address, but I don't think this address
is used for anything on powerpc.

>> Or changing the mapping for writes and then changing it back.  It wouldn't
>> be necessary to change the whole thing, just the page being written to.
>
> Right though changing mappings can be expensive. It might be worth
> looking at using fixmap for that tho, which is the fastest way to setup
> and tear down mappings, especially since we can (though we don't today)
> implement a bypass on those to directly load the TLB.

The MTD layer appears to program flash one word at a time, so writing to
flash would mean changing maps on a per word basis.  Of course flash is
slow too so maybe the relative cost is not that much.  It takes more
modifications to MTD than the previous method.

> The problem gets worsened by the fact that cores that support
> speculative loads and prefetch will potentially bring anything mapped
> into the cache even if it's not directly accessed.

This is really the whole point of mapping it cached.  Since the cpu can
prefetch data, it's able to use more efficient back-to-back reads or page
burst mode to read a whole cache line at once.  The latter can more than
triple the read rate.
