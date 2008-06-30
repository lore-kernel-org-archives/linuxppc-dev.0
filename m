Return-Path: <david-b@pacbell.net>
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
Date: Sun, 29 Jun 2008 19:51:14 -0700
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080629065812.GO13876@secretlab.ca>
	<20080629091725.291974e9@hyperion.delvare>
In-Reply-To: <20080629091725.291974e9@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806291951.14465.david-b@pacbell.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 29 June 2008, Jean Delvare wrote:
> 
> > After the i2c adapter registers itself, of_register_i2c_devices() is called
> > which walks through the child nodes of the i2c adapter node in the device
> > tree.  Each child node is an i2c device, and it immediately get
> > registered with the adapter.  Because this ensures that i2c device
> > registration always happens after adapter registration, and since the
> > pointer to the i2c_adapter is known, then i2c_new_device() can be used
> > directly without ever needing to know the bus number.
> 
> Ah, OK. If you use i2c_new_device() then it's alright.

Right.  Conceptually the way that the i2c core uses "numbered"
adapters and registered board_info could be viewed as a way to
let platforms avoid tracking that stuff themselves.  Since
the of_* framework is already tracking that, there's no big win
in trying to have i2c-core track that too, on its behalf.

- Dave
