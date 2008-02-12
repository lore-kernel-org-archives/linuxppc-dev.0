Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.240])
	by ozlabs.org (Postfix) with ESMTP id 927CADDF74
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 06:47:19 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so375847hsb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:47:18 -0800 (PST)
Message-ID: <fa686aa40802121147g2a639982oa13b39e770e3f940@mail.gmail.com>
Date: Tue, 12 Feb 2008 12:47:17 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jarno Manninen" <jarno.manninen@tut.fi>
Subject: Re: DTS question - MPC5200b
In-Reply-To: <200802122007.41259.jarno.manninen@tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B1D943.6020708@rogers.com>
	<200802122007.41259.jarno.manninen@tut.fi>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 11:07 AM, Jarno Manninen <jarno.manninen@tut.fi> wrote:
> On Tuesday 12 February 2008 19:37:07 Nick wrote:
>
> > How do I specify the timer based on the cell-index?
>
> I don't know if that is possible to do in a one call, but maybe using the
> approach from mpc52xx_uart might help?
>
> --clip--
>         for_each_node_by_type(np, "serial") {
>                 if (!of_match_node(mpc52xx_uart_of_match, np))
>                         continue;
>
>                 /* Is a particular device number requested? */
>                 devno = of_get_property(np, "port-number", NULL);
>                 mpc52xx_uart_of_assign(of_node_get(np), devno ? *devno : -1);
>         }
> --clip--

This code has actually changed in 2.6.25-rc1.  It is now
for_each_matching_node() and the call to of_match_node is no longer
necessary.

>
> And change  serial->gpt, port-number to cell-index and add some logic to
> select the devices you want.

use 'reg' instead.  cell-index (and port-number for that matter) will
probably be going away in the near future.

> Or if you wan't to do it a bit differently you
> could add a pseudo device outside the main tree like
>
>         mydev {
>                 gpt-dev = <&the_gpt_dev>:
>         };
>
> And get it that way. However I don't know if this is recommended approach, but
> I've used it for some simple stuff like binding gpt in PWM mode to
> framebuffer backlight, along with power-pin.

Yes, this is a good approach too.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
