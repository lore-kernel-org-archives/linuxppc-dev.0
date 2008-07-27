Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AAC9DDF78
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 05:25:00 +1000 (EST)
Date: Sun, 27 Jul 2008 12:24:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/ibmveth: fix multiple errors with
	dma_mapping_error conversion
Message-Id: <20080727122414.cac4e336.akpm@linux-foundation.org>
In-Reply-To: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
References: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 02:14:24 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> The addition of an argument to dma_mapping_error() in commit
> 8d8bb39b9eba32dd70e87fd5ad5c5dd4ba118e06 "dma-mapping: add the device
> argument to dma_mapping_error()" left a bit of fallout:

Yeah, sorry, that patch was a horror - I fixed it perhaps ten times.  I
think people were madly adding new dma_mapping_error() calls while we
were trying to maintain it as well.

It should have been dome as a two-stage conversion.
