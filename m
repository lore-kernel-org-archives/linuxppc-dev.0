Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 81808DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Oct 2008 01:40:13 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1269459rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Oct 2008 07:40:12 -0700 (PDT)
Date: Sun, 19 Oct 2008 08:40:10 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: MPC5200: How to share GPIO and watchdog
Message-ID: <20081019144010.GB8086@secretlab.ca>
References: <200810151642.05145.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810151642.05145.jbe@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2008 at 04:42:04PM +0200, Juergen Beisert wrote:
> Hi list,
> 
> the timer0 on the MPC5200B contains one GPIO and a timer/watchdog.
> 
> If I'm using this node:
> 
> timer@600 {	/* General Purpose Timer */
>     compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>     cell-index = <0>;
>     reg = <0x600 0x10>;
>     interrupts = <0x1 0x9 0x0>;
>     interrupt-parent = <&mpc5200_pic>;
>    fsl,has-wdt;
> };
> 
> I will get watchdog support.
> 
> If I'm using this node:
> 
> timer@600 {	/* General Purpose Timer */
>     compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt","fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
>     cell-index = <0>;
>     reg = <0x600 0x10>;
>     interrupts = <0x1 0x9 0x0>;
>     interrupt-parent = <&mpc5200_pic>;
>     gpio-controller;
>     #gpio-cells = <2>;
>     fsl,has-wdt;
> };
> 
> I will get GPIO support, but no longer watchdog support (watchdogs probe
> function will never be called).
> 
> Is there a way to get both features supported?

I don't believe so.  In order to make this work you would need to merge
the two drivers into one I think (which probably isn't a bad idea).

g.
