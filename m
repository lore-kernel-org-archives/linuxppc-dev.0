Return-Path: <scottwood@freescale.com>
Message-ID: <490625B0.3050203@freescale.com>
Date: Mon, 27 Oct 2008 15:33:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: I2C mux and device tree
References: <4902E0B5.7060007@embedded-sol.com>
In-Reply-To: <4902E0B5.7060007@embedded-sol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[added linuxppc-dev for a wider audience]

Felix Radensky wrote:
> I run linux-2.6.26 on custom 460EX based board.
> This platform has PCA9548 I2C mux on I2C bus 0.
> I was wondering how can I describe the mux itself
> and devices behind it (e.g RTC and temperature sensors)
> in the device tree.

Describe it as a node that is both an i2c client and an i2c controller.

The Sun i2c binding says that i2c devices should have two reg cells, the 
first being the bus number within the controller, and the second being a 
shifted-left-by-one i2c bus address (as opposed to the one-cell 
non-shifted address we currently use, because the Sun binding wasn't 
known to us at the time).

We could extend of_register_i2c_devices to understand two-cell 
addresses, and call it once for each sub-bus with the bus number as a 
parameter.

> If this is impossible at the moment, what other means
> exist to work with devices behind the mux ? I have
> found the pca954x patch and related virtual i2c patch
> and was able to integrate them intro my kernel.

You'll have to update it to be a new-style i2c device, unless there's a 
newer version floating around that what a quick google search turned up.

-Scott
