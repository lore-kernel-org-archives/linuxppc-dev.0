Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 3E3F8B714E
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 22:09:03 +1000 (EST)
Received: by eyg24 with SMTP id 24so1204577eyg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Sep 2010 05:09:01 -0700 (PDT)
Date: Fri, 3 Sep 2010 16:08:58 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: =?utf-8?B?QW5kcsOp?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20100903120858.GA19380@oksana.dev.rtsoft.ru>
References: <1283502979.17812.22.camel@swa-m460>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1283502979.17812.22.camel@swa-m460>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 03, 2010 at 10:36:19AM +0200, André Schwarz wrote:
> Hi,
> 
> we're about to get new MPC8377 based hardware with various peripherals.
> There are two I2C-to-SPI bridge devices (NXP SC18IS602) and I'm not sure
> how to define a proper dts...
> 
> Of course it's an easy thing creating 2 child nodes on the CPU's I2C
> device - but how can I represent the created SPI bus ?

Um.. the same as the other SPI buses? I.e.

i2c-controller {  /* SOC I2C controller */
	spi-controller {  /* The I2C-to-SPI bridge */
		spi-device@0 {
		};
		spi-device@1 {
		};
	};
};

> Is the (possibly) required driver (of_sc18is60x_spi ?) supposed to be an
> I2C slave or an SPI host driver ?

It should be an I2C driver that registers an SPI master (i.e.
calls spi_alloc_master() and spi_register_master()).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
