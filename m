Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id EF419DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 11:51:58 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1177377anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 18:51:57 -0700 (PDT)
Message-ID: <fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
Date: Sun, 27 Apr 2008 19:51:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080428105859.daef4d71.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 27, 2008 at 6:58 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Sean,
>
>
>  On Sun, 27 Apr 2008 15:25:46 -0400 Sean MacLennan <smaclennan@pikatech.com> wrote:
>  >
>  > +++ b/arch/powerpc/platforms/44x/warp-nand.c
>  > @@ -11,8 +11,10 @@
>  >  #include <linux/mtd/partitions.h>
>  >  #include <linux/mtd/nand.h>
>  >  #include <linux/mtd/ndfc.h>
>  > +#include <linux/of_platform.h>
>
>  You really want linux.of.h (unless there was some preexisting reason to
>  require of_platform.h).
>
>
>  > +static void pika_setup_critical_temp(struct i2c_client *client)
>  > +{
>  > +     struct device_node *np;
>  > +     int irq, rc;
>  > +
>  > +     /* Setup power LEDS for possible critical temp */
>  > +     np = of_find_compatible_node(NULL, NULL, "ibm,gpio-440EP");
>  > +     if (np)
>  > +             np = of_find_compatible_node(np, NULL, "ibm,gpio-440EP");
>
>  Did you really mean to test if (!np) above instead?

Actually, it looks like he's trying to find the second gpio node in the tree.

Sean, if that is true, then this is a very fragile way to do it.
Really, you should have a phandle somewhere that points to the GPIO
node that your LEDs are attached to.  Others have been addressing the
same problem and the consensus seems to be to add a 'leds' node for
each of your leds with a phandle and gpio descriptor to the gpio node.

See the documentation added by this patch (section 't'):
http://patchwork.ozlabs.org/linuxppc/patch?id=18156

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
