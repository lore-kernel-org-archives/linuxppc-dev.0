Return-Path: <mark@toertel.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.184]) by ozlabs.org (Postfix) with ESMTP id 47DA62BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Dec 2004 06:00:05 +1100 (EST)
Message-ID: <41BC7D18.9090201@toertel.de>
Date: Sun, 12 Dec 2004 18:17:12 +0100
From: Mark Jonas <mark@toertel.de>
MIME-Version: 1.0
To: wangwenbin <stcwang@163.net>
References: <20041210015932.A3B692BDA0@ozlabs.org>
In-Reply-To: <20041210015932.A3B692BDA0@ozlabs.org>
Content-Type: text/plain; charset=GB2312
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: video card for Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Tony,

>   I have successfully boot Linux 2.4.22 on my Lite5200 Evaluation Board with the ELDK. but when I want to use PCI slot for the video card,something goes wrong. The whole board loses supply of electricity. And i take the video card out ,the board is still ok. So i change to put RTL81390 network card into PCI slot. The same thing happen.
>    The video card i have tried :
>            S3 Trio64V
>            Trident TGUI9680
>            S3 ViRGE/DX
>  
>
According to my experience with the Lite5200 board there are three
things that might have gone wrong in your experiments:

1.) You plugged in a 5V-only card. Make sure your card 3.3V compliant.
Check that by looking at the data sheet _and_ by looking a the PCI
card's edge connector. The coding gap must be in to the front of the card.

2.) You plugged in a card which claims to be 3.3V PCI compliant card but
is not. Even if the coding gap marks it as 3.3V compliant I've seen
cards before that aren't. They usually make a short between V I/O and +5
VDC which results in what you can see: The power supply goes into
protection.

3.) You placed the PCI card into the PCI slot turned by 180 degrees.
That also usually results in a short and the power supply goes into
protection. Please consult the Lite5200's user manual and make sure you
plug in the card the right way.

If had to make a bet what your problem is I would put my money on 3. I
think so because RTL8139 cards are usually 3.3V compliant. Additionally,
the graphics cards you mentioned are usually not 3.3V compliant but if
you turn them by 180 degrees their coding gap will fit.

Regards
Mark
