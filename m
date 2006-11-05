Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D40D567C56
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 12:12:24 +1100 (EST)
Subject: Re: [PATCH] ppc/powerpc: Fix io.h for config with CONFIG_PCI not set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <11626858382465-git-send-email-tnt@246tNt.com>
References: <11626858382465-git-send-email-tnt@246tNt.com>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 12:12:14 +1100
Message-Id: <1162689134.28571.120.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ML PPC Embedded <linuxppc-embedded@ozlabs.org>, Sven <sl@bplan-gmbh.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-05 at 01:17 +0100, Sylvain Munaut wrote:
> When CONFIG_PCI option is not set, the variables
> pci_dram_offset, isa_io_base and isa_mem_base are not defined.
> 
> Currently, the test is handled in each platform header. This
> patch moves the test in io.h once and for all.

Be careful with _IO_BASE... I'm not 100% sure some platforms don't need
it set to something else even when PCI is not present.

Ben.
