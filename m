Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqNrl0MJ6zDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 02:02:30 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DFxCtQ092539
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 12:02:28 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 245py7523x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 12:02:28 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 13:02:26 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 117971DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 12:02:11 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DG2Iwi65994880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 13:02:19 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DG2Icc014736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 13:02:18 -0300
Date: Wed, 13 Jul 2016 13:02:09 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "open list:IBM Power VMX Cryptographic instructions"
 <linux-crypto@vger.kernel.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] crypto: vmx - Adding asm subroutines for XTS
References: <1468264060-22769-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
 <20160712093705.6f0fde7a@canb.auug.org.au>
 <8737nep7a8.fsf@linux.vnet.ibm.com> <20160713133427.GA20432@dublin>
 <20160714011158.46c386f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160714011158.46c386f4@canb.auug.org.au>
Message-Id: <20160713160209.GB20432@dublin>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thu, Jul 14, 2016 at 01:11:58AM +1000, Stephen Rothwell wrote:
> Hi Paulo,
> 
> On Wed, 13 Jul 2016 10:34:27 -0300 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:
> >
> > Wed, Jul 13, 2016 at 01:05:03PM +1000, Stewart Smith wrote:
> > > Stephen Rothwell <sfr@canb.auug.org.au> writes:  
> > > > On Mon, 11 Jul 2016 16:07:39 -0300 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:  
> > > >>
> > > >> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
> > > >> index 2280539..813ffcc 100644
> > > >> --- a/drivers/crypto/vmx/aesp8-ppc.pl
> > > >> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
> > > >> @@ -1,4 +1,11 @@
> > > >> -#!/usr/bin/env perl
> > > >> +#! /usr/bin/env perl
> > > >> +# Copyright 2014-2016 The OpenSSL Project Authors. All Rights Reserved.
> > > >> +#
> > > >> +# Licensed under the OpenSSL license (the "License").  You may not use
> > > >> +# this file except in compliance with the License.  You can obtain a copy
> > > >> +# in the file LICENSE in the source distribution or at
> > > >> +# https://www.openssl.org/source/license.html  
> > > >
> > > > So, I assume that this license is compatible with the GPLv2?  
> > 
> > Andy released this code under the cryptogams license:
> > 
> > # ====================================================================
> > # Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
> > # project. The module is, however, dual licensed under OpenSSL and
> > # CRYPTOGAMS licenses depending on where you obtain it. For further
> > # details see http://www.openssl.org/~appro/cryptogams/.
> > # ====================================================================
> 
> Yeah, this license statement is already in the file being patched, so
> why is the above license (and Copyright notice) being added above the
> existing one?

aesp8-ppc.pl from Linux is almost the same as the one from OpenSSL and we do
that so we can keep it updated on both projects.
The above license lines were added to all pl files in OpenSSL so it ended up
here but since the author published it as cryptogams too we are ok.

> 
> > The license is GPL compatible:
> 
> Good, thanks.
> 
> > ALTERNATIVELY, provided that this notice is retained in full, this
> > product may be distributed under the terms of the GNU General Public
> > License (GPL), in which case the provisions of the GPL apply INSTEAD OF
> > those given above.
> 
> Which is not in this file or the patch, but presumably in the referred
> to web page.

Yes, that comment is from the url pointed in the code.

> 
> Of course, I am not a lawyer :-)
> -- 
> Cheers,
> Stephen Rothwell
> 

-- 
Paulo Flabiano Smorigo
IBM Linux Technology Center
