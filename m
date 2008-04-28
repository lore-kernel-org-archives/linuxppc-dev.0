Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 84D31DE282
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 03:44:21 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1255026anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:44:19 -0700 (PDT)
Message-ID: <fa686aa40804281044p5fa0ef9s15107cc38fafc9fa@mail.gmail.com>
Date: Mon, 28 Apr 2008 11:44:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080428131001.052be010@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
	<fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
	<20080427222514.1086f2d3@lappy.seanm.ca>
	<fa686aa40804272147y54df795fj7e8dad89dc237ecd@mail.gmail.com>
	<20080428131001.052be010@lappy.seanm.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, rpurdie@rpsys.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 11:10 AM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> On Sun, 27 Apr 2008 22:47:43 -0600
>
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>
> > If your LEDs are attached to gpio pins, then you should use the
>  > current draft led->gpio bindings as shown in the above patch.  Then,
>  > let your platform code extract whatever data it needs from the device
>  > tree to set up the LEDs.
>
>  I added the following to the dts:
>
>         led@31 {
>                 compatible = "linux,gpio-led";
>                 linux,name = "green";
>                 gpios = <&GPIO1 31>;
>         };
>
>         led@30 {
>                 compatible = "linux,gpio-led";
>                 linux,name = "red";
>                 gpios = <&GPIO1 30>;
>         };

This looks appropriate.  You'll need to make sure that the values in
the linux,name property meet the Linux LED naming guidelines.  I think
this is covered in Documentation/leds-class.c.  You can also as
Richard Purdie; the LED subsystem maintainer.

>  I then map the gpio base as follows (I removed the if checks just to
>  make things short and sweet):
>
>         np = of_find_compatible_node(NULL, NULL, "linux,gpio-led");
>
>         gpios = of_get_property(np, "gpios", &lenp);
>         of_node_put(np);
>
>         np = of_find_node_by_phandle(gpios[0]);
>
>
>         gpio_base = of_iomap(np, 0);
>         of_node_put(np);

This isn't ideal, but it will do to start.  However, if other devices
want to use the same GPIO block, then you'll probably have problems
with race conditions.  Eventually, you'll want to use the common GPIO
infrastructure and remove the custom code.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
