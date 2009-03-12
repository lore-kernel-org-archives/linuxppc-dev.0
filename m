Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 98633DE0FE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 17:02:21 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Date: Thu, 12 Mar 2009 07:02:03 +0100
References: <49B58779.9040905@lebon.org.ua>
	<20090311103716.GE26415@zod.rchland.ibm.com>
	<49B80BA3.1090301@ru.mvista.com>
In-Reply-To: <49B80BA3.1090301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903120702.03286.sr@denx.de>
Cc: lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 March 2009, Valentine Barshak wrote:
> I've been looking at the docs once again and actually I couldn't find an
>    explanation there. And I don't have that e-mail from AMCC support
> that I got a while back regarding the issue anymore.
> There might have been some misunderstanding.
> The docs (PPC440EPX UM 19.2 Device Address Mapping) say that the chip
> select field width is always fixed at one bit, but this doesn't actually
>   mean that there's always one chip select used.
> The patch works fine on Sequoia and another Sequoia-like board with 1GB
> RAM installed, but it might not work with 2GB RAM. I've tried to play
> with DDR0_10 settings and Sequoia works fine regardless of what's
> actually written to DDR0_10.
> So, probably the best way would be to fix that in u-boot
> amcc/sequoia/sdram.c by doing mtsdram(DDR0_10, 0x00000100); instead of
> mtsdram(DDR0_10, 0x00000300);
> Sorry, for confusion, but after reviewing the docs, I think that
> only REDUC interpretation has to be fixed. The chips select part should
> be fixed in u-boot sdram code for Sequoia as was originally proposed by
> Mikhail.
>
> Stefan, could you please take a look?

I'll apply the U-Boot patch today. But as Josh pointed out, we should try to 
find a way for the bootwrapper to work in all cases.

Best regards,
Stefan
