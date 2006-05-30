Return-Path: <lagrange@fr.oleane.com>
Received: from smtp10.clb.oleane.net (smtp10.clb.oleane.net [213.56.31.32])
	by ozlabs.org (Postfix) with ESMTP id 0961B67B3C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 19:45:39 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Thiago Galesi'" <thiagogalesi@gmail.com>
Subject: RE: Linux kernel thread with Linux 2.6.x
Date: Tue, 30 May 2006 11:46:09 +0200
Message-ID: <000a01c683cd$e3f29ca0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <82ecf08e0605291013t7bd1627bg92d13908b3d0b7b7@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for your answer, but a tasklet runs in interrupt context
(in_interrupt() != 0) so it doesn't support schedule() call
included in "down" semaphore function.

Any other idea ?

Laurent.

> -----Message d'origine-----
> De : Thiago Galesi [mailto:thiagogalesi@gmail.com]
> Envoyé : lun. 29 mai 2006 18:13
> À : Laurent Lagrange
> Cc : linuxppc-embedded@ozlabs.org
> Objet : Re: Linux kernel thread with Linux 2.6.x
>
>
> >
> > As the interrupt handler can't be scheduled, I have made a
> kernel thread
> > which waits forever on a semaphore.
> > This semaphore is set when a received packet interrupt occured.
>
> You should look into tasklets for this. Not that your system is not
> OK, but, as you said it, it's not fast enough.
>
> Note that you still have some limitations using tasklets, but it's
> more flexible than Interrupt handlers.
>
>
