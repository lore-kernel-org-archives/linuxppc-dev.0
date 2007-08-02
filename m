Return-Path: <kimmo.surakka@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 7DFD9DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 19:17:33 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so501739wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 02 Aug 2007 02:17:30 -0700 (PDT)
Message-ID: <a44e83440708020217s2875932fo7b2d8a57af311912@mail.gmail.com>
Date: Thu, 2 Aug 2007 12:17:30 +0300
From: "Kimmo Surakka" <kusti@iki.fi>
Sender: kimmo.surakka@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: TQM5200 problems (kernel 2.4)
In-Reply-To: <a44e83440707052325q7114362chb85e6999f1e09da6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a44e83440707040751o4f2e195dte8c2edafd5f864c@mail.gmail.com>
	<20070705221327.92FB5353A91@atlas.denx.de>
	<a44e83440707052325q7114362chb85e6999f1e09da6@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I've continued my tests with the TQM5200. It appears that the
"Warning: kfree_skb on hard IRQ c008ecfc" errors are happening
because ppp_async_encode calls kfree_skb. I think this in itself is
not a problem, but when I googled for "ppp_async_encode hard IRQ", I found this:

http://search.luky.org/linux-kernel.2001/msg37792.html and
http://search.luky.org/linux-kernel.2001/msg41315.html

It seems that the serial driver should be split into top-half and bottom-half
interrupt handlers. If I read the code right, this is not done either in
the 2.4 kernel (arch/ppc/5xxx_io/psc.c) or in the 2.6 tree
(drivers/serial/mpc52xx_uart.c).

It this really correct, i.e. is the problem in the serial driver or should
I just replace the kfree_skb call in ppp_async_encode with
dev_kfree_skb_any()?


-- 
Kimmo Surakka <kusti@iki.fi>
http://www.iki.fi/kusti
