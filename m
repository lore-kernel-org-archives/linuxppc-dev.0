Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Nov 2008 11:53:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
Message-ID: <20081106005339.GF28465@yookeroo.seuss>
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de>
	<20081105233617.GC28465@yookeroo.seuss>
	<49123BB7.90503@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49123BB7.90503@consentry.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2008 at 04:35:03PM -0800, Mike Ditto wrote:
> David Gibson wrote:
> > What does worry me, however, is the description says it's about
> > whether the driver "should" enable the filter.  Generally the device
> > tree doesn't attempt to say what users "should" do with the hardware,
> > just what the characteristics of the hardware are.
> >
> > What's the underlying difference here that affects the driver's choice
> > to enable the filter or not?
> 
> I think it's a hardware/environment design parameter - e.g. if the I2C
> bus has hot-pluggable devices, long PCB traces, or a hierarchy of
> multiplexed bus segments, these can result in a noisy SCL signal that
> needs to be filtered.  It's also a recommended mitigation for errata
> in certain CPU revs.

Ah, ok.  Well the CPU revision thing could be selected based on the
CPU revision, but the other conditions are a property of the board
wiring.  Obviously it's hard to precisely characterize what it says
about the hardware, which is usually best avoided for devtree
properties, but I can see why this is more-or-less unavoidable in this
case.

Ok.  This property name and meaning looks ok to me.  I would suggest a
note in the binding roughly explaining what leads to the property
being set (basically what you just told me in the paragraph above).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
