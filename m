Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Kill machine numbers
Date: Fri, 24 Mar 2006 10:27:38 +0100
References: <1143178947.4257.78.camel@localhost.localdomain>
In-Reply-To: <1143178947.4257.78.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200603241027.39836.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 24 March 2006 06:42, Benjamin Herrenschmidt wrote:
> -                       if (strstr(p, RELOC("IBM,CPB")))
> -                               return PLATFORM_CELL;

> +int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> +{
> +       const char* cp;
> +       unsigned long cplen, l;
> +
> +       cp = of_get_flat_dt_prop(node, "compatible", &cplen);
> +       if (cp == NULL)
> +               return 0;
> +       while (cplen > 0) {
> +               if (strncasecmp(cp, compat, strlen(compat)) == 0)
> +                       return 1;
> +               l = strlen(cp) + 1;
> +               cp += l;
> +               cplen -= l;
> +       }
> +
> +       return 0;
> +}

> +static int __init cell_probe(void)
>  {
> -       if (platform != PLATFORM_CELL)
> +       unsigned long root = of_get_flat_dt_root();
> +       if (!of_flat_dt_is_compatible(root, "IBM,CPB"))
>                 return 0;
>  

Unfortunately, this breaks cell detection. The string in our current
hardware is 'IBM,CPBW-1.0', for reasons you don't want to know.
We just relied on strstr being able to scan for everything starting
with 'IBM,CPB'.

For even more obscure reasons, our future firmware is planned
to no no longer claim compatibility with that but rather with
'CBEA' _and_ 'IBM,CBEA'.

At this point, the issue is getting really complicated, as CBEA
was meant to be a generic identifier for all systems based on
that architecture extension, but we probably want to have different
machine_description data for e.g. IBM and Sony hardware, so they
should check for different values.

As soon as I get to the office, I'll try to do a patch that at
least 

- restores the current functionality by checking for 'IBM,CPBW-1.0'
- also checks for 'IBM,CBEA' so we don't break on future IBM systems

but we should make sure we come to a solution that is practical
to all system vendors that are participating in Linux support.

	Arnd <><
