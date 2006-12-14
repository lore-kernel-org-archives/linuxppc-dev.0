Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF6A067D40
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 04:32:43 +1100 (EST)
Date: Thu, 14 Dec 2006 18:32:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 7/19] powerpc: hypervisor call numbers for Celleb
Message-ID: <20061214173235.GA6048@lst.de>
References: <200612140230.kBE2UT9R014367@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612140230.kBE2UT9R014367@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 14, 2006 at 11:30:28AM +0900, Ishizaki Kou wrote:

> +
> +#ifdef	__ASSEMBLY__
> +#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((__v)<<60|(__x))
> +#elif defined(__powerpc64__)
> +#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((unsigned long)(__v)<<60|(__x))
> +#else
> +#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((unsigned long long)(__v)<<60|(__x))
> +#endif

__powerpc64__ is always set for ppc64 compiles.

> +#define HV_allocate_memory (0)
> +#define HV_construct_virtual_address_space (2)

isn't HV_foo a little too generic?  Also no need for the braces around
the actual hvall numbers.
