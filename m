Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34DA9DE0A3
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 05:02:33 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m49J2OnY019940
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 12:02:25 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m49J2ODw029493
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 14:02:24 -0500 (CDT)
Date: Fri, 9 May 2008 14:02:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nick <ndroogh@rogers.com>
Subject: Re: MPC5200b external interrupt registration problem
Message-ID: <20080509190218.GA32008@ld0162-tx32.am.freescale.net>
References: <169407.5661.qm@web88102.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <169407.5661.qm@web88102.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 09, 2008 at 02:49:04PM -0400, Nick wrote:
> I am writing a driver to service an interrupt from our fpga.  I am calling request_irq in the open
> function of my driver.  The fpga is connected to external interrupt 1.  I am using interrupt
> number 65 in the request_irq but the function is failing.

request_irq takes a virtual IRQ number, not a hardware IRQ number.  You
need to get the virtual IRQ number from irq_of_parse_and_map(), or from
irq_create_mapping().

This would probably confuse far fewer people if we used pointers in the
API rather than virtual IRQ numbers...

-Scott
