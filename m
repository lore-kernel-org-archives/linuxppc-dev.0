Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 680F2B6EDD
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Aug 2010 17:40:41 +1000 (EST)
Received: by bwz17 with SMTP id 17so1186697bwz.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 00:40:39 -0700 (PDT)
Date: Sun, 8 Aug 2010 11:40:35 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] powerpc/mpc8xxx_gpio.c: extend the driver to
	support mpc512x gpios
Message-ID: <20100808074035.GA26199@oksana.dev.rtsoft.ru>
References: <1281187711-10215-1-git-send-email-agust@denx.de>
	<1281207816-31807-1-git-send-email-agust@denx.de>
	<AANLkTim7uCTYLTwj0Gqen3dAi9iNO7te8NCs6wWj7nSi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTim7uCTYLTwj0Gqen3dAi9iNO7te8NCs6wWj7nSi@mail.gmail.com>
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

On Sat, Aug 07, 2010 at 06:40:22PM -0600, Grant Likely wrote:
[...]
> > static int __init mpc8xxx_add_gpiochips(void)
> > {
> >+	const struct of_device_id *id;
> > 	struct device_node *np;
> >
> >-	for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio")
> >-		mpc8xxx_add_controller(np);
> >-
> >-	for_each_compatible_node(np, NULL, "fsl,mpc8572-gpio")
> >-		mpc8xxx_add_controller(np);
> >-
> >-	for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
> >+	for_each_matching_node(np, mpc8xxx_gpio_ids) {
> >+		id = of_match_node(mpc8xxx_gpio_ids, np);
> >+		if (id)
> >+			np->data = id->data;
> > 		mpc8xxx_add_controller(np);
> >+	}
[...]
> Actually, there is absolutely no reason to keep mpc8xxx_add_gpiochip()
> as a separate function with the simplification of
> mpc8xxx_add_gpiochips().  I'd simplify the whole thing by merging the
> two functions together.

You mean mpc8xxx_add_controller()? Putting 65-line function
on a second indentation level, inside the for loop... sounds
like a bad idea.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
