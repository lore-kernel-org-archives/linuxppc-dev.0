From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15374.39089.18825.865506@argo.ozlabs.ibm.com>
Date: Thu, 6 Dec 2001 08:59:13 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>,
	Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes to PPC Linux required for GCC 3.1
In-Reply-To: <20011205175038.27184@smtp.adsl.oleane.com>
References: <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net>
	<20011205175038.27184@smtp.adsl.oleane.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:
> >
> >I think the reason this wasn't applied is that Paul said something about
> >thiws being horriyingly ugly.  Corey, can you post a patch that changes
> >RELOC(x) into a function and nothing else? :)
>
> I prefer this beeing resolved at compile time. The reason Paul didn't want
> it at first is because he didn't want a workaround for a pre-release gcc
> bug. Since this is becoming a "feature", it makes sense to get the
> workaround. Paulus will confirm or not what I'm saying though...

Actually, I'm annoyed that gcc thinks it can do something different
from what I have written.  If I wanted it to call memcpy instead of
strcpy, I would have written memcpy.  If I put in a call to strcpy, I
want the compiler to generate a "bl strcpy" instruction (assuming I
haven't declared strcpy to be inline of course).

This is the kernel, where we don't have a standard libc, and I would
much rather gcc didn't assume that it knows the semantics of things
like strcpy().  Does -fno-builtin achieve that effect?

Maybe the thing to do is to side-step the problem by having an extra
entry point for strcpy, called string_copy or something, and call that
instead of strcpy.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
