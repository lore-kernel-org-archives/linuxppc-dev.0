Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id C82DADDF37
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 10:43:43 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9068104agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 16:43:42 -0700 (PDT)
Message-ID: <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
Date: Mon, 17 Mar 2008 17:43:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <20080317222836.AFA66241A2@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 4:28 PM, Wolfgang Denk <wd@denx.de> wrote:
> In message <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com> you wrote:
>
>  * The TQM5200 configuration as provided is intended for  shipping  as
>   default  configuration  for  this board. The "engineer responsible"
>   already *did* the tailoring and put that  state  in  the  defconfig
>   file.
>
>  * The CM5200 and Motion-Pro boards are custom designs, where the
>   defconfig file matches exactly the requirements of the respective
>   customers.
>
>  I feel it is very important to be able to include this  configuration
>  information  somewhere  with  the  kernel source tree - and to me the
>  defconfig file for a board is the most  natural  place  to  put  such
>  information.

(copied from my comments in an off-list conversation)

However, I have declined (for now) to pick up the defconfigs for those
boards and instead merged in the config features they require into the
mpc5200 defconfig.  My primary reason for doing so is to increase the
likelyhood that full featured kernels are built and tested so that
situations where board ports conflict with each other are caught and
fixed.

ojn has also been complaining about the number of defconfigs he needs
to build to test all the powerpc configurations without any
indications about which ones are important and which ones are not.
There has been some discussion about having a subdirectory for
optimized board configs, but nobody has done anything about it yet.

The one part that I have a really strong opinion on is that there
should be a full featured mpc5200 defconfig for build testing.  Beyond
that (and if ojn can also be appeased) I can probably be convinced.  :-)

>  > All these boards are supported with
>  > arch/powerpc/platforms/mpc5200_simple.c.  A kernel built for that
>  > platform will boot on any of those boards as long as it is passed the
>  > correct device tree.
>
>  I don't doubt that the kernel will boot. But that does not mean  that
>  it   is  ready  for  use  for  the  intended  purpose.  For  example,
>  arch/powerpc/platforms/52xx/motionpro.c contains code to  setup  some
>  custom   LEDs   on   this   board.   I   can't   find  that  code  in
>
> arch/powerpc/platforms/mpc5200_simple.c.
>
>  It may be argued that this code should be moved somewhere else, but I
>  don't remeber to have seen any such review comments.

The LED code just hasn't been picked up.  IIRC, it was reworked to
make it a proper driver in drivers/leds.  I need to look at it again,
but it is a lot of code for a very simple thing and I wasn't sure if I
should be the one to pick it up because it is in drivers/leds which
has a different maintainer.

Cheers,
g.
-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
