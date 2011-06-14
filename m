Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA0F2B6F9B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 06:07:52 +1000 (EST)
Message-ID: <4DF7BF84.8030000@freescale.com>
Date: Tue, 14 Jun 2011 15:07:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Subject: Re: Mapping an executable page
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
	<4DF7BE43.1010407@freescale.com>
In-Reply-To: <4DF7BE43.1010407@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Hmmm.... I find that surprising.  Memory allocated via ioremap() is supposed to
> be available in interrupt handlers, where TLB mappings can't be created
> on-the-fly.  I'm not sure that your observation is correct.

Ok, it turns out I'm wrong.  As long as the page is in the page tables (i.e.
physically present in RAM), you can take a TLB miss in an interrupt handler, and
the TLB miss handler will create a TLB for you.

This means that ...

>                         unsigned long dummy = *(volatile unsigned long *)p;
>                         (void)dummy;
>                 }
> 
> * After these changes (make sure all code is mapped + make sure to
> read all pages so that the TLBs are updated), my scenario works fine.

is not going to work reliably, because it assumes that the TLBs created by your
multiple ioremap() calls will still be there when your code is called.

If you use just a single ioremap() call, but still touch every page, that should
work for you just as well.

-- 
Timur Tabi
Linux kernel developer at Freescale
