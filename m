MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16604.50729.850526.239189@cargo.ozlabs.ibm.com>
Date: Sat, 26 Jun 2004 10:41:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
Subject: Re: GT64260_eth (Ethernet) Driver
In-Reply-To: <40DCBE32.2030008@mvista.com>
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>
	<40DA06BE.204@mvista.com>
	<1088066228.18627.3352.camel@hades.cambridge.redhat.com>
	<40DB2199.2050006@mvista.com>
	<1088147437.4636.114.camel@imladris.demon.co.uk>
	<40DCA1A3.6000401@mvista.com>
	<1088207000.4636.136.camel@imladris.demon.co.uk>
	<40DCBE32.2030008@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark A. Greer writes:

> Ahh, G*d I hate that...struct aaa, struct bbb, struct ccc all over the
> place when its not necessary & adds no value.  Anyway, I will do that.

It does make things clearer for the reader - when you see a
declaration "struct foo bar;" you know that it is a struct, but if you
see "foo_t bar;" you have no clue what sort of thing it is without
going and looking elsewhere.

The other advantage to using "struct" is that it can help straighten
out include file messes.  If you have a header where you need to
declare a function that takes a foo_t *, you have no choice but to
#include <foo.h>, or whatever the header is that defines foo_t.  That
can easily lead to messes where foo.h needs to include other things
which end up including everything plus the kitchen sink.  If you
instead declare your function as taking a struct foo *, then you can
solve the problem by simply putting a "struct foo;" declaration in
your header, and then you don't need to #include <foo.h>.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
