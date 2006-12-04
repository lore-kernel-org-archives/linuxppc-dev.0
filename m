Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CE73067BD5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 06:54:50 +1100 (EST)
Date: Mon, 4 Dec 2006 13:49:34 -0600
From: Olof Johansson <olof@lixom.net>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20061204134934.6281a2df@localhost.localdomain>
In-Reply-To: <1165247338.18104.21.camel@localhost>
References: <45707469.9060604@austin.ibm.com>
	<1165247338.18104.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 04 Dec 2006 09:48:58 -0600 Will Schmidt <will_schmidt@vnet.ibm.com> wrote:

> You could eliminate the temp variable rtas_poweron_auto_token, and
> rewrite as something like:
> 
>                if (rtas_token("ibm,power-off-ups") == RTAS_UNKNOWN_SERVICE) {
>                        rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
>                        printk(KERN_EMERG "Power-off called instead %d\n", rc );
>                } else {
>                        rc = rtas_call(rtas_token("ibm,power-off-ups"),0, 1, NULL);
>                        printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
>                }

It'd be even cleaner if you went the other way around instead, always
do the temp variable. I also renamed it since it was misleading:

void rtas_power_off(void)
{
	int rc;
	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");

 	if (rtas_flash_term_hook)
 		rtas_flash_term_hook(SYS_POWER_OFF);

	if (rtas_poweron_auto == 0 || 
		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
		/* allow power on only with power button press */
		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1)
		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
	} else {
		/* Enable the system to reboot if power comes back on */
		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
	}
 	for (;;);
}


-Olof
