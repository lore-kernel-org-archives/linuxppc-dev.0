Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 939C567BCF
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 21:29:17 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAGATBF2014112
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:29:11 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAGATDaa028829
	for linuxppc-dev@ozlabs.org; Thu, 16 Nov 2006 19:29:13 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAGATBfo029187
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:29:11 +0900 (JST)
Date: Thu, 16 Nov 2006 19:29:10 +0900 (JST)
Message-Id: <200611161029.kAGATB6i001993@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: Re:[PATCH 3/16] add base support for Celleb platform
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd-san,

> On Wednesday 15 November 2006 10:31, Ishizaki Kou wrote:
> > 06
> > @@ -58,7 +58,12 @@
> >         FW_FEATURE_PSERIES_ALWAYS = 0,
> >         FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
> >         FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
> > +       FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR,
> > +       FW_FEATURE_CELLEB_ALWAYS = FW_FEATURE_LPAR,
> >         FW_FEATURE_POSSIBLE =
> > +#ifdef CONFIG_PPC_CELLEB
> > +               FW_FEATURE_CELLEB_POSSIBLE |
> > +#endif
> >  #ifdef CONFIG_PPC_PSERIES
> >                 FW_FEATURE_PSERIES_POSSIBLE |
> >  #endif
> > @@ -67,6 +72,9 @@
> >  #endif
> >                 0,
> >         FW_FEATURE_ALWAYS =
> > +#ifdef CONFIG_PPC_CELLEB
> > +               FW_FEATURE_CELLEB_ALWAYS &
> > +#endif
> >  #ifdef CONFIG_PPC_PSERIES
> >                 FW_FEATURE_PSERIES_ALWAYS &
> >  #endif

> My guess is that it would be helpful to have a FW_FEATURE_BEAT or similar
> so that you can test this bit in runtime checks, instead of testing
> for FW_FEATURE_LPAR.

Because some common routines seem to check FW_FEATURE_LPAR bit not to touch
Hypervisor resources, we have to set FW_FEATURE_LPAR on Celleb. And then,
we have only Beat on Celleb as hypervisor, it is satisfactory that to
check the FW_FEATURE_LPAR bit not to touch hypervisor resources.

> > +#include "beat.h"
> > +
> > +int64_t        beat_errno;

> Hmm, a global errno variable is usually considered a bad idea, because it
> is inherently racy. Is this the hcall return value? If so, you should
> probably just pass it as the return code from the hcall function.

Okay, we will remove it.

This variable was here since we use our small library to invoke hcall
function, and the library stores the error code (returned in %r3) to
that variable. Now hcall function calls are inlined, so we don't use
it anymore.

> > +static void beat_power_save(void)
> > +{
> > +       beat_pause(0);
> > +}

> Nice, I wish the other power_save implementations were this easy ;-)

We agree.

> > +#ifdef CONFIG_SERIAL_TXX9
> > +/* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
> > +    mmio=0xfff000-0x1000,0xff2000-0x1000 */
> > +static int txx9_serial_bitmap = 0;
> > +
> > +static struct {
> > +       uint32_t offset;
> > +       uint32_t index;
> > +} txx9_spider_tab[3] = {
> > +       { 0x300, 0 },   /* 0xFFF300 */
> > +       { 0x400, 0 },   /* 0xFFF400 */
> > +       { 0x800, 1 }    /* 0xFF2800 */
> > +};
> > +
> > +static int txx9_serial_init(void)
> > +{
> > +       extern int early_serial_txx9_setup(struct uart_port *port);
> > +       struct device_node *node;
> > +       uint64_t *irq_prop, *base_prop;
> > +       int irq_len, base_addr_len;
> > +       int i, maxi;
> > +       struct uart_port req;
> > +
> > +       node = of_find_node_by_path("/ioif1/sio");
> > +       if (!node)
> > +               return 0;
> > +       
> > +       irq_prop = (uint64_t *)get_property(node, "interrupts", &irq_len);
> > +       if (!irq_prop)
> > +               goto out;
> > +       irq_len /= sizeof(uint64_t);
> > +
> > +       base_prop = (uint64_t *)get_property(node, "toshiba,reg", &base_addr_len);
> > +       if (!base_prop)
> > +               goto out;
> > +       base_addr_len /= sizeof(uint64_t) * 2;
> > +
> > +       maxi = sizeof(txx9_spider_tab)/sizeof(txx9_spider_tab[0]);
> > +       if (maxi > irq_len)
> > +               maxi = irq_len;
> > +
> > +       for(i = 0; i < maxi; i++) {
> > +               if (!(txx9_serial_bitmap & (1<<i)))
> > +                       continue;
> > +               if (base_addr_len <= txx9_spider_tab[i].index)
> > +                       continue;
> > +               
> > +               memset(&req, 0, sizeof(req));
> > +               req.line = i;
> > +               req.iotype = UPIO_MEM;
> > +               req.mapbase = base_prop[txx9_spider_tab[i].index * 2]
> > +                       + txx9_spider_tab[i].offset;
> > +#ifdef CONFIG_SERIAL_TXX9_CONSOLE
> > +               req.membase = ioremap(req.mapbase, 0x24);
> > +#endif
> > +               req.irq = irq_create_mapping(NULL, irq_prop[i]);
> > +               req.flags |= UPF_IOREMAP | UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
> > +               req.uartclk = 83300000;
> > +               early_serial_txx9_setup(&req);
> > +       }
> > +
> > +out:
> > +       of_node_put(node);
> > +       return 0;
> > +}

> Hmm, a standard OFW reg property would just encode all three address
> ranges in one property. Is there a specific reason why you can't do that?

This routine depends on non-standard device-tree property since our older
boot system eventually lacks standard properties. Our boot system is still
under development on standard properties.

Adding to that, Beat system allows mapping physical memory (i.e. MMIO) in
only page unit and does not allow same physical page within one device.
So we have to map page only once for SIO0 and SIO1 devices (these are in
same page), and have to have separate page for SIO2.

Thank you,
Kou Ishizaki
Toshiba
