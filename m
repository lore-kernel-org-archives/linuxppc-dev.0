Return-Path: <dgibson@bilbo.ozlabs.org>
Date: Thu, 2 Apr 2009 11:07:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
Message-ID: <20090402000747.GC7995@yookeroo.seuss>
References: <20090331124338.531903515@denx.de>
	<20090331124348.330571158@denx.de>
	<20090331230626.GB23304@yookeroo.seuss>
	<49D31A5D.8030204@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D31A5D.8030204@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2009 at 09:40:13AM +0200, Wolfgang Grandegger wrote:
> David Gibson wrote:
> > On Tue, Mar 31, 2009 at 02:43:39PM +0200, Wolfgang Grandegger wrote:
> >> The I2c node property "fsl,preserve-clocking" allows to overtake the
> >> clock settings from the boot loader and avoids the hard-coded setting.
> > 
> > Hrm.  This is dubious.  The device tree should generally describe
> > hardware, not OS/driver behaviour which is what this appears to be
> > doing.  There are exceptions, but you need to justify them.
> 
> I think the purpose of this property is clear. How would you provide
> that functionality instead? I suggested that a "clock-frequency = <0>"
> property should do the trick but Grant preferred to be more
> explicit.

I'm not saying the meaning is unclear, I'm saying it's describing
something that the device tree isn't meant to describe.  AFAICT it's
telling the driver what to do with the device, not a property of the
device itself.

Now, there are cases where it's acceptable to put this sort of
information in the device tree, because it's the least nasty available
solution (flash partition information for example).  But you need to
justify it, if that's so.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
