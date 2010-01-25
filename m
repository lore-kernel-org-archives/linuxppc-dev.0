Return-Path: <wg@grandegger.com>
Message-ID: <4B5DE3FB.10505@grandegger.com>
Date: Mon, 25 Jan 2010 19:33:31 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors	from
	Freescale
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
	<1264408029-5290-3-git-send-email-wg@grandegger.com>
	<20100125115211.GA5257@pengutronix.de>
	<4B5D894C.4090001@grandegger.com>
	<20100125151509.GD5257@pengutronix.de>
In-Reply-To: <20100125151509.GD5257@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
>>>>  
>>>> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
>>>> -					    struct mpc_i2c *i2c,
>>>> -					    u32 clock, u32 prescaler)
>>>> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
>>>> +					 struct mpc_i2c *i2c,
>>>> +					 u32 clock, u32 prescaler)
>>>>  {
>>>>  	int ret, fdr;
>>>>  
>>>> +	if (clock == -1) {
>>> Could we use 0 for 'no_clock'? This would make the above statement simply
>> "0" is already used to maintain backward compatibility setting a safe
>> divider.
> 
> Ah, now I see:
> 
> 'clock == -1' means 'preserve clocks' (and is checked here in mpc_i2c_setup_52xx())

Yes, this is now necessary because "setup" does not just do clock settings.

> 'clock ==  0' means 'safe divider' (and is checked in mpc_i2c_get_fdr_52xx())

This is for compatibility with old DTS files and last time it was tricky
 to get that right and therefore...

> This is not a beauty ;)
> 
> What about adding a flags variable to the setup-functions?

.. I hesitate to make bigger changes to the code flow, which the
introduction of a flags variable would required. Also it seems to be
overkill to me. I will have a closer look, though. At a minimum I will
replace "-1" with "MPC_I2C_PRESERVE_CLOCK".

Wolfgang.
