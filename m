Message-ID: <40DCD5C8.3080307@mvista.com>
Date: Fri, 25 Jun 2004 18:47:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
Subject: Re: GT64260_eth (Ethernet) Driver
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>	<40DA06BE.204@mvista.com>	<1088066228.18627.3352.camel@hades.cambridge.redhat.com>	<40DB2199.2050006@mvista.com>	<1088147437.4636.114.camel@imladris.demon.co.uk>	<40DCA1A3.6000401@mvista.com>	<1088207000.4636.136.camel@imladris.demon.co.uk>	<40DCBE32.2030008@mvista.com> <16604.50729.850526.239189@cargo.ozlabs.ibm.com>
In-Reply-To: <16604.50729.850526.239189@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

>Mark A. Greer writes:
>
>
>
>>Ahh, G*d I hate that...struct aaa, struct bbb, struct ccc all over the
>>place when its not necessary & adds no value.  Anyway, I will do that.
>>
>>
>
>It does make things clearer for the reader - when you see a
>declaration "struct foo bar;" you know that it is a struct, but if you
>see "foo_t bar;" you have no clue what sort of thing it is without
>going and looking elsewhere.
>
Yes but chances are you're going to look it up anyway (no matter what
type of creature it is).  Plus with cscope or something similar its
pretty quick/easy to look it up.

>The other advantage to using "struct" is that it can help straighten
>out include file messes.  If you have a header where you need to
>declare a function that takes a foo_t *, you have no choice but to
>#include <foo.h>, or whatever the header is that defines foo_t.  That
>can easily lead to messes where foo.h needs to include other things
>which end up including everything plus the kitchen sink.  If you
>instead declare your function as taking a struct foo *, then you can
>solve the problem by simply putting a "struct foo;" declaration in
>your header, and then you don't need to #include <foo.h>.
>
>

Hmm, it seems like the real problem in this example is that the include
files are not written and/or split out well.  Isn't your "struct foo;"
example just a hack to work around that?  Or am I not getting it?
Anyway, I'll use "struct foo;"s from now on (and get rid of the
typedef's I already have).

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
