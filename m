Return-Path: <bhutchings@solarflare.com>
Received: from exchange.solarflare.com (exchange.solarflare.com
	[216.237.3.220]) by ozlabs.org (Postfix) with ESMTP id ACC71B6FCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Apr 2011 06:53:15 +1000 (EST)
Subject: Re: [PATCH V14 3/4] ptp: Added a clock driver for the IXP46x.
From: Ben Hutchings <bhutchings@solarflare.com>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Apr 2011 21:53:06 +0100
Message-ID: <1303159986.2857.56.camel@bwh-desktop>
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	John Stultz <john.stultz@linaro.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-18 at 08:29 +0200, Richard Cochran wrote:
> This patch adds a driver for the hardware time stamping unit found on the
> IXP465. The basic clock operations and an external trigger are implemented.
[...]
> --- a/drivers/net/arm/ixp4xx_eth.c
> +++ b/drivers/net/arm/ixp4xx_eth.c
[...]
> @@ -246,6 +255,169 @@ static int ports_open;
>  static struct port *npe_port_tab[MAX_NPES];
>  static struct dma_pool *dma_pool;
>  
> +static struct sock_filter ptp_filter[] = {
> +	PTP_FILTER
> +};
> +
> +static int ixp_ptp_match(struct sk_buff *skb, u16 uid_hi, u32 uid_lo, u16 seq)
> +{
> +	unsigned int type;
> +	u16 *hi, *id;
> +	u8 *lo, *data = skb->data;
> +
> +	type = sk_run_filter(skb, ptp_filter);
> +
> +	if (PTP_CLASS_V1_IPV4 == type) {
> +
> +		id = (u16 *)(data + 42 + 30);
> +		hi = (u16 *)(data + 42 + 22);
> +		lo = data + 42 + 24;
[...]

PTP_FILTER does not verify that the packet length is sufficient to hold
a complete PTP header, nor does it require that the IPv4 header length
is 5 (i.e. 20 bytes).  So you have to check those here rather than using
magic numbers.

I think you also need to use be16_to_cpup() to read 'id' and 'hi', since
the host byte order may vary.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
