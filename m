Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id B7C0CDDE98
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 02:34:39 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so106276anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 07 May 2008 09:34:38 -0700 (PDT)
Message-ID: <fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
Date: Wed, 7 May 2008 10:34:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Fabio Tosetto" <tosettofabio83@libero.it>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <4821A551.3060205@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it>
	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
	<4821A551.3060205@libero.it>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 7, 2008 at 6:49 AM, Fabio Tosetto <tosettofabio83@libero.it> wrote:
>
>  I've tried to port my exesting configurations to the powerpc tree but some
> configurations files are missing.

First, create a new .dts file for your board in arch/powerpc/boot/dts.
(just copy the lite5200.dts file).  Modify the .dts to have your
board's name (in the form "<vendor>,<boardname>") in the compatible
and model properties.

Next, add your boards name to the list of boards in
arch/powerpc/platforms/52xx/mpc5200_simple.c.

>  I need to set PSC3 - PSC4 in uart mode:
>  before in file *arch/ppc/platforms/lite5200.c* I added
>
>  struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
>          {       .id     = 3,
>                  .func   = "uart",
>          },
>          {       .id     = 4,
>                  .func   = "uart",
>          },
>          {       .id     = -1,   /* End entry */
>                  .func   = NULL,
>          }
>  };

Edit your boards .dts file and uncomment PSCs 3 and 4.  Comment out
PSC1 if you aren't using it.

>  I need to set PSC4 as a low level debug: *
>  *before in file  *arch/ppc/platforms/lite5200.h *I added
>
>  #define MPC52xx_PF_CONSOLE_PORT 4    /* PSC4 */

I don't think we have any early debug enabled yet in arch/powerpc for
the mpc5200.

>  Finally I need to set  the virtual memory translation on a range of 128 MB:
>  before in file *arch/ppc/kernel/head.S *I added
>
>  /*ori    r11,r11,BL_128M<<2|0x2    set up BAT registers for 604 */
>
>  ori    r11,r11,BL_128M<<2|0x2    /* set up BAT registers for 604 */
>
>  could you please explain me how to do the same operations in powerpc tree??

New file is arch/powerpc/kernel/head_32.S.  I don't think that is the
cleanest way to do it though.  Why do you need to change the BAT
mapping from 256 to 128?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
