Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18390.8909.874184.315920@cargo.ozlabs.ibm.com>
Date: Tue, 11 Mar 2008 17:12:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
In-Reply-To: <47C750CE.7050202@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C750CE.7050202@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> +#else /* CONFIG_PHYP_DUMP */
> +int early_init_dt_scan_phyp_dump(unsigned long node,
> +		const char *uname, int depth, void *data) { return 0; }

This shouldn't be in the header file.  Either put it in prom.c (and
make it return 1 so the of_scan_flat_dt call doesn't have to go
through the entire device tree), or put #ifdef CONFIG_PHYP_DUMP around
the of_scan_flat_dt call itself.

> +/* Global, used to communicate data between early boot and late boot */
> +static struct phyp_dump phyp_dump_global;
> +struct phyp_dump *phyp_dump_info = &phyp_dump_global;

It's a little weird to have a static variable with global in its name.

> +int __init early_init_dt_scan_phyp_dump(unsigned long node,
> +		const char *uname, int depth, void *data)
> +{
> +#ifdef CONFIG_PHYP_DUMP

This is in phyp_dump.c, which only gets compiled if CONFIG_PHYP_DUMP
is set, so you don't need this ifdef.

Paul.
