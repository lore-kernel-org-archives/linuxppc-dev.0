Date: Tue, 5 Dec 2000 11:13:41 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: alex@cosmo.allay.net
cc: linuxppc-dev@lists.linuxppc.org, max@trega.com
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <Pine.LNX.4.10.10012050215570.22364-100000@macachu.ex-pressnet.com>
Message-ID: <Pine.LNX.4.10.10012051046530.9367-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> okay, so to the real meat of this post. ive been having some problems with
> the opennap server. i find that the va_list functions (primarily v*printf)
> are giving me segfaults and data corruption. this, however, is *not*

Make sure you are using __va_copy to copy va_list arguments. Plus do
not expect a va_list argument to remain unchanged in the calling routine
even though you pass the va_list argument by value.

> happening on an x86 bsd machine. i have limited machines to test this on,

x86 uses a different mechanism for va_lists, which is more tolerant :-(

>     va_start (ap, fmt); vsnprintf ( buf, 1022, fmt, ap ); va_end (ap);

The va_end does nothing here...

#define va_end(AP)	((void)0)

>     va_start (ap, fmt); vprintf ( fmt, ap ); va_end (ap);

and the second va_start should just restore the initial state of ap from
the stack. Looks like it should work...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
