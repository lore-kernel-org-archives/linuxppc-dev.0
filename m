Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18462.35282.374180.770237@cargo.ozlabs.ibm.com>
Date: Mon, 5 May 2008 14:15:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Fix of_i2c include for module compilation
In-Reply-To: <481C5DD0.5090503@scram.de>
References: <481C5DD0.5090503@scram.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich writes:

> -#ifdef CONFIG_OF_I2C
> +#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
>  
>  void of_register_i2c_devices(struct i2c_adapter *adap,
>  			     struct device_node *adap_node);

Why do we have that ifdef there at all?  There's only that one
external declaration within it, so the #ifdef and #endif could just be
removed.  If the ifdef hadn't been there in the first place we
wouldn't have had this problem.

Paul.
