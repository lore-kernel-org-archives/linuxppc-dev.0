Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8A51067A30
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 23:36:20 +1100 (EST)
Date: Fri, 21 Jan 2005 13:36:14 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Jerome Glisse <j.glisse@gmail.com>
In-Reply-To: <4240b916050121032230b9c5dc@mail.gmail.com>
Message-ID: <Pine.GSO.4.61.0501211335450.1075@waterleaf.sonytel.be>
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
	<4240b9160501101014317b8d85@mail.gmail.com>
	<20050110182940.GA3391@smtp.west.cox.net>
	<4240b91605011010593d2f3b3d@mail.gmail.com>
	<20050110191248.GB3391@smtp.west.cox.net>
	<4240b91605011011314bb06814@mail.gmail.com>
	<4240b91605011211101ed322a8@mail.gmail.com>
	<20050120231442.GE2626@smtp.west.cox.net>
	<4240b916050121032230b9c5dc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Tom Rini <trini@kernel.crashing.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Jan 2005, Jerome Glisse wrote:
> On Thu, 20 Jan 2005 16:14:42 -0700, Tom Rini <trini@kernel.crashing.org> wrote:
> > On Wed, Jan 12, 2005 at 08:10:58PM +0100, Jerome Glisse wrote:
> > 
> > > Wanted to know what is going on with CONFIG_6xx?  You will use
> > > my patch or do you have another better way ? :)
> > 
> > Can you resend it please?
> > 
> 
> Here is another version (the previous one used ifdef to comment
> out function call but i read somewhere that this doesn't follow
> codeguideline). Anyway i think that my patch is a ugly hack.
> 
> Signed-off-by: Jerome Glisse <j.glisse@gmail.com>
> 
> best,
> Jerome Glisse
> 
> 
> 
> diff -Naur linux/arch/ppc/boot/simple/misc-prep.c
> linux-2.6.10/arch/ppc/boot/simple/misc-prep.c
> --- linux/arch/ppc/boot/simple/misc-prep.c	2004-12-24 22:33:51.000000000 +0100
> +++ linux-2.6.10/arch/ppc/boot/simple/misc-prep.c	2005-01-21
> 12:09:50.976426672 +0100
> @@ -34,7 +34,11 @@
>  extern void serial_fixups(void);
>  extern struct bi_record *decompress_kernel(unsigned long load_addr,
>  		int num_words, unsigned long cksum);
> +#ifdef CONFIG_6XX
>  extern void disable_6xx_mmu(void);
> +#elif
> +void disable_6xx_mmu(void) {}
   ^^^^^^^^^^^^^^^^^^^^
You better make this one static inline.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
