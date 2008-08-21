Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id BFB87DF1EF
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:40:59 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Strange behavior with I2C on Sequoia board
Date: Thu, 21 Aug 2008 16:40:49 +0200
References: <48AC84D9.8050809@harris.com> <48AD6D3B.6030701@harris.com>
	<Pine.LNX.4.64.0808211630170.20704@vixen.sonytel.be>
In-Reply-To: <Pine.LNX.4.64.0808211630170.20704@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808211640.49753.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Geert Uytterhoeven wrote:
> On Thu, 21 Aug 2008, Steven A. Falco wrote:
> > I would like to switch over to using a uImage rather than the
> > cuboot.uImage.
>
> Can you actually boot a plain uImage from U-Boot?

Sure. We did this all the time in arch/ppc. Now in arch/powerpc all you need 
is an device-tree enabled U-Boot version. This is standard for most targets 
since a few months.

> I've just gave it a try.  While arch/powerpc/boot/cuImage.sequoia boots
> fine,
>
> after `make uImage', I get arch/powerpc/boot/uImage, but it doesn't boot:
> | ## Booting image at 00100000 ...
> |    Image Name:   Linux-2.6.27-rc4-dirty
> |    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> |    Data Size:    1398827 Bytes =  1.3 MB
> |    Load Address: 00000000
> |    Entry Point:  00000000
> |    Verifying Checksum ... OK
> |    Uncompressing Kernel Image ... Error: inflate() returned -3
> | GUNZIP ERROR - must RESET board to recover

Try a higher load address for the kernel. 4MB is a good value.

> | U-Boot 1.2.0-gc0c292b2 (Jun  5 2007 - 07:16:12)

Ups. This is most likely too old and can't boot arch/powerpc uImage files.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
