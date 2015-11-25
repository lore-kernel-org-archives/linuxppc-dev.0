Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB2C11A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 10:41:53 +1100 (AEDT)
Message-ID: <1448494913.22705.3.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix build failure due to -Wunused-variable
 behaviour change
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Ian Munsie <imunsie@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling
 <mikey@neuling.org>,  Anton Blanchard <anton@au1.ibm.com>, Michael Ellerman
 <michaele@au1.ibm.com>
Date: Thu, 26 Nov 2015 10:41:53 +1100
In-Reply-To: <20151125161616.GA30262@lst.de>
References: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
 <20151125161616.GA30262@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-25 at 17:16 +0100, Torsten Duwe wrote:
> On Tue, Sep 15, 2015 at 03:48:34PM +1000, Ian Munsie wrote:
> > --- a/drivers/misc/cxl/Makefile
> > +++ b/drivers/misc/cxl/Makefile
> > @@ -1,4 +1,4 @@
> > -ccflags-y := -Werror
> > +ccflags-y := -Werror -Wno-unused-const-variable
> 
> JFYI, my gcc-4.3 does not like this switch.
> What's the minimum compiler version to build this code?

I build everything with gcc 4.4.4, so if it breaks with that I will notice.

Does it work if you wrap it in cc-option? eg:

ccflags-y := -Werror $(call cc-option,-Wno-unused-const-variable)


cheers
