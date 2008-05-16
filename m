Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 387F5DDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 07:42:37 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so409217wag.13
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 14:42:35 -0700 (PDT)
Message-ID: <9e4733910805161442s7c457a6ekc8236d947613a386@mail.gmail.com>
Date: Fri, 16 May 2008 17:42:35 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 0/4] Describe SPI devices in the OF device tree and
	add mpc5200-spi driver
In-Reply-To: <fa686aa40805161432w6b5243f9nb0d0c32a87d86d02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<9e4733910805161327u4c42fd1dg5b09319d89db447c@mail.gmail.com>
	<fa686aa40805161348t52b94956w112ef6926ff30892@mail.gmail.com>
	<9e4733910805161425i2d6cc034y3377af053a4198b5@mail.gmail.com>
	<fa686aa40805161432w6b5243f9nb0d0c32a87d86d02@mail.gmail.com>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, May 16, 2008 at 3:25 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > On 5/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >> On Fri, May 16, 2008 at 2:27 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  >>  > On 5/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >>  >> This series is a set of changes to allow the slaves on an SPI bus to be
>  >>  >>  described in the OF device tree (useful in arch/powerpc) and adds a driver
>  >>  >>  that uses it (the Freescale MPC5200 SoC's SPI device).
>  >>  >
>  >>  > Right now we have SPI hooked up to PSC3. Hardware engineer is gone but
>  >>  > I'll see if I can get him to alter things to use the SPI controller. I
>  >>  > have an old mail from him where he thinks the Phytec board is missing
>  >>  > a signal needed to use the SPI controller.
>  >>
>  >>
>  >> While I'd appreciate the testing, I suspect that you really don't want
>  >>  to do that.  The dedicated SPI controller isn't very good.  It only
>  >>  does a byte at a time and so is rather slow.  A PSC is SPI mode should
>  >>  be better (but I haven't tried it personally it yet).
>  >
>  > What is the device tree node for PSC3 supposed to look like when it
>  > has both serial and spi enabled?
>
>
> The *PSC3 device* cannot support both serial and SPI at the same time.
>   Only one mode works at a time...
>
>  However, *PSC3 pin group* has can be configured to route both the
>  *PSC3 device* and the *SPI device* signal out to the board at the same
>  time.

I need to talk to my hardware guy.  He is using PSC3 for the boot
console with the assumption that once booted it is ok to retask it to
SPI. Serial console is only needed for software debugging.  SSH works
after boot and can replace the serial console.

I'll trying changing my device tree entry from UART to SPI and boot.
Hopefully I'll see the console until the SPI driver loads.

>
>  Pin routing is not something that is described by the device tree.
>  It's viewed as a board level initialization thing, similar to how DDR
>  RAM initialization is viewed.  Ideally, the bootloader will write the
>  correct value into port_config for pin routing and Linux will never
>  need to touch it.  If the bootloader cannot be changed, then
>  board-specific platform code can be added to fixup the port_config
>  setting.  However, the drivers should never touch or care about pin
>  routing.
>
>
>  Cheers,
>  g.
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl@gmail.com
