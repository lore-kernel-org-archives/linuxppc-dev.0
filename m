Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0702DE1A2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:38:06 +1000 (EST)
Message-ID: <4831F364.8020702@freescale.com>
Date: Mon, 19 May 2008 16:38:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
	<4831ECF0.5090101@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Scott Wood wrote:
>> Almost certainly the latter.  Is the disk interrupt shared with any
>> other interrupts, that are marked IRQF_NODELAY?  The -rt
>> patch doesn't seem to handle mixing the two well.
> 
> Disk is on a muxed PCI interrupt. None of the other interrupts on the
> mux is fireing at the time.

Regardless of whether they're firing, any request_irq with IRQF_NODELAY 
will turn off threading for all handlers.

> Is is possible that the demuxer is not set up right? It is based loosely
> on pq2-pci-pic.c

Try calling irq_set_chip_and_handler() with handle_level_irq, rather 
than irq_set_chip().  The -rt patch doesn't seem to have threadified the 
  __do_IRQ() path.

-Scott
