Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FBBDDDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 19:31:55 +1100 (EST)
Date: Wed, 20 Dec 2006 17:31:32 +0900 (JST)
Message-Id: <200612200831.kBK8VXNd004301@toshiba.co.jp>
To: hch@lst.de
Subject: Re: [PATCH 7/19] powerpc: hypervisor call numbers for Celleb
In-Reply-To: <20061214173235.GA6048@lst.de> 
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank you for your comment.

> On Thu, Dec 14, 2006 at 11:30:28AM +0900, Ishizaki Kou wrote:

> > +
> > +#ifdef	__ASSEMBLY__
> > +#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((__v)<<60|(__x))
> > +#elif defined(__powerpc64__)
> > +#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((unsigned long)(__v)<<60|(__x))
> > +#else
> > +#define	__BEAT_ADD_VENDOR_ID(__x, __v)	((unsigned long long)(__v)<<60|(__x))
> > +#endif

> __powerpc64__ is always set for ppc64 compiles.

I understand that, but it is shared with our own source code which
runs on 32bit mode.

> > +#define HV_allocate_memory (0)
> > +#define HV_construct_virtual_address_space (2)

> isn't HV_foo a little too generic?  Also no need for the braces around
> the actual hvall numbers.

It is also shared with our own (proprietary) source code,
so modifying the prefix impacts our software. We think its
impact is small since no files outside of celleb/
will include hvcall number definitions.

Wrapping numbers in braces is problem on our generator,
so we will modify it.

Best regards,
Ishizaki Kou.
