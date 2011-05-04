Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[66.63.167.143]) by ozlabs.org (Postfix) with ESMTP id 953C6B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 01:10:11 +1000 (EST)
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mike Frysinger <vapier.adi@gmail.com>
In-Reply-To: <BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 10:04:04 -0500
Message-ID: <1304521444.2810.23.camel@mulgrave.site>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>,
	linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org,
	Sven Eckelmann <sven@narfation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-04 at 00:44 -0400, Mike Frysinger wrote:
> On Tue, May 3, 2011 at 17:30, Sven Eckelmann wrote:
> > Introduce an *_dec_not_zero operation.  Make this a special case of
> > *_add_unless because batman-adv uses atomic_dec_not_zero in different
> > places like re-broadcast queue or aggregation queue management. There
> > are other non-final patches which may also want to use this macro.
> >
> > Cc: uclinux-dist-devel@blackfin.uclinux.org
> >
> > --- a/arch/blackfin/include/asm/atomic.h
> > +++ b/arch/blackfin/include/asm/atomic.h
> > @@ -103,6 +103,7 @@ static inline int atomic_test_mask(int mask, atomic_t *v)
> >        c != (u);                                               \
> >  })
> >  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> > +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
> >
> >  /*
> >  * atomic_inc_and_test - increment and test
> 
> no opinion on the actual idea, but for the Blackfin pieces:
> Acked-by: Mike Frysinger <vapier@gentoo.org>

This goes for parisc as well.

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

James
