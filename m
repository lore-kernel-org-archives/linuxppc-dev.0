Return-Path: <avorontsov@ru.mvista.com>
Date: Wed, 4 Jun 2008 15:58:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] [NAND] driver extension to support NAND on TQM85xx modules
Message-ID: <20080604115819.GA2281@polina.dev.rtsoft.ru>
References: <1212129392-27589-1-git-send-email-wg@grandegger.com>
	<20080530125057.GB13407@polina.dev.rtsoft.ru>
	<484665EC.30001@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <484665EC.30001@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, 2008 at 11:52:44AM +0200, Wolfgang Grandegger wrote:
> Hi Anton,
> 
> Anton Vorontsov wrote:
> > On Fri, May 30, 2008 at 08:36:32AM +0200, Wolfgang Grandegger wrote:
> >> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
> >> support for the TQM85xx modules. Unfortunately, the hardware does
> >> not support the R/B pins of the NAND chip and therefore the specified
> >> maximum delay time must used. It therefore re-introduces the chip-delay
> >> property.
> >>
> >> Note: this patch is based on a patch Anton Vorontsov posted to this list:
> >>       See http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
> >>       It should show up mainstream soon. 
> > 
> > Personally, I like this patch. But OF people should approve "chip-delay"
> > property. Though, the whole UPM NAND bindings are in the air still.
> > 
> >> --- a/include/linux/of_gpio.h
> >> +++ b/include/linux/of_gpio.h
> >> @@ -15,7 +15,7 @@
> >>  #define __LINUX_OF_GPIO_H
> >>  
> >>  #include <linux/errno.h>
> >> -#include <asm/gpio.h>
> >> +#include <linux/gpio.h>
> > 
> > This should be done separately.
> 
> I have a technical question. 

> Do you understand

Nope. According to NAND specs (Samsung and HYNIX), NAND should not
assert "busy" when we're sending seq data. We should poll the R/B pin
only after final "programm command".

But I saw a chip that was asserting it in seqinput phase anyway, and not
polling R/B did cause write errors. I can't recall if it was Samsung or
HYNIX chip, surely not ST Micro though.

> why the Linux NAND FSL UPM 
> driver needs polling the R/B pin when writing out a sequence of bytes:
> 
> static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
> {
> 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
> 	int i;
> 
> 	for (i = 0; i < len; i++) {
> 		out_8(fun->chip.IO_ADDR_W, buf[i]);
> 		fun_wait_rnb(fun);
> 	}
> }
> 
> We do not need that in the corresponding U-Boot driver. 

This is probably because I "optimized" the driver without further
testing it on other NAND chips.

> On my board (not 
> having the R/B pin connected) I need a small delay of approx. 100 ns
> instead to get it working properly.

This proves that we indeed need some R/B waiting (or delays in case of
no R/B pin) in the write_buf.

p.s. Other possibility though is that MTD subsystem issues some
commands inbetween seqinput, for example, "read status" command is
permitted, but NAND should not assert R/B pin for this command anyway.
:-/

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
