Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3004867C6A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:38:46 +1100 (EST)
Date: Thu, 14 Dec 2006 10:38:36 +0900 (JST)
Message-Id: <200612140138.kBE1cb1O000668@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
In-Reply-To: <200612121342.52306.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > @@ -0,0 +1,10 @@
> > +obj-$(CONFIG_PPC_CELLEB)		+= interrupt.o iommu.o setup.o \
> > +								          lpar.o beat.o pci.o \
> > +												   scc_epci.o scc_uhc.o

> Generally, you should only add the file names to the Makefile in the
> patch that actually adds the respective files, so that applying only
> part of the series does not prevent you from building the kernel.

Generally yes.

> > +int64_t	beat_errno;
> > +

> As mentioned in the last review, this global errno causes trouble
> sooner or later, so you should get rid of it. Any beat hcall that
> returns an error condition should do that as the return value
> or through a pointer argument.

I see. It'll be gone on future patch.

> > +#ifdef CONFIG_SERIAL_TXX9
> > +#include <linux/tty.h>
> > +#include <linux/serial.h>
> > +#include <linux/serial_core.h>
> > +#endif
> > +

> The serial_txx9 stuff should not really be in setup.c, but in a separate
> file. There are other pieces of code that could be moved to separate
> source files (e.g. nvram, time, udbg), but this one is the most
> obvious candidate.

I understand your opinion, so I'll try for it.

> > +static void celleb_show_cpuinfo(struct seq_file *m)
> > +{
> > +	struct device_node *root;
> > +	const char *model = "";
> > +
> > +	root = of_find_node_by_path("/");
> > +	if (root)
> > +	   model = get_property(root, "model", NULL);
> > +	   seq_printf(m, "machine\t\t: CHRP %s\n", model);
> > +	   of_node_put(root);
> > +}

> I'm not sure if it's a good idea to claim CHRP compatibility
> here. Is that a workaround for a specific incompatibility? Normally,
> I'd say you should print "machine\t\t: BEAT %s\n" or
> "machine\t\t: Celleb %s\n", since you are definitely not running
> a CHRP compatible firmware.

This is placed only to "trick" Anaconda into installing Fedora Core Linux.
Fedora refuses to be installed into 'unknown' system.

> > Index: linux-powerpc-git/include/asm-powerpc/firmware.h
> > diff -u linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/firmware.h:1.2
> > --- linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1     Wed Dec  6 08:24:04 2006
> > +++ linux-powerpc-git/include/asm-powerpc/firmware.h	     Wed Dec  6 08:43:16 2006
> > @@ -61,6 +61,8 @@
> >    FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
> >    FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
> >    FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
> > +  FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR,
> > +  FW_FEATURE_CELLEB_ALWAYS = FW_FEATURE_LPAR,
> >    FW_FEATURE_NATIVE_POSSIBLE = 0,
> >    FW_FEATURE_NATIVE_ALWAYS = 0,
> >    FW_FEATURE_POSSIBLE =

> It's probably reasonable to define a FW_FEATURE_BEAT that is always set
> for celleb, so you can test that feature before attempting a beat
> specific hcall.

We added FW_FWATURE_BEAT bit asm-powerpc/firmware.h

Best regards,
Kou Ishizaki
