Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth04.prod.mesa1.secureserver.net
	(smtpauth04.prod.mesa1.secureserver.net [64.202.165.95])
	by ozlabs.org (Postfix) with SMTP id 52515DE7AC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 09:14:34 +1000 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1217383202.19379.linuxppc-embedded@ozlabs.org>
Subject: virt_to_phys() in drivers w/dma - MPC8xxx 
Date: Fri, 22 Aug 2008 16:14:28 -0700
Message-ID: <6FC450394F2147FDB7EC1D1EB168EB8B@absolutdaddy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1217383202.19379.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A style / function question. I have been seeing conflicting articles and
examples on what the proper method would be for some of the Freescale MPC
drivers. I am putting together an ATM driver, and 'might' be having some
erratic results due to this function. Not sure yet, but wanted to put this
out there for comments.

In many cases when dealing with TxBD or RxBD pointers a UCC or what not
driver will use the virt_to_phys() call to get what I assume is a physical
address that can be used for dma? Perhaps not in all cases, but a majority.
See ucc_geth.c for an example of the usage. I have also seen some prototype
drivers that use this call to get the physical address to place into the
QE_MURAM for the PRAM initialization.

I then ran across this link:

http://mirror.linux.org.au/linux.conf.au/2005/cdrom-beta-1/linux-mandocs-2.6
.12.6/virt_to_phys.html

Which states:

The returned physical address is the physical (CPU) mapping for the memory
address given. It is only valid to use this function on addresses directly
mapped or allocated via kmalloc.  This function does not give bus mappings
for DMA transfers. In almost all conceivable cases a device driver should
not be using this function.
-----------

So shouldn't we be using like dma_alloc_coherent, and then tracking the dma
address separately as a variable, and use it when necessary instead of
calling virt_to_phys()?

Or am I confused on what these are doing?

-Russ
