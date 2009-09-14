Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 85ACCB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:05:02 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: How to access DCR registers in powerpc440gx? Got err when use
	macro def in Linux kernel
Date: Mon, 14 Sep 2009 14:59:43 +0200
References: <8abf57fa0909101024n668ad353kf8be038898305c28@mail.gmail.com>
	<8abf57fa0909102114hf935c21h5dd727ba2a9a4825@mail.gmail.com>
	<20090911053106.GB11840@yookeroo.seuss>
In-Reply-To: <20090911053106.GB11840@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200909141459.43371.arnd@arndb.de>
Cc: g r1x <gr1xmail@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 September 2009, David Gibson wrote:
> On Fri, Sep 11, 2009 at 12:14:55PM +0800, g r1x wrote:
> > Now, I'm writing a DMA driver on powerpc
> > 440gx platform(2.6.26.5), as the only way to set up DMA Controller is
> > to access it's dcr registers with 'mfdcr' and 'mtdcr'.
> > 
> > I've found some dma code in Linux kernel 2.6.26.5, so I copy the code
> > u wrote to my driver module directory, and include them, but when I
> > compile my driver, gcc complains following err messages:
> 
> In current kernels we have some DCR macros that use a big table of
> pre-generated instructions in order to allow accesses to runtime
> computed DCR numbers.  But either they didn't exist in 2.6.26, or they
> have a different name, I don't remember.

The portable way to access DCRs is the API from asm/dcr.h, using dcr_map(),
dcr_read() and dcr_write().

	Arnd <><
