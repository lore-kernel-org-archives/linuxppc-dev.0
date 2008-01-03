Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 10:35:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv3] powerpc: DBox2 Board Support
Message-ID: <20080103233509.GB12883@localhost.localdomain>
References: <477522DB.4000100@scram.de>
	<20080102112030.GB23168@localhost.localdomain>
	<477CCB0F.8020504@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477CCB0F.8020504@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 12:46:23PM +0100, Jochen Friedrich wrote:
> Hi David,
> 
> >> +/ {
> >> +	model = "unknown,dbox2"; // boot wrapper fills in correct manufacturer
> > 
> > Probably better just to leave model out of the dts and let the
> > bootwrapper add it.
> 
> Unfortunately, dtc requires a model:
> 
> $ dtc arch/powerpc/boot/dts/dbox2.dts
> DTC: dts->dts  on file "arch/powerpc/boot/dts/dbox2.dts"
> ERROR: Missing "model" property in /

Ah.  That should be gone in newer dtc versions.  I'm pretty sure I got
rid of all checks that enforced the presence of particular properties,
precisely because they give frequent spurious errors when things are
supposed to be filled in by the bootloader.

[snip]
> >> +				label = "Flash without bootloader";
> >> +				reg = <20000 7e0000>;
> >> +			};
> >> +			ovpartition@0 {
> >> +				label = "Complete Flash";
> >> +				reg = <0 800000>;
> >> +				read-only;
> >> +			};
> >> +		};
> >> +	};
> 
> MTD handles this correctly. dbox2 uses "Flash without bootloader"
> for flashing image updates and "Complete Flash" for creating a
> backup of everything.  OpenWRT also uses overlapping partitions BTW
> (and also for flashing updates).

Heh.  Wow.  Safely?  i.e. if you access one partition then later an
overlapping partition, is mtd guaranteed to get the necessary
synchronization right?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
