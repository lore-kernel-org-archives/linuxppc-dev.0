Return-Path: <tnt@246tNt.com>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B59967C7C
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 12:45:33 +1100 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA51jPbP031650
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Nov 2006 02:45:26 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <454D422B.8030003@246tNt.com>
Date: Sun, 05 Nov 2006 02:45:15 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc/powerpc: Fix io.h for config with CONFIG_PCI not set
References: <11626858382465-git-send-email-tnt@246tNt.com>
	<1162689134.28571.120.camel@localhost.localdomain>
In-Reply-To: <1162689134.28571.120.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
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

Benjamin Herrenschmidt wrote:
> On Sun, 2006-11-05 at 01:17 +0100, Sylvain Munaut wrote:
>   
>> When CONFIG_PCI option is not set, the variables
>> pci_dram_offset, isa_io_base and isa_mem_base are not defined.
>>
>> Currently, the test is handled in each platform header. This
>> patch moves the test in io.h once and for all.
>>     
>
> Be careful with _IO_BASE... I'm not 100% sure some platforms don't need
> it set to something else even when PCI is not present.
>   
When I saw in  mpc83xx.h and  mpc85xx.h that they still defined them, I
wondered.
But when looking at the code :
    unsigned long isa_io_base     = 0;
    unsigned long isa_mem_base    = 0;
are both defined in pci_{32/64}.c and won't be included if CONFIG_PCI is
not set.


    Sylvain
