Return-Path: <glikely@secretlab.ca>
Date: Thu, 31 Jul 2008 14:48:38 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Message-ID: <20080731204838.GA29834@secretlab.ca>
References: <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com> <48921888.3020900@grandegger.com>
	<48921954.4020103@freescale.com> <48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
	<fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>
	<48922273.6070801@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48922273.6070801@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 03:37:07PM -0500, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > How is the divider controlled?  Is it a fixed property of the SoC? 
> 
> Yes.  The divider is either 1, 2, or 3, and the only way to know which one
> it is is to look up the specific SOC model number.  And depending on the
> SOC model, there may also be a register that needs to be looked up.
> 
> > a
> > shared register setting? or a register setting within the i2c device?
> 
> The I2C device itself has no idea what the divider is.  It only sees the
> result of the divider.

Then that absolutely suggests to me that either the final clock or the
divider should be encoded in the i2c node; not in the soc node.

g.
