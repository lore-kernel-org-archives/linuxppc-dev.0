Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 027F2DDE44
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 01:45:37 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070424112530.GA11489@aepfle.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b4976cbe7c1e829b9be1ae5bdb7b6219@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Tue, 24 Apr 2007 10:45:22 -0500
To: Olaf Hering <olaf@aepfle.de>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Apr 24 21:25:30 EST 2007, Olaf Hering wrote:
> Thats how it may look finally, currently only compile tested.
>
> int check_legacy_ioport(unsigned long base_port)
> {
>         struct device_node *parent, *np = NULL;
>         int ret = -ENODEV;
...

>         if (np) {
>                 parent = of_get_parent(np);
>                 if (parent) {
>                         ret = strcmp(parent->type, "isa");

This calculates the return as 0 / anything, vs 0 / -ENODEV.

>                         of_node_put(parent);
>                 }
>                 of_node_put(np);
>         }
>         return ret;
> }
