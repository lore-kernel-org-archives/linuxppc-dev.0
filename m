Date: Fri, 15 Mar 2002 10:04:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Message-ID: <20020315170433.GA691@opus.bloom.county>
References: <0203150611.AA26053@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203150611.AA26053@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 14, 2002 at 10:11:39PM -0800, Michael Sokolov wrote:

> diff -Nru a/arch/ppc/boot/common/misc-simple.c b/arch/ppc/boot/common/misc-simple.c
> --- a/arch/ppc/boot/common/misc-simple.c	Thu Mar 14 21:31:15 2002
> +++ b/arch/ppc/boot/common/misc-simple.c	Thu Mar 14 21:31:15 2002
> @@ -69,6 +69,10 @@
>  extern void gunzip(void *, int, unsigned char *, int *);
>  extern void serial_fixups(void);
>
> +#ifdef CONFIG_EV64260
> +extern struct bi_record *add_extra_bi_recs(struct bi_record *bp);
> +#endif
> +
>  struct bi_record *
>  decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
>  {

Don't need to #ifdef externs..

> diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
> --- a/arch/ppc/config.in	Thu Mar 14 21:31:15 2002
> +++ b/arch/ppc/config.in	Thu Mar 14 21:31:15 2002
> @@ -151,32 +151,17 @@
>    bool 'Enable MPC10x store gathering' CONFIG_MPC10X_STORE_GATHERING
>  fi
>
>  if [ "$CONFIG_EV64260" = "y" ]; then
>    define_bool CONFIG_GT64260 y
>    define_int CONFIG_SERIAL_CONSOLE_BAUD 115200
>  fi
>
> -if [ "$CONFIG_GT64260" = "y" ]; then
> +if [ "$CONFIG_EV64260" = "y" ]; then

If you're going to use the same test here as above, don't make it two
cases.

> +   comment 'EV-64260-BP zImage Wrapper Options'
> +   string 'Ethernet 0 MAC Address' CONFIG_EV64260_ETH_0_MACADDR "feffff000000"
> +   string 'Ethernet 1 MAC Address' CONFIG_EV64260_ETH_1_MACADDR "feffff000001"
> +   string 'Ethernet 2 MAC Address' CONFIG_EV64260_ETH_2_MACADDR "feffff000002"

I think this is semi-wrong, or at least the comment is.  Troy is working
on the Motorola MVP and is confined to DINK. But I don't know as much about
the gt64260 stuffs as Troy and Mark do.

> @@ -690,7 +675,7 @@
>  fi
>  if [ "$CONFIG_MCPN765" = "y" -o "$CONFIG_SANDPOINT" = "y" \
>  	-o "$CONFIG_ZX4500" = "y" -o "$CONFIG_PRPMC800" = "y" \
> -	-o "$CONFIG_4xx" = "y" -o "$CONFIG_GT64260" = "y" ]; then
> +	-o "$CONFIG_4xx" = "y" -o "$CONFIG_EV64260" = "y" ]; then
>    bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
>  fi
>  endmenu

I think this is also wrong for the same reasons, and iirc this should
just work, or should.

> diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
> --- a/arch/ppc/kernel/setup.c	Thu Mar 14 21:31:15 2002
> +++ b/arch/ppc/kernel/setup.c	Thu Mar 14 21:31:15 2002
> @@ -40,6 +40,10 @@
>  #include <asm/kgdb.h>
>  #endif
>
> +#ifdef CONFIG_GT64260
> +#include <asm/gt64260.h>
> +#endif /* CONFIG_GT64260 */
> +
>  extern void platform_init(unsigned long r3, unsigned long r4,
>  		unsigned long r5, unsigned long r6, unsigned long r7);
>  extern void bootx_init(unsigned long r4, unsigned long phys);

Don't protect includes with #ifdefs unless it's really needed (from what
I can see, it isn't).

> diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
> --- a/drivers/net/Config.in	Thu Mar 14 21:31:15 2002
> +++ b/drivers/net/Config.in	Thu Mar 14 21:31:15 2002
> @@ -37,6 +37,7 @@
>        fi
>        dep_tristate '  BMAC (G3 ethernet) support' CONFIG_BMAC $CONFIG_ALL_PPC
>        dep_tristate '  GMAC (G4/iBook ethernet) support' CONFIG_GMAC $CONFIG_ALL_PPC
> +      dep_bool '  GT64260 Ethernet Ports' CONFIG_GT64260_ETH $CONFIG_GT64260
>        if [ "$CONFIG_4xx" = "y" ]; then
>           if [ "$CONFIG_REDWOOD_4" = "y" -o "$CONFIG_403GCX" = "y" ]; then
>  	    tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET

Not quite.  We do a really bad thing of explicity setting CONFIG_ALL_PPC
always, so we can always do a test on it in config bits.  This should
be:
if [ "$CONFIG_GT64260" = "y" ]; then
   bool '  GT64260 Ethernet Ports' CONFIG_GT64260_ETH
fi

Aside from that, it looks quite good and removes the horribly ugly
setting of MAC addrs, for the most part.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
