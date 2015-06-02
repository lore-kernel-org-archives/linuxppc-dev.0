Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id BAEE21A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 17:21:41 +1000 (AEST)
Date: Tue, 2 Jun 2015 17:21:22 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC 24/24] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
In-Reply-To: <CAMuHMdW3qrFqesRqR=YW8qEEbVZPtK8exG0jF+YyfVqokMiyNg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1506021517460.3598@nippy.intranet>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010138.309478365@telegraphics.com.au>
 <CAMuHMdW3qrFqesRqR=YW8qEEbVZPtK8exG0jF+YyfVqokMiyNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 1 Jun 2015, Geert Uytterhoeven wrote:

> > Index: linux/arch/m68k/atari/nvram.c
> > ===================================================================
> > --- linux.orig/arch/m68k/atari/nvram.c  2015-05-31 11:01:21.000000000
> > +1000
> > +++ linux/arch/m68k/atari/nvram.c       2015-05-31 11:01:29.000000000
> > +1000
> > @@ -73,7 +73,7 @@ static void __nvram_set_checksum(void)
> 
> > +#ifndef CONFIG_MAC
> >  const struct nvram_ops arch_nvram_ops = {
> > -       .read           = nvram_read,
> > -       .write          = nvram_write,
> > -       .get_size       = nvram_get_size,
> > -       .set_checksum   = nvram_set_checksum,
> > -       .initialize     = nvram_initialize,
> > +       .read           = atari_nvram_read,
> > +       .write          = atari_nvram_write,
> > +       .get_size       = atari_nvram_get_size,
> > +       .set_checksum   = atari_nvram_set_checksum,
> > +       .initialize     = atari_nvram_initialize,
> >  };
> >  EXPORT_SYMBOL(arch_nvram_ops);
> > +#endif
> 
> IMHO, the #ifdef is ugly.
> 
> >  #ifdef CONFIG_PROC_FS
> >  static struct {
> > Index: linux/arch/m68k/mac/misc.c
> > ===================================================================
> > --- linux.orig/arch/m68k/mac/misc.c     2015-05-31 11:01:28.000000000 +1000
> > +++ linux/arch/m68k/mac/misc.c  2015-05-31 11:01:29.000000000 +1000
> > @@ -489,7 +489,7 @@ void pmu_shutdown(void)
> 
> > +#ifndef CONFIG_ATARI
> >  const struct nvram_ops arch_nvram_ops = {
> >         .read_byte      = mac_pram_read_byte,
> >         .write_byte     = mac_pram_write_byte,
> >         .get_size       = mac_pram_get_size,
> >  };
> >  EXPORT_SYMBOL(arch_nvram_ops);
> > +#endif
> >  #endif /* CONFIG_NVRAM */
> 
> Same here.

We could eliminate the Atari and Mac definitions of arch_nvram_ops, and 
define the struct only in arch/m68k/kernel/setup_mm.c -- at the cost of 
some bloat (see below).

> 
> > Index: linux/arch/m68k/kernel/setup_mm.c
> > ===================================================================
> > --- linux.orig/arch/m68k/kernel/setup_mm.c      2015-05-31 11:00:59.000000000 +1000
> > +++ linux/arch/m68k/kernel/setup_mm.c   2015-05-31 11:01:29.000000000 +1000
> 
> > @@ -568,3 +572,88 @@ static int __init adb_probe_sync_enable
> >
> >  __setup("adb_sync", adb_probe_sync_enable);
> >  #endif /* CONFIG_ADB */
> > +
> > +#if IS_ENABLED(CONFIG_NVRAM) && defined(CONFIG_ATARI) && defined(CONFIG_MAC)
> 
> Likewise.

Given the Kconfig constraints, this can be simplified to 
IS_ENABLED(CONFIG_NVRAM). Will fix.

> 
> > +static ssize_t m68k_nvram_read(char *buf, size_t count, loff_t *ppos)
> > +{
> > +       if (MACH_IS_ATARI)
> > +               return atari_nvram_read(buf, count, ppos);
> > +       else if (MACH_IS_MAC) {
> > +               ssize_t size = mac_pram_get_size();
> > +               char *p = buf;
> > +               loff_t i;
> > +
> > +               for (i = *ppos; count > 0 && i < size; --count, ++i, ++p)
> > +                       *p = mac_pram_read_byte(i);
> > +
> > +               *ppos = i;
> > +               return p - buf;
> > +       }
> > +       return -EINVAL;
> 
> Isn't this handled already by the nvram core, based on the available 
> operations in nvram_ops?

A multi-platform kernel can't set inappropriate ops to NULL at run-time, 
because the struct is const. (Maybe we can on m68k? That doesn't mean it 
is good style.)

There isn't any nvram core as such. The nvram misc device is just one of 
many callers of the functions in the ops struct.

(The read_byte and write_byte loops above that also appear in the misc 
device are different in that latter loops involve userspace. So I have not 
factored them out. If it were possible to refactor, the shared code would 
have to go into include/linux/nvram.h.)

> Same for the other nvram abstractions in this file.

Again, a multi-platform kernel needs them. E.g. a kernel eith CONFIG_ATARI 
&& CONFIG_MAC has to support checksummed Atari NVRAM. If you boot it on a 
Mac, you need the m68k_nvram_set_checksum() and m68k_nvram_initialize() 
stubs.

Whereas, a single-platform kernel, having CONFIG_MAC && !CONFIG_ATARI, you 
don't define the .set_checksum and .initialize ops at all. (Like any PPC32 
kernel, BTW.)

> 
> > +const struct nvram_ops arch_nvram_ops = {
> > +       .read           = m68k_nvram_read,
> > +       .write          = m68k_nvram_write,
> > +       .read_byte      = m68k_nvram_read_byte,
> > +       .write_byte     = m68k_nvram_write_byte,
> > +       .get_size       = m68k_nvram_get_size,
> > +       .set_checksum   = m68k_nvram_set_checksum,
> > +       .initialize     = m68k_nvram_initialize,
> > +};
> > +EXPORT_SYMBOL(arch_nvram_ops);
> 
> Can't you just fill in the mach specific pointers in the generic 
> structure, and be done with it?

Not at compile-time. Hence the mach-independent functions, i.e. the 
wrapper functions that dispatch to the mach-specific functions.

The wrappers and stubs only add bloat in a single-platform kernel binary. 
I avoided this by use of the #ifdefs you objected to above.

I suppose we could instead do, in arch/m68k/kernel/setup_mm.c, something 
like the following.

+
+#if IS_ENABLED(CONFIG_NVRAM)
+#ifdef CONFIG_MAC
+static unsigned char m68k_nvram_read_byte(int addr)
+{
+       if (MACH_IS_MAC)
+               return mac_pram_read_byte(addr);
+       return 0xff;
+}
+
+static void m68k_nvram_write_byte(unsigned char val, int addr)
+{
+       if (MACH_IS_MAC)
+               mac_pram_write_byte(val, addr);
+}
+#endif
+
+#ifdef CONFIG_ATARI
+static ssize_t m68k_nvram_read(char *buf, size_t count, loff_t *ppos)
+{
+       if (MACH_IS_ATARI)
+               return atari_nvram_read(buf, count, ppos);
+       else if (MACH_IS_MAC) {
+               ssize_t size = mac_pram_get_size();
+               char *p = buf;
+               loff_t i;
+
+               for (i = *ppos; count > 0 && i < size; --count, ++i, ++p)
+                       *p = mac_pram_read_byte(i);
+
+               *ppos = i;
+               return p - buf;
+       }
+       return -EINVAL;
+}
+
+static ssize_t m68k_nvram_write(char *buf, size_t count, loff_t *ppos)
+{
+       if (MACH_IS_ATARI)
+               return atari_nvram_write(buf, count, ppos);
+       else if (MACH_IS_MAC) {
+               ssize_t size = mac_pram_get_size();
+               char *p = buf;
+               loff_t i;
+
+               for (i = *ppos; count > 0 && i < size; --count, ++i, ++p)
+                       mac_pram_write_byte(*p, i);
+
+               *ppos = i;
+               return p - buf;
+       }
+       return -EINVAL;
+}
+
+static long m68k_nvram_set_checksum(void)
+{
+       if (MACH_IS_ATARI)
+               return atari_nvram_set_checksum();
+       return -EINVAL;
+}
+
+static long m68k_nvram_initialize(void)
+{
+       if (MACH_IS_ATARI)
+               return atari_nvram_initialize();
+       return -EINVAL;
+}
+#endif
+
+const struct nvram_ops arch_nvram_ops = {
+       .get_size       = m68k_nvram_get_size,
+#ifdef CONFIG_MAC
+       .read_byte      = m68k_nvram_read_byte,
+       .write_byte     = m68k_nvram_write_byte,
+#endif
+#ifdef CONFIG_ATARI
+       .read           = m68k_nvram_read,
+       .write          = m68k_nvram_write,
+       .set_checksum   = m68k_nvram_set_checksum,
+       .initialize     = m68k_nvram_initialize,
+#endif
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+#endif /* CONFIG_NVRAM */

This would eliminate the conditional ops struct definitions in 
arch/m68k/atari/nvram.c and in arch/m68k/mac/misc.c, and still avoid stubs 
in single-platform kernels. OTOH, it does mean a single-platform kernel 
binary gets pointless wrapper functions.

Is this better than the original submission? 

> 
> If you handle this right, I think you can do without the temporary 
> "def_bool (ATARI && !MAC) || (MAC && !ATARI)" in "[RFC 22/24] m68k/mac: 
> Adopt nvram module", too.

It's moot.

-- 

> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
