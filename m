Message-ID: <3A68BC37.966A1135@mc.com>
Date: Fri, 19 Jan 2001 17:14:15 -0500
From: Andy Johnson <andyj@mc.com>
MIME-Version: 1.0
To: gcc-bugs@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Issue with small struct return values
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Excerpt from the PPC SVR4 ABI:
---
Functions shall return float or double values in f1, with float values rounded to single
precision. Functions shall return values of type int, long, enum, short, and char, or a
pointer to any type as unsigned or signed integers as appropriate, zero- or sign-extended
to 32 bits if necessary, in r3. A structure or union whose size is less than or equal to 8
bytes shall be returned in r3 and r4, as if it were first stored in an 8-byte aligned memory
area and then the low-addressed word were loaded into r3 and the high-addressed word
into r4. Bits beyond the last member of the structure or union are not defined.
---

The GCC compiler for powerpc-sysv (or any variant except powerpc-solaris) is not
doing this.  Instead, it always passes a pointer to a receiving struct area in r3, regardless
of its size.  We are trying to support two different compilers on our system, one being
GCC and the other being a commercial compiler (which comes as part of a larger
IDE which we would like to offer to our users), which claims to support the PPC
EABI.  The commercial compiler is using the r3,r4 convention, which means that it
cannot use the div or ldiv library routines which have been built using the GCC compiler
(or any other library entry points which return small structs).

I would claim that the GCC compiler is not in conformance with the SVR4 ABI, even
though it claims to support it.  Have other users encountered this situation?  Is there
any thought about bringing GCC in line with the SVR4 ABI requirement?  Among
other things, it would make the code run faster, especially with optimization enabled.

Obviously, such a change would require a complete re-build of all binary files built
with GCC, regardless of the language being translated, since both caller sites and
callee sites involving small structs (<= 8 bytes) would be affected.

-AndyJ
--
E. Andrew Johnson               Tel: 978-256-0052 x1482
Mercury Computer Systems        Fax: 978-244-0520
199 Riverneck Road              andyj@mc.com
Chelmsford, MA 01824-2820       http://www.ma.ultranet.com/~andyjnsn


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
