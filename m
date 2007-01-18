Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6314DDDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 18:53:56 +1100 (EST)
Date: Thu, 18 Jan 2007 16:53:48 +0900 (JST)
Message-Id: <200701180753.l0I7rn3i000973@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 17/19] powerpc: hypervisor console driver for Celleb
In-Reply-To: <1169080804.4965.31.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

> > +/* temp */
> > +static int hvc_beat_init(void)
> > +{
> > +	struct hvc_struct *hp;
> > +
> > +	hp = hvc_alloc(0, NO_IRQ, &hvc_beat_get_put_ops, 16);
> > +	if (IS_ERR(hp))
> > +	   return PTR_ERR(hp);
> > +	   hvc_beat_dev = hp;
> > +	   return 0;
> > +}

> Please test your are running on beat before initializing your stuff as
> your driver might be built as part of a kernel that can boot other
> machines. 

I see. I'll fix it by using "firmware_has_feature()" macro.

Best regards,
Kou Ishizaki
