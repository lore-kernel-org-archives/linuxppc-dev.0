Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7EEFEB715F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 07:47:06 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7EDEDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 07:47:05 +1000 (EST)
Subject: Re: [PATCH -next] powerpc/85xx: Add support for X-ES MPC85xx boards
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <EF23D631-7B02-40C4-9635-61213F7DD117@kernel.crashing.org>
References: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
	<EF23D631-7B02-40C4-9635-61213F7DD117@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 16:46:59 -0500
Message-Id: <1244670419.29684.1600.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

Thanks for the feedback.  Response below:

> > +
> > +	root = of_find_node_by_path("/");
> > +	if (root == NULL)
> > +		return;
> > +
> > +	model = of_get_property(root, "model", NULL);
> > +	if (strncasecmp(model, "xes,", strlen("xes,")) != 0)
> > +		return;
> 
> What is this check for?

Historical accident.  A while back we somehow ended up with a case of
probe() succeeding when it shouldn't have, and this was the workaround.
I'll remove it since it's useless now.

> > +
> > +	printk(KERN_INFO "X-ES MPC85xx-based single-board computer: %s\n",
> > +	       model + strlen("xes,"));
> 
> Why not print the name from machine_id.name

Because machine_id->name will give us "X-ES MPC8572" from the machine
description rather than the actual board name (e.g., xpedite5370).

In our situation, we have several boards that share largely the same
hardware design.  I decided to just put 1 machine definition per
processor rather than having a machine definition for every board (which
would get pretty crazy for our case).  For example, we have at least 6
MPC8572-based boards with more on the way, but all of their changes can
be described in the device tree (e.g., changes in number of ethernet
ports or PCI express controllers), so there's no need for a machine
definition for all of them.

> > +machine_device_initcall(xes_mpc8572, xes_mpc85xx_publish_devices);
> > +machine_device_initcall(xes_mpc8548, xes_mpc85xx_publish_devices);
> 
> Do you not need this for xes_mpc8540?

Yes, thanks.  I'll fix this and the other things you mentioned and
re-submit.  Will this be able to make it into your next tree destined
for 2.6.31?

-- 
Nate Case <ncase@xes-inc.com>
