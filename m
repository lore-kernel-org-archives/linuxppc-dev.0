Message-ID: <38436801.81D6CE60@eecs.lehigh.edu>
Date: Tue, 30 Nov 1999 01:00:33 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: Franz.Sirl-kernel@lauterbach.com, linuxppc-dev@lists.linuxppc.org,
        gcc-patches@gcc.gnu.org
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
Content-Type: text/plain; charset=iso-2022-kr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Agreed, ssh2 code isn't necessarily the cleanest in the world, but then again
the varargs situation in PPC world is a bit peculiar.


typedef struct A {
  char foo;
  char *bar;
} B[1], C[1];

typedef C D;


void tst(D d1)
{
  D d2;
  d1 = d2; // this is legal
  // d2 = d1; // this is not
}

declaring arrays of fixed size seems a bit strange for a type which will be used
by user code, since it makes d1 and d2 be different types sometimes. Not to
mention, having struct _va_list_tag  AS va_list seem to fix the problems neatly.

Is there a technical reason for keeping va_list as an array of 1 element? 
(instead of just a single element??)

-jason.


Franz.Sirl-kernel@lauterbach.com wrote:
> Am Mon, 29 Nov 1999 schrieb Jason Kim:
> >There is a problem with va-ppc.h distributed with recent versions ofgcc (2.95
> >and onwards) as well as the older egcs 1.1 releases.
> >
> >va-ppc.h typedefs va_list as an array of 1 element of struct
> >_va_list_tag but this causes problems when va_lists (or pointers to
> >them!) are passed as arguments to functions:
> >
> >e.g.
> >
> >void foo(va_list va1)
> >{
> >va_list va2;
> >va1 = va2;
> >}
> 
> The source is wrong, this code is simply non-portable. Use __va_copy(va1, va2)
> or some memcpy trickery to fix the source.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
