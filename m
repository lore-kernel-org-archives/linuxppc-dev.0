Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 0CBE6DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 17:08:48 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1IJ28P-0004Ou-WF
	for linuxppc-embedded@ozlabs.org; Thu, 09 Aug 2007 09:08:42 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Cypress C67X00 driver question
References: <939D37AEB47F1F49B88FAB6599B6023501A17257@hsv1dafpew02.das.gov.sanm.corp>
Date: Thu, 09 Aug 2007 09:08:41 +0200
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17257@hsv1dafpew02.das.gov.sanm.corp>
	(Joseph M. Robertson's message of "Wed, 8 Aug 2007 15:34:45 -0500")
Message-ID: <87lkclw5fq.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "RJM" == Robertson, Joseph M <joseph.robertson@sanmina-sci.com> writes:

Hi,

RJM> Hi all, First off big thanks to the guys working on the Cypress
RJM> USB C67X00 driver!  Without them I would not even be this far.

You're welcome.

RJM> But my question for them is: How are you guys initializing the
RJM> Cypress chip?  It looks like the driver is expecting the cypress
RJM> to be programmed and ready.

No, you don't need to program anything. The driver only uses he
Cypress BIOS programmed in ROM in the chip.

You just need to register a struct platform_device in your board code
with the base address, IRQ and port configuration - Something like:

#include <linux/usb/c67x00.h

..

static struct resource c67x00_resources[] = {
        [0] = {
                .start  = 0x84000000,
                .end    = 0x8400000f,
                .flags  = IORESOURCE_MEM,
        },
        [1] = {
                .start  = 3,
                .end    = 3,
                .flags  = IORESOURCE_IRQ,
        },
};

static struct c67x00_platform_data c67x00_data = {
        .sie_config             = C67X00_SIE1_HOST | C67X00_SIE2_HOST,
        .hpi_regstep            = 0x02,
};

static struct platform_device c67x00 = {
        .name                   = "c67x00",
        .id                     = 0,
        .num_resources          = ARRAY_SIZE(c67x00_resources),
        .resource               = c67x00_resources,
        .dev.platform_data      = &c67x00_data,
};

-- 
Bye, Peter Korsgaard
