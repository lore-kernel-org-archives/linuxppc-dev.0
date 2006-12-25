Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96C7BDDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Dec 2006 08:33:30 +1100 (EST)
Subject: Re: [PATCH] More SMU commands
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20061224130531.GA28635@hansmi.ch>
References: <20061224130531.GA28635@hansmi.ch>
Content-Type: text/plain
Date: Tue, 26 Dec 2006 08:33:22 +1100
Message-Id: <1167082402.3522.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-12-24 at 14:05 +0100, Michael Hanselmann wrote:

> +/*
> + * Sets "system ready" status
> + *
> + * Parameters:
> + *   1: status [0x00, 0x01 or 0x02]
> + */
> +#define   SMU_CMD_MISC_df_SET_DISPLAY_LIT	0x02

Do you know more about wha that actually does ?

> +/*
> + * Sets mode of power switch
> + *
> + * Parameters:
> + *   1: enable power switch? [0x00 or 0x01]
> + *   2: enable nmi? [0x00 or 0x01]
> + */
>  #define   SMU_CMD_MISC_df_NMI_OPTION		0x04

More coments here as well... what does "enabling power switch" means ?
enabling reception of events / interrupts when it's pressed ? same for
NMI, if you don't know, say it, but give as much details as you can.

> +/*
> + * Switches
> + *
> + * These are switches whose status seems to be known to the SMU.
> + *
> + * Parameters:
> + *   none
> + */
> +#define SMU_CMD_SWITCHES			0xdc

You didn't give any info on the format of the command (parameters,
results).

> +/* Switches bits */
> +#define SMU_SWITCH_CASE_CLOSED			0x01
> +#define SMU_SWITCH_AC_POWER			0x04
> +#define SMU_SWITCH_POWER_SWITCH			0x08

> +/*
> + * Misc commands 2
> + *
> + * Parameters:
> + *   1: subcommand
> + */
> +#define SMU_CMD_MISC_8f_COMMAND			0x8f

This should probably be named POWER EVENTS or so.

> +/*
> + * File server mode
> + *
> + * Parameters:
> + *   2: to enable, set to 0x01, otherwise 0xff
> + *   3: always 0xff
> + */
> +#define   SMU_CMD_MISC_8f_FILESERVER_MODE	0x02

The meaning of the power events parameters is the same as for the PMU,
you can get the actual constants there. Your constant is incorrect. The
first parameter (subcommand) is apparently like the PMU:

        PMU_PWR_GET_POWERUP_EVENTS      = 0x00,
        PMU_PWR_SET_POWERUP_EVENTS      = 0x01,
        PMU_PWR_CLR_POWERUP_EVENTS      = 0x02,
        PMU_PWR_GET_WAKEUP_EVENTS       = 0x03,
        PMU_PWR_SET_WAKEUP_EVENTS       = 0x04,
        PMU_PWR_CLR_WAKEUP_EVENTS       = 0x05,

Followed by a 16 bits event mask whose only known defined values for the
PMU are:

        PMU_PWR_WAKEUP_KEY              = 0x01, /* Wake on key press */
        PMU_PWR_WAKEUP_AC_INSERT        = 0x02, /* Wake on AC adapter plug */
        PMU_PWR_WAKEUP_AC_CHANGE        = 0x04,
        PMU_PWR_WAKEUP_LID_OPEN         = 0x08,
        PMU_PWR_WAKEUP_RING             = 0x10,

I haven't really verified if those match the values on SMU based machines. 

> +/*
> + * Retrieves last shutdown cause
> + *
> + * Parameters:
> + *   none
> + *
> + * Returns:
> + *   Last shutdown cause
> + */
> +#define   SMU_CMD_MISC_8f_LAST_SHUTDOWN_CAUSE	0x07

Same comment as before, you didn't provide info about the arguments and
results of this. If you don't know, say it so, but at least provide the
number of args/results as I think it can be found in the OF code.

> +/*
> + * Sets or gets server ID
> + *
> + * Parameters:
> + *   2 (optional): Set server ID to this value
> + *
> + * Returns:
> + *   Current server ID
> + */
> +#define   SMU_CMD_MISC_8f_SERVER_ID		0x08

Any idea what this means ?

Ben.
