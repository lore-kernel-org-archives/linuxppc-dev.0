Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E231F67D60
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:22:14 +1000 (EST)
Date: Sat, 23 Jul 2005 07:22:10 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Grant Likely <glikely@gmail.com>
Message-ID: <20050723142210.GA24313@gate.ebshome.net>
References: <528646bc05072307074e8fce3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc05072307074e8fce3e@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/3] SPI bus core infrastructure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Jul 23, 2005 at 10:07:38AM -0400, Grant Likely wrote:
> Patch to add support for SPI busses.  SPI bus master drivers and SPI
> slave drivers register with the SPI infrastructure.
> 
> +#define SPI_CLKEDGE_RISING	0
> +#define SPI_CLKEDGE_FALLING	1
> +struct spi_bus_ops {
> +	int (*transfer) (struct spi_bus *bus, int id, int clkedge,
> +	                 uint8_t *in, const uint8_t *out, size_t count);
> +};

This isn't enough.

You must have a way to specify clock frequency, data order (which bit 
goes first, char length.

Take a look at how PowerQUICC defines SPI peripheral, to get an idea 
on what should be made configurable.

This is what I use on PowerQUICC as SPI interface:

/* SPI parameters for a specific client.
 * Most of them have the same meaning as in SPMODE register
 */
struct pq2_spi_client {
    unsigned int clock_invert : 1;
    unsigned int clock_phase : 1;
    unsigned int reverse_data : 1;

    int char_length;
    int clock;  /* in Hz */
    const char *name;

    void (*cs_control)(int assert);
};

int pq2_spi_xfer(struct pq2_spi_client*, const u8 *tx_buf, u8 *rx_buf, int len);
