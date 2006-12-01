Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.25])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E33667BB6
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 02:30:24 +1100 (EST)
Date: Fri, 1 Dec 2006 07:30:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
In-Reply-To: <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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



On Fri, 1 Dec 2006, Geert Uytterhoeven wrote:
>
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
> 
> The code snippet
> 
> | u64 x = PS3_VENDOR_ID_SONY;
> | printk("PS3_VENDOR_ID_SONY = %lu\n", x);
> 
> does print the expected (i.e. non-zero) result.
> 
> Hence this looks like a bug in sparse.

It's really a bug in gcc, but it's documented, so it's a "feature".

Gcc allows large enums, but does so in such a strange manner that it's 
totally hopeless to catch problems. Also, putting a value that is larger 
than "unsigned int" into an enum is really setting yourself up for bugs 
and not even guaranteed to work for standard C, so sparse takes a dim view 
of it and just says that enums are limited in size to "int" or "unsigned 
int".

You can either ignore that warning or just use a #define. 

			Linus
