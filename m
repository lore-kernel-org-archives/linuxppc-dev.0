Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 3A04667B57
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Jun 2005 02:20:04 +1000 (EST)
Message-ID: <42BC34CE.603@ru.mvista.com>
Date: Fri, 24 Jun 2005 20:29:02 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <42BAD78E.1020801@ru.mvista.com>
	<20050623140522.GA25724@logos.cnet>
	<42BC2501.5090101@ru.mvista.com>
	<20050624154311.GB3628@smtp.west.cox.net>
In-Reply-To: <20050624154311.GB3628@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, yshpilevsky@ru.mvista.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:
> On Fri, Jun 24, 2005 at 07:21:37PM +0400, Andrei Konovalov wrote:
> 
>>Hi Marcelo,
>>
>>Marcelo Tosatti wrote:
>>
>>>Hi Andrei,
>>>
>>>On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
>>><snip>
>>>
>>>>diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
>>>>--- a/arch/ppc/syslib/m8xx_setup.c
>>>>+++ b/arch/ppc/syslib/m8xx_setup.c
>>>>@@ -369,7 +369,7 @@ m8xx_map_io(void)
>>>>#if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || 
>>>>defined(CONFIG_FB_RPX)
>>>>	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, 
>>>>	_PAGE_IO);
>>>>#endif
>>>>-#ifdef CONFIG_FADS
>>>>+#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
>>>>	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
>>>>#endif
>>>>#ifdef CONFIG_PCI
>>>
>>>
>>>I suppose you also want to include CONFIG_MPC885ADS in the 
>>>io_block_mapping(IO_BASE) here?
>>
>>No, not at the moment at least.
>>Actually, the patch doesn't even #define IO_BASE.
>>In 2.4 that io_block_mapping(IO_BASE) was needed for PCMCIA / CF cards to 
>>work.
>>We haven't got to PCMCIA support in 2.6 yet, and PCMCIA is unlikely to work
>>as is in case of MPC885ADS, as drivers/pcmcia/m8xx_pcmcia.c is just missing.
>>We plan to address PCMCIA later.
> 
> 
> Lets just drop that hunk then..
> 

Do you mean not to use
   io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
?

Thanks,
Andrei
