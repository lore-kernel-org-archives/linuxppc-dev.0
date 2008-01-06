Return-Path: <dgibson@ozlabs.org>
Date: Sun, 6 Jan 2008 11:12:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c-ibm_iic driver
Message-ID: <20080106001238.GI4326@localhost.localdomain>
References: <477EF225.4070505@pikatech.com> <200801051354.11202.arnd@arndb.de>
	<477FCE21.9080808@pikatech.com> <200801052018.22954.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200801052018.22954.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 05, 2008 at 08:18:22PM +0100, Arnd Bergmann wrote:
> On Saturday 05 January 2008, Sean MacLennan wrote:
> > 
> > Ok. The 44x based .dts files do not list 405-iic, so would I think I 
> > will add two compatibility matches, one for 405 and one for 440EP. That 
> > way I do not break all the current .dts files. Everybody ok with that?
> > 
> 
> Sounds good. There are obviously no other drivers that know only
> about 405 but not about 440, so there is no backwards compatibility
> problem. If we ever get a 450/460/470/... that we want to support
> with this driver, it can simply claim to be compatible with 440 or 405
> if not both.

Actually, I think checking for "ibm,iic" is ok.  I'm sure there are
other IBM produced i2c chips, but "IIC" is also the name of the ASIC
block that implements this controller.  "ibm,iic" in the compatible is
supposed to refer to this family of i2c bridges.  Not a great choice
on my part, perhaps, but not so awful as to go changing the existing
device trees I think.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
