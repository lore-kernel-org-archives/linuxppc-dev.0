Message-Id: <200012131526.eBDFQaT21707@denx.local.net>
To: rabeeh@galileo.co.il
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems with powerpc-linux-gcc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Dec 2000 16:23:55 +0200."
             <3A37867B.2070606@galileo.co.il>
Date: Wed, 13 Dec 2000 16:26:36 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A37867B.2070606@galileo.co.il> you wrote:
>
> I'm having trouble with compiling some code that I will use for our
> embedded system when booting the system.

This is an old story: buggy code does not work.  I  always  have  the
same problem ;-)

> The function that I'm having trouble with is the printf function. I used

To  be  more  specific:  you  have  problems  with   _your_   (buggy)
_implementation_  of  the said function. It works fine for many, many
people.

> In the powerpc environemnt (using GNU powerpc-linux-gcc cross compiler),
> the compiler puts the arguments in registers instead of the stack ; due

Right. Which is a Good Thing (TM) to do.

> static char *do_printf(char *buf, const char *fmt, const int *dp)
> {
> ...
> }
>
>
> void printf(const char *fmt, ...)

Please note that a conforming implementation of printf() returns "int".

> {
>    char buf[256],*p;
>    p = buf;
>    do_printf(buf, fmt, ((const int *)&fmt)+1);
>    while (*p) putchar(*p++);
> }

This code is WRONG!

You MUST do something like that:

#include <stdarg.h>
...
... do_printf(..., const char *fmt, va_list args)

int printf(const char *fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	... do_printf(..., fmt, args);
	va_end(args);

	return (number_of_printed_chars);
}


... and RTFM: man stdarg(3)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"You ain't experienced..." "Well, nor are you." "That's true. But the
point is ... the point is ... the point is we've been not experienced
for a lot longer than you. We've got  a  lot  of  experience  of  not
having any experience."           - Terry Pratchett, _Witches Abroad_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
