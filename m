Message-ID: <3845D3AE.27816A0@eecs.lehigh.edu>
Date: Wed, 01 Dec 1999 21:04:30 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "khendricks@ivey.uwo.ca" <khendricks@ivey.uwo.ca>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: patch for problem with va-ppc.h included with egcs and   gcc-2.95.2
References: <Pine.LNX.3.96.991201114002.11654K-100000@deepspace.mklinux.org>
Content-Type: multipart/mixed; boundary="------------63A004F2BA4287322F7B0E00"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------63A004F2BA4287322F7B0E00
Content-Type: text/plain; charset=iso-2022-kr
Content-Transfer-Encoding: 7bit

 
--------------63A004F2BA4287322F7B0E00
Content-Type: text/plain; charset=iso-2022-kr; name="letter5"
Content-Disposition: inline; filename="letter5"
Content-Transfer-Encoding: 7bit

David A. Gatwood wrote:

> Years of legacy binaries that would have to be rebuilt, for one.  The fact
> that we _just_ had a varargs-related rework of some programs (linux
> kernel, mach kernel, etc. come to mind) for gcc 2.95.x is another reason.
> Mucking with the way the compiler builds varargs can have really nasty
> implications.  It should not be changed for trivial reasons.  The macros

Hmm. Legacy peeks its ugly head. 

Sigh. Ok, so we have one reason for KEEPING va_list as implemented on PPC, but
the thing with legacy stuff is, if you leave it alone, it doesn't get any
better. (Really!)

Funny thing is:

As far as ssh is concerned, its working FINE with my va-ppc.h patches (compiled
with gcc-2.95.2 on LinuxPPC 1999 Q3). Which is a happy accident, I am sure but
an interesting one. (and it prints messages just fine to logs, stdout etc..)
I certainly DID NOT HAVE TO RECOMPILE LIBC ON MY B&W G3.

Hmm, somebody correct me on this if I am wrong, but as far as libc (or other
libs that use va_list) is concerned, are there any places where va_list is
PASSED to-and-from user code to lib code? I don't know of any.

If not, then I believe newly recompiled stuff (such as my ssh) WILL WORK FINE
with the patches I posted, even dynlinking against older libs. (which it is
doing now, as I speak, supporting this xterm running through the ssh pipe!)  I
mean, the precompiled [snv]*printf() will use va_list in its implementation,
but the code that uses the older ones are already compiled in, and we don't
actually *pass* the different va_list structures back and forth, right?

I'll recompile xemacs-21.1.8 and gcc-2.95.2 on my LinuxPPC box with my patches
turned ON (through gcc-2.95.2 and binutils-2.9.5.xxx), linking against the
older libs, and let you guys know how it goes.  At the risk of foot-in-mouth
syndrome, I'll say now that I suspect it will be *fine*.

> are there to be used.  Attempting to do anything else with varargs breaks
> spec, 

No. For the issue I am mentioning, the specs are NOT broken by the user
code. The ANSI C (9x) draft doc specifically states that a function *can* pass
around pointers to va_lists to other functions. Just so happens that va_list
is implemented as pointers on most other platforms, and has no issues with
dereferencing (N-indirections of) them, but on PPC, they are implemented as a
fixed size ARRAY, which confuses things.

> and changing the compiler and everything ever built with it just to
> make it easier for coders to be sloppy is a bad idea (tm).

I wouldn't think passing pointers to va_lists is a sloppy, bad idea. It is a
perfectly reasonable way of doing some things. 

<grin on>

I am extremely curious as to what was going through the mind of the PPC ABI
doc writers as they were writing up the example va_list implementation. 
(whom I am told, (by Franz) are the culprits behind this hilarity)

Perhaps they were high on something, eh?? Perhaps we should draft them to
recompiling our libc and other apps that use va_list for us. 
sheesh.

<grin off>

-jason.

> David

--------------63A004F2BA4287322F7B0E00--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
