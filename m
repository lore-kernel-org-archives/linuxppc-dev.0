To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IO, ANSI vs GCC structs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 25 Jul 2003 13:47:34 EDT."
             <20030725134734.J29161@borg.org>
Date: Fri, 25 Jul 2003 21:22:47 +0200
Message-Id: <20030725192252.428EEC602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030725134734.J29161@borg.org> you wrote:
>
> How important is it to the kernel coding style that hardware be

I cannot speak for the powers that be, but...

> accessed through a structure?  Is it acceptable to do:
>
>   #define MYHW  (MY_MBAR+42)
>
>   ...
>
>   out_be32(MYHW, 0xco1df00d);

...I would not accept such code.

There is one fundamental difference: a field in a struct has a  type,
i.  e.  the  compiler "knows" how big it is (8, 16, 32, ... bits), if
special attributes apply (volatile), etc.

There is no such information with a #define like yours above.

OK, you can write

	#define FOO	((volatile uint32_t *)(FOO_BASE+FOO_OFFSET))

but this isn't really readable, is it?

Just my $0.02


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
They say a little knowledge is a dangerous thing,  but it is not  one
half so bad as a lot of ignorance.   - Terry Pratchett, _Equal Rites_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
