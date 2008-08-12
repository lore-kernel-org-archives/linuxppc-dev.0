Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 19D6FDE5AF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 00:18:52 +1000 (EST)
Message-ID: <48A19BC2.8060008@ru.mvista.com>
Date: Tue, 12 Aug 2008 18:18:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <48A05152.7020508@harris.com>	<20080811151913.GA14690@oksana.dev.rtsoft.ru>	<48A0676E.5020308@harris.com>	<20080811170756.GA29827@oksana.dev.rtsoft.ru>	<1218492032.8041.11.camel@pasglop>
	<48A19788.6050502@harris.com>
	<20080812140457.GA9103@oksana.dev.rtsoft.ru>
In-Reply-To: <20080812140457.GA9103@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks,
	Sam" <SSparks@aclaratech.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>>>>1. IDE status read does not work. (But am I understand correctly
>>>>   that IDE works well if IRQ is unspecified? Then this is hardly
>>>>   an issue.)
>>>>2. IDE interrupt comes when it should not. I'd recommend to use
>>>>   oscilloscope to find out what is happening there, that is, if
>>>>   the drive actually deasserts its irq line after status read.
>>>>   If so, than this could be a PIC problem.

>>>>What is the platform on which you're observing the issue, btw?

>>>Another possibility is that you got the wrong interrupt number
>>>in the device-tree...

>>>Ben.

>>The platform is the AMCC Sequoia board.  We've built a little adapter to
>>connect a compact flash card to the processor bus.  I believe the
>>interrupt selection in the device tree is correct, and I've checked over
>>the u-boot settings for the IRQ line (active high, level sensitive). 

> IDE IRQs are active-low.

    Only on the PCI and only in the native mode. Natively, the IDE INTRQ 
signal is active-high, rising edge triggering, as on ISA. You seem to have an 
invertor somewhere, if it's not a PCI chip...

WBR, Sergei
