Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A9E867C2F
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 22:02:00 +1100 (EST)
Subject: Re: [PATCH] drivers/ide: PATA driver	for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <htejun@gmail.com>
In-Reply-To: <4562CFD4.6040702@gmail.com>
References: <200611210959.kAL9x8eH026223@toshiba.co.jp>
	<4562CFD4.6040702@gmail.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 22:02:30 +1100
Message-Id: <1164106951.5597.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > We use a drivers/ide driver because its design is more suitable for
> > SCC IDE controller than libata driver. Since SCC supports only 32bit
> > read/write, we must override many callbacks of ata_port_operations
> > by modifying generic helpers. Each time the libata common code is
> > updated, we must update those modified helpers. It is very hard for us.
> > But we will try to implement the libata driver as needed.
> > 
> > This patch set is intended to be merged to 2.6.20.
> > If you have any comment, please write to me.
> 
> Care to post libata version (even if it's not complete)?  Let's work 
> something out.

The main problem is error handling / reset code.

With the current libata, basically, you can only override the whole
thing pretty much at the toplevel. The problem is with things like
ata_std_prereset, ata_std_softreset and ata_std_postreset and callees.

We can either comletely re-implement them but that seems fairly dodgy to
me, or find a way to add hooks. At the end of the day, all they need is:

 - write to the control register
 - read & write of nsect_addr & lbal_addr

I wonder how much of these could be replaced by either a hook, or
taskfile accessors (possibly with a special flag).

Cheers,
Ben.
