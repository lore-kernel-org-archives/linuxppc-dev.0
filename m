Date: Tue, 24 Feb 2004 08:53:53 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: song sam <samsongshzu@yahoo.com.cn>
Cc: Wolfgang Denk <wd@denx.de>,
	Xavier Miville <xmiville@oerlikon.ca>, v.sudeep@exgate.tek.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI daughter card with USB on a 405GP
Message-ID: <20040224085353.A13974@home.com>
References: <20040223170937.BB7C5C0655@atlas.denx.de> <20040224143841.64071.qmail@web15204.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040224143841.64071.qmail@web15204.mail.bjs.yahoo.com>; from samsongshzu@yahoo.com.cn on Tue, Feb 24, 2004 at 10:38:41PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 24, 2004 at 10:38:41PM +0800, song sam wrote:
>
> Hi,
>
> Wolfgang Denk wrote:
> > We tested a Adaptec AUA-200LP USB 2.0 card in some PPC sytems. It
> > worked fine when the devices were already connected at power-on or
> > at least when booting Linux, while hot-plug would reliably crash the
> > kernel. As far as I understand such behaviour is typical of some of
> > the alignment/cache bugs in the Linux kernel's USB code.
>
> I also met this USB problem on LITE_DW board when
> using USB keyboard and mouse.Has it solved or not?

I use the following hack locally to work around some of the 2.4 USB
stack DMA problems.

-Matt

===== arch/ppc/mm/cachemap.c 1.12 vs edited =====
--- 1.12/arch/ppc/mm/cachemap.c Tue Dec 10 18:09:59 2002
+++ edited/arch/ppc/mm/cachemap.c       Tue Dec 12 09:43:06 2002
@@ -152,7 +152,26 @@
        case PCI_DMA_NONE:
                BUG();
        case PCI_DMA_FROMDEVICE:        /* invalidate only */
+#if (defined(CONFIG_4xx) && (defined(CONFIG_USB)) || defined(CONFIG_USB_MODULE))
+               /*
+                * USB code does DMA off the stack, so when a driver
+                * uses the stock pci DMA routines, they end up calling
+                * invalidate_dcache_range().
+                * The cache invalidate code in the 405 port invalidates
+                * an entire cache line, regardless of what addresses are
+                * passed in - it 'rounds out' to the surrounding cache line.
+                * While other ports will notice if part of the cache line
+                * is NOT part of the range being invalidated and 'do
+                * the right thing', the 405 code will invalidate the
+                * entire line, potentially trashing the stack, causing a
+                * panic.
+                * Until all the USB drivers are fixed, we flush the data
+                * buffer, a much safer operation.
+                */
+               flush_dcache_range(start, end);
+#else
                invalidate_dcache_range(start, end);
+#endif
                break;
        case PCI_DMA_TODEVICE:          /* writeback only */
                clean_dcache_range(start, end);

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
