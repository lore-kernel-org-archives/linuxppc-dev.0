From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Val Henson <val@nmt.edu>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Sun, 24 Mar 2002 18:18:03 +0100
Message-Id: <20020324171803.1747@smtp.wanadoo.fr>
In-Reply-To: <20020324165546.18197@smtp.wanadoo.fr>
References: <20020324165546.18197@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>BTW, I just thought of something different: some people want to keep data
>>stored in bi_recs for later use, after the initialization of the
kernel. What
>>about a new tag to mark data that is to be copied and stored for later use?
>
>Currently, I plan to keep everything. Though if we decide to put some
>flag bits in the high part of the size field, we could specify what
>to keep and what to strip.

Ok, rather that hacking flag bits, which I want to avoid, what about
that: we define an optional BI_PERSISTENT tag. Any bi_rec _before_
that tag is lost after __init (typically cmdline, initrd, informations
used in *_setup). Any bi_rec after this tag is kept around. Tyîcally,
this means those bi_recs are copied to separate pages (this will
typically be BI_DEVICE recs). If you want, you can put them before
BI_PERSISTENT and build your drivers in. If you prefer using modules,
you can put your BI_DEVICE entries after it.

An important point about bi_recs is that they shouldn't contain
pointers to other things within bi_recs. They can (and will) be
moved around, so unless explicitely defined (like initrd ptrs),
no pointers in bi_recs.

Again, all of this is just a small superset of the existing mecanism
with a few utiliy functions for kernel code and drivers to locate
bi_rec's by tag, either globally or within another bi_rec (that
is typically BI_DEVICE). The point is that once this is coded, I
expect bd_t & other various facilities used by bootloaders to go
away, or at worst be moved to the wrapper.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
