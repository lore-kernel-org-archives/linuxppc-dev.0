Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C1B467BEF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 01:39:48 +1100 (EST)
Date: Fri, 1 Dec 2006 14:39:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
Message-ID: <20061201143940.GB3078@ftp.linux.org.uk>
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-sparse@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 01, 2006 at 03:25:08PM +0100, Geert Uytterhoeven wrote:
> On Tue, 21 Nov 2006, Geoff Levand wrote:
> > +enum ps3_vendor_id {
> > +	PS3_VENDOR_ID_NONE = 0,
> > +	PS3_VENDOR_ID_SONY = 0x8000000000000000UL,
> > +};
> 
> I've just ran `make C=1' (PPC in 64-bit mode, and sparse is called with -m64),
> and noticed that sparse (cloned from
> git://git.kernel.org/pub/scm/devel/sparse/sparse.git a few minutes ago)
> complains about the second value with:
> 
> | warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> 
> Section 6.7.2.2.4 of C99 says:
> 
> | Each enumerated type shall be compatible with char, a signed integer type, or
> | an unsigned integer type. The choice of type is implementation-defined, but
> | shall be capable of representing the values of all the members of the
> | enumeration.

FWIW, that code is *not* valid C99; note that all enumeration members must
fit the range of int (see 6.7.2.2.2).  What you quote speaks about the
objects of type enum <something>, which is not the same as type of enum
members.  In C99 it's int, plain and simple.  Value outside of the range
of int => undefined behaviour.  Note that with
	enum foo {A, B} x;
you might very well have sizeof(A) != sizeof(x).

IOW, you are using a gccism in an area where gcc is bloody inconsistent
in the set of bugs it shows in different versions.

Generally safe way is to split the anonymous huge enum members into
single-element enums and pray that gcc will at least stay consistent
in handling of those.
