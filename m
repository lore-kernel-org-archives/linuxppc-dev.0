Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20B70B6F77
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 06:02:25 +1000 (EST)
Message-ID: <4DF7BE43.1010407@freescale.com>
Date: Tue, 14 Jun 2011 15:02:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Subject: Re: Mapping an executable page
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
In-Reply-To: <BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
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

Thomas De Schampheleire wrote:

> * However, if you jump to an address in that page, you'll have to make
> sure that the entire code that executes is mapped (make map_size large
> enough).

Well, that seems obvious.

> * When that range spanned multiple pages, I faced the issue of only
> one page being actually mapped in the TLBs. My assumption is that the
> call to __ioremap not necessarily updates the TLBs, but mainly some
> kernel-internal tables. The actual TLB mapping presumably happens when
> a data exception occurs.

Hmmm.... I find that surprising.  Memory allocated via ioremap() is supposed to
be available in interrupt handlers, where TLB mappings can't be created
on-the-fly.  I'm not sure that your observation is correct.

> * Therefore, to make sure that the mapping I intended with __ioremap()
> is actually reflected in the TLB tables, I added dummy reads of each
> page in the TLB, prior to jumping to the boot code, as follows:
>                 /* make sure memory is read, once every 4Kbyte is enough */
>                 for (p = vaddr; p < vaddr + map_size; p += 0x1000) {

You should at least use PAGE_SIZE instead of 0x1000.

>                         unsigned long dummy = *(volatile unsigned long *)p;
>                         (void)dummy;
>                 }
> 
> * After these changes (make sure all code is mapped + make sure to
> read all pages so that the TLBs are updated), my scenario works fine.

I still find it hard to believe that this is necessary.

-- 
Timur Tabi
Linux kernel developer at Freescale
