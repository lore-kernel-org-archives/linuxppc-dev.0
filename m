Date: Thu, 1 Jul 2004 11:59:51 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	kumar.gala@freescale.com, mcclintock@freescale.com
Subject: Re: [PATCH][RFC]Updated MPC I2C driver
Message-ID: <20040701185951.GA15981@gate.ebshome.net>
References: <1088705955.28598.168.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088705955.28598.168.camel@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 01, 2004 at 07:19:15PM +0100, Adrian Cox wrote:

[snip]

> +static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +        unsigned long orig_jiffies = jiffies;
> +        u32 x;
> +	int result = 0;
> +
> +	if (i2c->ocpdef->irq == OCP_IRQ_NA) {
> +		while(! (readl(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
> +			schedule();
> +			if (orig_jiffies + timeout < jiffies) {

This doesn't look right. Please, use time_after()/time_before() here.

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
