Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 8EDBCB6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 03:55:39 +1000 (EST)
Received: by pwj1 with SMTP id 1so196791pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Sep 2010 10:55:38 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 8 Sep 2010 11:55:36 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH v2] powerpc/5200: tighten up ac97 reset timing
Message-ID: <20100908175536.GP3686@angua.secretlab.ca>
References: <1283534858-17951-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283534858-17951-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 03, 2010 at 01:27:38PM -0400, Eric Millbrandt wrote:
> Tighten up time timing around the gpio reset functionality.  Add a 200ns
> delay before remuxing the pins back to ac97 to comply with the ac97 spec.
> 
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
> 
> Scope shots availible upon request
> 
> changes since v1
> - amended with comments from Wolfram Sang
> 
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Applied, but the patch was mangled (tabs->spaces) and I had to fix it
up by hand.  You'll need to find a way to get out from under your
corporate email manging server.

g.

> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> index 6e90531..41f3a7e 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -325,12 +325,16 @@ int mpc5200_psc_ac97_gpio_reset(int psc_number)
>         clrbits32(&simple_gpio->simple_dvo, sync | out);
>         clrbits8(&wkup_gpio->wkup_dvo, reset);
> 
> -       /* wait at lease 1 us */
> -       udelay(2);
> +       /* wait for 1 us */
> +       udelay(1);
> 
>         /* Deassert reset */
>         setbits8(&wkup_gpio->wkup_dvo, reset);
> 
> +       /* wait at least 200ns */
> +       /* 7 ~= (200ns * timebase) / ns2sec */
> +       __delay(7);
> +
>         /* Restore pin-muxing */
>         out_be32(&simple_gpio->port_config, mux);
> 
> --
> 1.6.3.1
> 
> -DISCLAIMER: an automatically appended disclaimer may follow. By posting-
> -to a public e-mail mailing list I hereby grant permission to distribute-
> -and copy this message.-
> 
> This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.
> 
> Thank you.
> 
> Please consider the environment before printing this email.
