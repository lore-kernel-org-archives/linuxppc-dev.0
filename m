From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Jason Kim <jwk2@EECS.Lehigh.EDU>, gcc-patches@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
Date: Mon, 29 Nov 1999 23:45:33 +0100
Content-Type: text/plain
References: <3842EA0B.35AA0D6A@eecs.lehigh.edu>
In-Reply-To: <3842EA0B.35AA0D6A@eecs.lehigh.edu>
MIME-Version: 1.0
Message-Id: <99112923524100.06062@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mon, 29 Nov 1999 schrieb Jason Kim:
>There is a problem with va-ppc.h distributed with recent versions ofgcc (2.95
>and onwards) as well as the older egcs 1.1 releases.
>
>va-ppc.h typedefs va_list as an array of 1 element of struct
>_va_list_tag but this causes problems when va_lists (or pointers to
>them!) are passed as arguments to functions:
>
>e.g.
>
>void foo(va_list va1)
>{
>va_list va2;
>va1 = va2;
>}

The source is wrong, this code is simply non-portable. Use __va_copy(va1, va2)
or some memcpy trickery to fix the source.

>p.s. gcc-2.95.2 and the latest binutils seems to disagree on what the proper
>target name is for linking... more on this as it develops..

You need binutils-2.9.4.0.8 or later for gcc-2.95.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
