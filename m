Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtk2Y1VkhzDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 10:08:21 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2TMxE9Q038356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 19:08:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29gcthj48e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 19:08:09 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 29 Mar 2017 19:08:08 -0400
Subject: Re: [PATCH] crypto: vmx: Remove dubiously licensed crypto code
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20170329125639.14288-1-msuchanek@suse.de>
 <20170329145135.GA28057@kroah.com> <20170329171327.38d4fdd6@kitsune.suse.cz>
Cc: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 16:08:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170329171327.38d4fdd6@kitsune.suse.cz>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7ec54553-610c-a5dc-d4d9-3c83f6a161d9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/29/2017 08:13 AM, Michal Suchánek wrote:
> On Wed, 29 Mar 2017 16:51:35 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
>> On Wed, Mar 29, 2017 at 02:56:39PM +0200, Michal Suchanek wrote:
>>> While reviewing commit 11c6e16ee13a ("crypto: vmx - Adding asm
>>> subroutines for XTS") which adds the OpenSSL license header to
>>> drivers/crypto/vmx/aesp8-ppc.pl licensing of this driver came into
>>> qestion. The whole license reads:
>>>
>>>  # Licensed under the OpenSSL license (the "License").  You may not
>>> use # this file except in compliance with the License.  You can
>>> obtain a # copy
>>>  # in the file LICENSE in the source distribution or at
>>>  # https://www.openssl.org/source/license.html
>>>
>>>  #
>>>  #
>>> ====================================================================
>>> # Written by Andy Polyakov <appro@openssl.org> for the OpenSSL #
>>> project. The module is, however, dual licensed under OpenSSL and #
>>> CRYPTOGAMS licenses depending on where you obtain it. For further #
>>> details see http://www.openssl.org/~appro/cryptogams/. #
>>> ====================================================================
>>>
>>> After seeking legal advice it is still not clear that this driver
>>> can be legally used in Linux. In particular the "depending on where
>>> you obtain it" part does not make it clear when you can apply the
>>> GPL and when the OpenSSL license.
>>>
>>> I tried contacting the author of the code for clarification but did
>>> not hear back. In absence of clear licensing the only solution I
>>> see is removing this code.

A quick 'git grep OpenSSL' of the Linux tree returns several other
crypto files under the ARM architecture that are similarly licensed. Namely:

arch/arm/crypto/sha1-armv4-large.S
arch/arm/crypto/sha256-armv4.pl
arch/arm/crypto/sha256-core.S_shipped
arch/arm/crypto/sha512-armv4.pl
arch/arm/crypto/sha512-core.S_shipped
arch/arm64/crypto/sha256-core.S_shipped
arch/arm64/crypto/sha512-armv8.pl
arch/arm64/crypto/sha512-core.S_shipped

On closer inspection of some of those files have the addendum that
"Permission to use under GPL terms is granted", but not all of them.

-Tyrel
