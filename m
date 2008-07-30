Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 202C4DDF41
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 07:18:20 +1000 (EST)
Message-ID: <4890DA8E.5000502@garzik.org>
Date: Wed, 30 Jul 2008 17:18:06 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/ibmveth: fix multiple errors with
	dma_mapping_error conversion
References: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
In-Reply-To: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LKML <linux-kernel@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> The addition of an argument to dma_mapping_error() in commit
> 8d8bb39b9eba32dd70e87fd5ad5c5dd4ba118e06 "dma-mapping: add the device
> argument to dma_mapping_error()" left a bit of fallout:
> 
> drivers/net/ibmveth.c:263: error: too few arguments to function 'dma_mapping_error'
> drivers/net/ibmveth.c:264: error: expected ')' before 'goto'
> drivers/net/ibmveth.c:284: error: expected expression before '}' token
> drivers/net/ibmveth.c:297: error: too few arguments to function 'dma_mapping_error'
> drivers/net/ibmveth.c:298: error: expected ')' before 'dma_unmap_single'
> drivers/net/ibmveth.c:306: error: expected expression before '}' token
> drivers/net/ibmveth.c:491: error: too few arguments to function 'dma_mapping_error'
> drivers/net/ibmveth.c:927: error: too few arguments to function 'dma_mapping_error'
> drivers/net/ibmveth.c:927: error: expected ')' before '{' token
> drivers/net/ibmveth.c:974: error: expected expression before '}' token
> drivers/net/ibmveth.c:914: error: label 'out' used but not defined m
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ibmveth.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> Compiler tested for ppc64_defconfig.

applied
