Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id D647A67EB8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 04:16:39 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so831380wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Aug 2005 11:16:38 -0700 (PDT)
Message-ID: <c3d0340b05081411164dcc694e@mail.gmail.com>
Date: Sun, 14 Aug 2005 11:16:38 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Shawn Jin <shawnxjin@gmail.com>, ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050814042556.GB23952@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
	<20050812203335.K30033@cox.net>
	<c3d0340b0508132056651e8c97@mail.gmail.com>
	<20050814042556.GB23952@gate.ebshome.net>
Subject: Re: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > The problem is that read*()/write*() are misused in some places, e.g.,
> > serial drivers such as serial8250. The serial_in() and serial_out()
> > call read*() and write*() respectively. So what's your recommendation
> > in such a case?
>=20
> Why do you think this is a problem? Why do you think they are
> misused? Please explain.

IMHO, serial_in() and serial_out() should be able to handle all the
possilbilities. But the current implementation cannot achieve this by
simply calling read*() and write*() in the case that UART control
registers are 32-bit or 16-bit wide and can only be acessed in 32/16
bits in some big endian systems. As Matt pointed out before, read*()
and write*() are designed for PCI access only.

Regards,
-Shawn.
