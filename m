Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9F0A5DE1AA
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 04:53:25 +1100 (EST)
Date: Tue, 14 Oct 2008 21:53:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
Message-ID: <20081014175322.GA30941@oksana.dev.rtsoft.ru>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
	<gd2f4s$82f$1@ger.gmane.org>
	<20081014170455.GA16338@oksana.dev.rtsoft.ru>
	<48F4D29F.6090909@selcomgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48F4D29F.6090909@selcomgroup.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, linux-fbdev-devel@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 07:10:55PM +0200, Matteo Fortini wrote:
> Carminefb driver, though, supports 800x600 resolution.
>
> BTW, I tried this patch and I get wrong colors on a patched DirectFB  
> which is changing the endianness on the fly. Is this driver already  
> taking care of this?

Yup. But you can change that, just delete FB_*_ENDIAN stuff from
drivers/video/Kconfig:

+config FB_MB862XX_LIME
+       bool "Lime GDC"
+       depends on FB_MB862XX
+       select FB_FOREIGN_ENDIAN
+       select FB_LITTLE_ENDIAN

..but then the kernel's fb console will be with the wrong colors.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
