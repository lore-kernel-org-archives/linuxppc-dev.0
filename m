Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D7671A0295
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 01:47:45 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A113140216
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2015 01:47:45 +1100 (AEDT)
Date: Tue, 1 Dec 2015 15:47:41 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@au1.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: [PATCH] cxl: Fix build failure due to -Wunused-variable
 behaviour change
Message-ID: <20151201144741.GA5509@lst.de>
References: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
 <20151125161616.GA30262@lst.de> <1448494913.22705.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448494913.22705.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2015 at 10:41:53AM +1100, Michael Ellerman wrote:
> On Wed, 2015-11-25 at 17:16 +0100, Torsten Duwe wrote:
> > On Tue, Sep 15, 2015 at 03:48:34PM +1000, Ian Munsie wrote:
> > > --- a/drivers/misc/cxl/Makefile
> > > +++ b/drivers/misc/cxl/Makefile
> > > @@ -1,4 +1,4 @@
> > > -ccflags-y := -Werror
> > > +ccflags-y := -Werror -Wno-unused-const-variable
> > 
> > JFYI, my gcc-4.3 does not like this switch.
> > What's the minimum compiler version to build this code?
> 
> I build everything with gcc 4.4.4, so if it breaks with that I will notice.
> 
> Does it work if you wrap it in cc-option? eg:
> 
> ccflags-y := -Werror $(call cc-option,-Wno-unused-const-variable)

Yes, now it builds. It also looks cleaner to me: compilers which check
for "unused-const-variable"s should have this switch and the check is disabled.
All other (known :) warnings error out.

	Torsten
