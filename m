Return-Path: <dgibson@ozlabs.org>
Date: Tue, 23 Oct 2007 12:57:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
Message-ID: <20071023025713.GJ31839@localhost.localdomain>
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 09:59:00PM -0400, Jon Smirl wrote:
> Is this what the device tree entries should look like?
> 
> First example is ac97 audio:
> 
> ac97@2000 {           // PSC1
>       device_type = "sound";

Kill all these device_type values.

>       compatible = "mpc5200b-psc-ac97\0mpc5200-psc-ac97";

dtc now supports the more readable:
	compatible = "mpc5200b-psc-ac97", "mpc5200-psc-ac97";
Use it.

>       cell-index = <0>;

cell-index should only be present if the device is within a
system-on-chip *and* that device number is used to program some global
register somewhere.

>       reg = <2000 100>;
>       interrupts = <2 1 0>;
>       interrupt-parent = <&mpc5200_pic>;
>       codec-handle = <&codec0>
> };
> 
> pseudo-sound@0 { // use to trigger loading platform specific fabric driver
>       device_type = "pseudo-sound"
> };

This looks completely bogus.  The device tree should represent actual
hardware.

> codec0:codec@0 {

Space after the : please.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
