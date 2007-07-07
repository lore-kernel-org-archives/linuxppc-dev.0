Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 911B7DE1BF
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:14:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 20:07:10 +0200
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<200707071419.52650.arnd@arndb.de> <468FC4AC.9030701@ru.mvista.com>
In-Reply-To: <468FC4AC.9030701@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707072007.10448.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Sergei Shtylyov wrote:
> Arnd Bergmann wrote:
> 
> >>This adds support for MMIO IDE device like CompactFlash 
> >>in TrueIDE mode.
> 
> >>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com> 
> >>Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> > Hmm, are we still adding new IDE drivers? Do you also have a
> 
>     Yes, why not?

The last time someone (I think Akira Iguchi) wanted to add
a new powerpc specific IDE driver, that was rejected based
on the argument that drivers/ide/ is going away soon. Most
current distros have already moved over to using libata
exclusively.

> > about to add the electra_ide.c driver in 2.6.23, I guess there
> > should really be _one_ driver that is able to handle all
> > of_device based ATA hosts.
> 
>     One driver to rule them all. :-)
>     That may be not so simple as it seems...

It's certainly not easy to support all ATA chips that
have special capabilities and bugs, but the electra and the
mpc8349-itx both seem to support only the most basic ATA
PIO mode anyway, which does not require much special
handling beyond finding the right mmio addresses.

	Arnd <><
