Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D23BDDE20
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 12:12:24 +1100 (EST)
Subject: Re: [PATCH] More SMU commands
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20070106024242.GA18395@hansmi.ch>
References: <20061224130531.GA28635@hansmi.ch>
	<1167082402.3522.8.camel@localhost.localdomain>
	<20070105001014.GA28410@hansmi.ch> <20070106024242.GA18395@hansmi.ch>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 12:12:10 +1100
Message-Id: <1168218731.22458.109.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +#define SMU_CMD_POWER_EVENTS_COMMAND		0x8f
> +
> +/*
> + * Enables file server mode
> + *
> + * Meaning or use is unknown. Maybe this allows the machine to power up after
> + * AC loss.

Meaning and use are known :-) This defines events related to powering or
waking the machine up :-)

> + * Parameters:
> + *   2: always 0x00, meaning unknown
> + *   3: always 0x02, meaning unknown

Paremeters depend on the subcommand.

> + * Returns:
> + *   2 bytes
> + */
> +#define   SMU_CMD_POWER_EVENTS_SET_FILESERVER_MODE	0x01

Look at the corresponding PMU commands.

/* PMU PMU_POWER_EVENTS commands */
enum {
        PMU_PWR_GET_POWERUP_EVENTS      = 0x00,
        PMU_PWR_SET_POWERUP_EVENTS      = 0x01,
        PMU_PWR_CLR_POWERUP_EVENTS      = 0x02,
        PMU_PWR_GET_WAKEUP_EVENTS       = 0x03,
        PMU_PWR_SET_WAKEUP_EVENTS       = 0x04,
        PMU_PWR_CLR_WAKEUP_EVENTS       = 0x05,
};

(There might be others above 5 but that's the one I know about, they are
the same on the SMU).

The "POWERUP" events define events that can powerup the machine when
shut down. The "WAKEUP" events define events that can wake up the
machine when sleeping.

Both sets of commands are made of 3 base commands: GET, SET abd CLR. The
events are a 16 bits bit mask though from my experience, only the first
8 bits is ever used. GET reads the current mask afaik (though it might
not always work, I had issues in the past). SET enabled some events, CLR
disables some events.

The bit values for the events themselves aren't completly known, but
they seem to follow the same convention as the PMU, which is 

/* Power events wakeup bits */
enum {
        PMU_PWR_WAKEUP_KEY              = 0x01, /* Wake on key press */
        PMU_PWR_WAKEUP_AC_INSERT        = 0x02, /* Wake on AC adapter plug */
        PMU_PWR_WAKEUP_AC_CHANGE        = 0x04,
        PMU_PWR_WAKEUP_LID_OPEN         = 0x08,
        PMU_PWR_WAKEUP_RING             = 0x10,
};

So for example, a CLR with 0xff 0xff will clear all events. Then, a SET with
0x02 0x00 will enable "AC INSERT" event.

The way to enable file server mode is to enable POWERUP on the AC_INSERT
event.

Ben.
