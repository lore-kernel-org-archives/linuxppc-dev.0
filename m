Date: Tue, 8 Feb 2000 22:29:16 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] Retrace
Message-Id: <20000208222916.011600@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 8, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>	deviobase = ioport_ptr(dev->resource[0]);
>
>	data = inl(deviobase+register_offset);
>
>and for an MMIO mapped area:
>
>	mmioptr = ioremap(ioremap_ptr(dev->resource[1]));
>
>	data = readl(mmioptr+register_offset);

Is it possible to "walk up" the resource tree from dev->resource[0] ? I
mean, the ioport_ptr function, to work on those weird Apple bridges, need
to go thru a special routine that looks up the device in OF device tree
to find out on which sub-bridge it is.
In order to do that, it needs the pci dev_fn. Can this be retreived from
dev->resource[0] ?

Also, this doesn't solve the userland problem.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
