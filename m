Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 01605B6EF1
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 15:31:53 +1000 (EST)
Received: by gwj15 with SMTP id 15so5838374gwj.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 22:31:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100808074035.GA26199@oksana.dev.rtsoft.ru>
References: <1281187711-10215-1-git-send-email-agust@denx.de>
	<1281207816-31807-1-git-send-email-agust@denx.de>
	<AANLkTim7uCTYLTwj0Gqen3dAi9iNO7te8NCs6wWj7nSi@mail.gmail.com>
	<20100808074035.GA26199@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 8 Aug 2010 23:31:32 -0600
Message-ID: <AANLkTi=uLtpodbwbBXCriOSX2Y1x1wFPffRRazVwPG8w@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 8, 2010 at 1:40 AM, Anton Vorontsov <cbouatmailru@gmail.com> wr=
ote:
> On Sat, Aug 07, 2010 at 06:40:22PM -0600, Grant Likely wrote:
> [...]
>> > static int __init mpc8xxx_add_gpiochips(void)
>> > {
>> >+ =A0 =A0const struct of_device_id *id;
>> > =A0 =A0 struct device_node *np;
>> >
>> >- =A0 =A0for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio")
>> >- =A0 =A0 =A0 =A0 =A0 =A0mpc8xxx_add_controller(np);
>> >-
>> >- =A0 =A0for_each_compatible_node(np, NULL, "fsl,mpc8572-gpio")
>> >- =A0 =A0 =A0 =A0 =A0 =A0mpc8xxx_add_controller(np);
>> >-
>> >- =A0 =A0for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
>> >+ =A0 =A0for_each_matching_node(np, mpc8xxx_gpio_ids) {
>> >+ =A0 =A0 =A0 =A0 =A0 =A0id =3D of_match_node(mpc8xxx_gpio_ids, np);
>> >+ =A0 =A0 =A0 =A0 =A0 =A0if (id)
>> >+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0np->data =3D id->data;
>> > =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_add_controller(np);
>> >+ =A0 =A0}
> [...]
>> Actually, there is absolutely no reason to keep mpc8xxx_add_gpiochip()
>> as a separate function with the simplification of
>> mpc8xxx_add_gpiochips(). =A0I'd simplify the whole thing by merging the
>> two functions together.
>
> You mean mpc8xxx_add_controller()? Putting 65-line function
> on a second indentation level, inside the for loop... sounds
> like a bad idea.

That's a good point.  I was thinking about it from the wrong way
around (that the function could bail at the top on a non-match; which
obviously isn't the case).  Anatolij, I was wrong on this point.
Sorry I didn't reply sooner before you respun the patch.  :-(

g.
