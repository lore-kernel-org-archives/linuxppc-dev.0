Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id C24A467C88
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 13:07:50 +1100 (EST)
Date: Fri, 10 Nov 2006 02:39:26 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Roman Zippel <zippel@linux-m68k.org>
Subject: Re: APUS and IOs question
In-Reply-To: <1163112519.4982.50.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0611100238050.28657@pademelon.sonytel.be>
References: <1162767333.28571.254.camel@localhost.localdomain>
	<454F5259.3020107@hogyros.de>  <454F5E44.4040301@genesi-usa.com>
	<1162844529.28571.327.camel@localhost.localdomain>
	<455081AC.3010301@hogyros.de>
	<1162931605.28571.491.camel@localhost.localdomain>
	<45533C79.70404@hogyros.de>
	<1163112519.4982.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 10 Nov 2006, Benjamin Herrenschmidt wrote:
> > My plan for moving APUS to arch/powerpc involves writing a new
> > bootloader (I'm currently hacking binutils to support AmigaOS binaries)
> > that builds a proper flattened device tree and calls the kernel, but I'm
> > not sure where the kernel virtual mapping that allows the kernel to run
> > from a fixed address should be set up -- if in the bootloader, the
> > kernel needs to be aware that changing the MMU settings will yield
> > interesting results, and if in the kernel, we need some platform
> > specific init code to handle that.
> 
> Well, the problem is that you basially have to hack the linear mapping,
> thus hitting anything that relies on __pa/__va or operating in real mode
> indeed.
> 
> How do you do for exception vectors ? Since those have to be either at 0
> or at ff* ? You stick branches at 0 to jump to where the kernel
> resides ?

IIRC (Roman please correct me if I'm wrong), APUS has them at ff* because the
memory at adress 0 is slower.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
