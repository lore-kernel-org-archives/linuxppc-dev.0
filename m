Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Dec 2007 10:04:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071210230453.GB5495@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:47:05PM +0300, Anton Vorontsov wrote:
> Hi all,
> 
> Here are patches to support NAND on UPM. That driver is generic for
> all processors with FSL UPMs. And because of that, few more patches are
> needed -- GPIO API and generic FSL UPM functions.
> 
> This is early RFC, all patches are in single thread, so everyone could
> make up overall picture of what is going on. I'll split the thread by
> topics after that RFC.
> 
> Ok, the patches and what they are for:
> 
> 1,2,3,4. GPIO API:
> ------------------
> Usually NAND chips exports RNB (Ready-Not-Busy) pin, so drivers
> could read it and get a hint when chip is ready.
> 
> Often, WP (write protect) pin is also connected to GPIO. So, GPIO API
> is mandatory for generic drivers.
> 
> OF device tree GPIOs bindings are similar to IRQs:
> 
> node {
> 	gpios = <bank pin bank pin bank pin>;
> 	gpio-parent = <&par_io_controller>;
> };
> 
> "bank pin" scheme is controller specific, so controllers that want
> to implement flat mappings or any other could do so.

It might be safest to do as is done for interrupts, and not define the
internal format at all.  The gpio within the gpio controller would be
defined by a gpio-descriptor whose format is determined by the
controller.  You would need to add a #gpio-cells property in this
case, so you can at least determine the size of the descriptors
associated with a particular gpio controller.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
