Return-Path: <michaelzwrk@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 2DEDDDDFB6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 18:40:00 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so141435ana
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 01:39:59 -0700 (PDT)
Message-ID: <1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
Date: Wed, 11 Apr 2007 10:39:58 +0200
From: Michael <michaelzwrk@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
In-Reply-To: <20070410172942.7f63d49c@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
	<461BB8C7.9050900@garzik.org>
	<20070410172942.7f63d49c@the-village.bc.nu>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Doesn't libata have to do with SCSI devices? I'm afraid it wouldn't
work with CF, which is P-ATA compatible.

Wouldn't it work just to call ide_intr() explicitly from some polling
function, as Mark suggested?

Michael

On 4/10/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > The only real restriction in libata is in ata_device_add(), which
> > unconditionally registers an irq handler.  Make a few changes there, add
> > a few flags, and the existing polling code will kick in.
>
> Obvious thing to do would be to do this if the IRQ number passed in is 0
> rather than aborting as we do now. In theory ISAPnP devices may be
> IRQless too.
>
> Alan
>
