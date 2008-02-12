Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Feb 2008 09:49:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nick <ndroogh@rogers.com>
Subject: Re: DTS question - MPC5200b
Message-ID: <20080212224906.GA21230@localhost.localdomain>
References: <47B1D943.6020708@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B1D943.6020708@rogers.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 12:37:07PM -0500, Nick wrote:
> Hi,
> 
> I need some help.  I am trying to access timer 7 on the MPC5200B 
> processor.  I have the DTS file setup like this

Others have addressed the most salient points, but some general
corrections for your device tree..

>         gpt@670 {    // General Purpose Timer
>           device_type = "gpt";

device_type shouldn't be here.

>             compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>             cell-index = <7>;

You probably don't want cell-index.  cell-index should *only* be used
when there is some global register somewhere that's indexed by the
cell number.

>             reg = <670 10>;
>             interrupts = <1 10 0>;
>             interrupt-parent = <&mpc5200_pic>;
>         };
> 
> I have timers 0 to 6 defined the same way except the cell-index reflects 
> the timer number.

Presumably 'reg' is different for each, as well.

> In my platform file where I am doing my board setup, I tried the  following.
> 
> timer7 = mpc52xx_find_and_map ("mpc5200b-gpt");
> 
> How do I specify the timer based on the cell-index?

You don't.  As Grant explains, use reg instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
