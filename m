Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79328DDF40
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 10:02:37 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6U02SJv019927
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jul 2008 20:02:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6U02S1p211120
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jul 2008 20:02:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6U02S5m014054
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jul 2008 20:02:28 -0400
Date: Tue, 29 Jul 2008 20:02:25 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Henry Bausley" <hbausley@deltatau.com>
Subject: Re: Writing to CPLD mapped to EBC Port of AMCC440EP
Message-ID: <20080729200225.57634f94@zod.rchland.ibm.com>
In-Reply-To: <23b401c8f10b$54ecf9d0$0109220a@deltatau.local>
References: <23b401c8f10b$54ecf9d0$0109220a@deltatau.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 16:40:35 -0700
"Henry Bausley" <hbausley@deltatau.com> wrote:

> 
> I am attempting to write to a CPLD mapped to the EBC port of a AMCC 440EP.  When I attempt to write using an unsigned variable
> ie. unsigned *pbase = (unsigned char *)ioremap64(0x8F000000,0x1000000);
> I get a kernel access of bad area, sig: 11 fault.  However, if I change to an unsigned char ie. unsigned char *pbase = (unsigned char *)ioremap64(0x8F000000,
> 0x1000000); The system doesn't crash.  I need to write using an unsigned.  Does any one have any ideas what I am doing wrong?

The documentation I have for the Bamboo board says the EPLD is at
address 0x80002000 and is only 8 bytes in size.  Similarly, the
Yosemite board CPLD is at 0x80002000 and is only 16 bytes in size.  Why
you are ioremapping 16MiB at 0x8F000000 I have no idea.

Also, the individual registers of the EPLD/CPLD on both boards are only
8 bits, so an unsigned char seems appropriate.  If you have a custom
board that does something totally different from how the eval boards
are set up, then I'm not sure many people will be able to help you
without documentation for that board.

josh
