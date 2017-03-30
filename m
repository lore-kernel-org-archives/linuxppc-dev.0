Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtlZR6hGyzDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 11:17:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Suchanek <msuchanek@suse.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 paulmck@linux.vnet.ibm.com <paulmck@linux.vnet.ibm.com>, appro@openssl.org
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH] crypto: vmx: Remove dubiously licensed crypto code
In-Reply-To: <20170329125639.14288-1-msuchanek@suse.de>
References: <20170329125639.14288-1-msuchanek@suse.de>
Date: Thu, 30 Mar 2017 11:17:33 +1100
Message-ID: <87r31flisi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Suchanek <msuchanek@suse.de> writes:

> While reviewing commit 11c6e16ee13a ("crypto: vmx - Adding asm
> subroutines for XTS") which adds the OpenSSL license header to
> drivers/crypto/vmx/aesp8-ppc.pl licensing of this driver came into
> qestion. The whole license reads:
>
>  # Licensed under the OpenSSL license (the "License").  You may not use
>  # this file except in compliance with the License.  You can obtain a
>  # copy
>  # in the file LICENSE in the source distribution or at
>  # https://www.openssl.org/source/license.html
>
>  #
>  # ====================================================================
>  # Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
>  # project. The module is, however, dual licensed under OpenSSL and
>  # CRYPTOGAMS licenses depending on where you obtain it. For further
>  # details see http://www.openssl.org/~appro/cryptogams/.
>  # ====================================================================
>
> After seeking legal advice it is still not clear that this driver can be
> legally used in Linux. In particular the "depending on where you obtain
> it" part does not make it clear when you can apply the GPL and when the
> OpenSSL license.

It seems pretty clear to me that the intention is that the CRYPTOGAM
license applies.

If you visit it's URL it includes:

  ALTERNATIVELY, provided that this notice is retained in full, this
  product may be distributed under the terms of the GNU General Public
  License (GPL), in which case the provisions of the GPL apply INSTEAD OF
  those given above.


I agree that the text in the file is not sufficiently clear about what
license applies, but I'm unconvinced that there is any code here that is
actually being distributed incorrectly.

Getting the text in the header changed to be clearer seems like the
obvious solution.

> I tried contacting the author of the code for clarification but did not
> hear back. In absence of clear licensing the only solution I see is
> removing this code.

Did you try contacting anyone else? Like perhaps the powerpc or crypto
maintainers, or anyone else who's worked on the driver?

Sending a patch to delete all the code clearly works to get people's
attention, I'll give you that.
