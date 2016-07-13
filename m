Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqKZF246QzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 23:34:45 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DDYPAj108659
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:34:43 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2448qn2g3e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:34:42 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 10:34:40 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0A9C31DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:34:29 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DDYaLG11272450
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:34:36 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DDYZUu009512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:34:36 -0300
Date: Wed, 13 Jul 2016 10:34:27 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
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
 <8737nep7a8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737nep7a8.fsf@linux.vnet.ibm.com>
Message-Id: <20160713133427.GA20432@dublin>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wed, Jul 13, 2016 at 01:05:03PM +1000, Stewart Smith wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > On Mon, 11 Jul 2016 16:07:39 -0300 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:
> >>
> >> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
> >> index 2280539..813ffcc 100644
> >> --- a/drivers/crypto/vmx/aesp8-ppc.pl
> >> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
> >> @@ -1,4 +1,11 @@
> >> -#!/usr/bin/env perl
> >> +#! /usr/bin/env perl
> >> +# Copyright 2014-2016 The OpenSSL Project Authors. All Rights Reserved.
> >> +#
> >> +# Licensed under the OpenSSL license (the "License").  You may not use
> >> +# this file except in compliance with the License.  You can obtain a copy
> >> +# in the file LICENSE in the source distribution or at
> >> +# https://www.openssl.org/source/license.html
> >
> > So, I assume that this license is compatible with the GPLv2?

Andy released this code under the cryptogams license:

# ====================================================================
# Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
# project. The module is, however, dual licensed under OpenSSL and
# CRYPTOGAMS licenses depending on where you obtain it. For further
# details see http://www.openssl.org/~appro/cryptogams/.
# ====================================================================

The license is GPL compatible:

ALTERNATIVELY, provided that this notice is retained in full, this
product may be distributed under the terms of the GNU General Public
License (GPL), in which case the provisions of the GPL apply INSTEAD OF
those given above.

> 
> https://people.gnome.org/~markmc/openssl-and-the-gpl.html has an
> explanation and points to:
> https://www.openssl.org/docs/faq.html#LEGAL2
> 
> which makes it anything but clearer.
> 
> it appears the answer is "probably not, unless you have an explicit
> exemption in your license"
> 
> -- 
> Stewart Smith
> OPAL Architect, IBM.

-- 
Paulo Flabiano Smorigo
IBM Linux Technology Center
