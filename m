Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 17C1467D57
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 07:50:06 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1603434ugc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 01 Nov 2006 12:50:04 -0800 (PST)
Message-ID: <528646bc0611011250h6ce7d29al494ff94f891b0b07@mail.gmail.com>
Date: Wed, 1 Nov 2006 13:50:03 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH] [POWERPC] Move mpc52xx-psc uart driver to of_device from
	platform_device
In-Reply-To: <4549056C.6080503@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
	<11623704061869-git-send-email-grant.likely@secretlab.ca>
	<11623704063907-git-send-email-grant.likely@secretlab.ca>
	<11623704071131-git-send-email-grant.likely@secretlab.ca>
	<1162370407105-git-send-email-grant.likely@secretlab.ca>
	<11623704073308-git-send-email-grant.likely@secretlab.ca>
	<4549056C.6080503@bplan-gmbh.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/1/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> Grant Likely wrote:
> > As part of the transition to arch/powerpc, this patch moves the mpc5200 PSC
> > driver over to the OF platform bus infrastructure.
> >
> > This patch is not acceptable for mainline as-is because it breaks arch/ppc
> > support for the mpc52xx.  More rework is needed to allow it to compile for
> > either arch (or alternately, fork the driver)
> >
>
> It has been hard to apply on 2.6.19-rc4 but it seems to perform well.
> I add to add some entries in mpc52xx_uart_match[]

Good news, thanks for the feedback. I take it you are able to use the
serial port with this driver?

>
> In now looks like this:
> static struct of_device_id mpc52xx_uart_match[] = {
>         {
>                 .name = "serial",
>                 .compatible = "mpc52xx-psc",
>         },
>         {
>                 .name = "serial",
>                 .compatible = "mpc52xx-serial",
>         },
>         {
>                 .name = "serial",
>                 .compatible = "mpc5200-psc",
>         },
>         {
>                 .name = "serial",
>                 .compatible = "mpc5200-serial",
>         },
>         {},
> };

I'd rather not do this for the mainline code.  I'd rather define a
naming convention and all of us use it.  We're early enough in this
process that we can do that since there are only two major boards
(lite5200 & Efika) on track to be supported in mainline ATM.

Having 4 compatibility blocks to support 2 boards is over-engineering.  :)

>
> By the way, why not using mpc52xx_uart_match[] to also in
> mpc52xx_console_setup() to track down any devices?

Because I hadn't thought of that, and therefore have not decided if
that's a good idea!  :)  I'll take a look.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
