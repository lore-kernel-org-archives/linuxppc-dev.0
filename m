To: Darin.Johnson@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: embedded gcc PPC toolchain questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 May 2003 00:11:37 PDT."
             <F0B628F30F48064289D8CCC1EE21B7A80C4884@mvebe001.americas.nokia.com>
Date: Fri, 30 May 2003 09:41:17 +0200
Message-Id: <20030530074122.BAD54C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <F0B628F30F48064289D8CCC1EE21B7A80C4884@mvebe001.americas.nokia.com> you wrote:
> > Actually it should be no big surprise. I  think  every  (?)  standard
> > conforming  C  compiler  will  put  uninitialized  data  into the BSS
> > segment (usually .bss in the linker scripts).
>
> Is BSS, or sections, a part of the C standard?  Lots of data ends
> up in .sbss.

No. The C standard does not mention BSS or other linker sections. But
it contains requirements that may  be  (and  often  are)  implemented
using such sections, for example:

        All objects with static storage duration shall be initialized
        (set to their initial values) before program startup.

in detail:

	6.2.4 Storage durations of objects
	...
        3 An object whose identifier is declared with external or
          internal linkage, or with the storage-class specifier
          static has static storage duration. Its lifetime is the
          entire execution of the program and its stored value is
          initialized only once, prior to program startup.
	...
        ... If an object that has static storage duration is not
        initialized explicitly, then:
	- if it has pointer type, it is initialized to a null pointer;
        - if it has arithmetic type, it is initialized to (positive
          or unsigned) zero;
        - if it is an aggregate, every member is initialized
          (recursively) according to these rules;
        - if it is a union, the first named member is initialized
          (recursively) according to these rules.
	...

One method to implement this is to put uninitialized (or better:  not
explicitly initialized) static data into a BSS segment, which will be
cleared (set to zero) befor estarting the program.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
