Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C81DDDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 02:18:24 +1000 (EST)
Message-ID: <461BB8C7.9050900@garzik.org>
Date: Tue, 10 Apr 2007 12:18:15 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
In-Reply-To: <20070410171125.3aeed29d@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alan Cox wrote:
>>     Ah, no interrupts at all...
>>     The old IDE core in drivers/ide/ certainly doesn't support polling mode 
>> and IRQ-less devices. AFAICS, libata also doesn't support the latter...
> 
> libata has much of the framework to do this as it originally did all of
> its PIO work much this way. That is probably the most productive place to
> start hacking.

Yep.

The only real restriction in libata is in ata_device_add(), which 
unconditionally registers an irq handler.  Make a few changes there, add 
a few flags, and the existing polling code will kick in.

Once we have higher priority stuff sorted, I would like to look into 
things like activating the polling code when it becomes obvious that the 
system is not delivering interrupts.

	Jeff
