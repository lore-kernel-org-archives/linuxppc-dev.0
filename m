Return-Path: <cbouatmailru@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by ozlabs.org (Postfix) with ESMTP id 16800DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:51:06 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so139071mue.1
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:51:04 -0800 (PST)
Date: Fri, 21 Dec 2007 02:40:53 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] [POWERPC][SPI] use brg-frequency for SPI in QE
Message-ID: <20071220234053.GA1564@zarina>
References: <20071220202714.GA18471@localhost.localdomain>
	<20071220203322.GC19553@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071220203322.GC19553@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 11:33:22PM +0300, Anton Vorontsov wrote:
> In case of QE we can use brg-frequency (which is qeclk/2).
> Thus no need to divide sysclk in the spi_mpc83xx.
> 
> This patch also adds code to use get_brgfreq() on QE chips.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
[...]
> @@ -91,6 +91,11 @@ u32 get_brgfreq(void)
>  
>  	/* Legacy device binding -- will go away when no users are left. */
>  	node = of_find_node_by_type(NULL, "cpm");
> +	if (!node)
> +		node = of_find_compatible_node(NULL, NULL, "fsl,qe");
> +	if (!node)
> +		node = of_find_node_by_type(NULL, "qe");
> +
>  	if (node) {
>  		prop = of_get_property(node, "brg-frequency", &size);

I beg your pardon, truly. I just tested this on MPC8323E-RDB. No,
older u-boots doesn't have brg-frequency. So, I must add
of_get_property() for bus-frequency in case of failing
brg-frequency. :-/

I also found few glitches in `fsl_spi_init and users: stop using
device_type = "spi"' patch, regarding of_node_put(). Heh,
of_find_compatible_node() _puts_ `from' argument by itself, which
is not obvious at all.

I'll attach updated patches, with David's Acked-by on SPI driver
part. Other patches seem to be fine though.

Thanks,

p.s. dropping spi-devel list, because only powerpc stuff
affected.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
