Message-ID: <38445DB4.8E8E86CB@eecs.lehigh.edu>
Date: Tue, 30 Nov 1999 18:28:52 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: patch for problem with va-ppc.h included with egcs and
	  gcc-2.95.2
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com>
Content-Type: multipart/mixed; boundary="------------3D3A6DB5172826A737C0EB02"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------3D3A6DB5172826A737C0EB02
Content-Type: text/plain; charset=iso-2022-kr
Content-Transfer-Encoding: 7bit

 
--------------3D3A6DB5172826A737C0EB02
Content-Type: text/plain; charset=iso-2022-kr; name="letter2"
Content-Disposition: inline; filename="letter2"
Content-Transfer-Encoding: 7bit

There is an unforseen sideeffect to having va_list be a typedef to an array of
1 element. This strangeness comes up when passing the reference to a va_list

suppose one has the following definition of va_list (as per va-ppc.h)

typedef struct va_tag {
  char a;
  char *b;
} B[1], C[1];

typedef C va_list;


void bar(va_list* d2)
{
  printf("d2 = 0x%x\n", d2);
  va_arg(*d2); // this call FAILS
}

void tst(va_list d1)
{
  printf("d1 = 0x%x\n", d1);
  bar(&d1);    // gcc gives warning here. but no way to really ``fix it''
}

int main()
{
  va_list d3;
  printf("foo\n");
  tst(d3);
};


but at bar(), calling va_arg(*d2) fails because it is (incorrectly)
dereferencing a D*, but the desired result is of course doing *(va_tag**d2)
but doing so will fail on hosts that do NOT follow the ABI convention. (such
as Intel x86 and SPARC (!) varags, because they do not define ``va_tag'')

And in truth, the SYSVR4 ABI for PPC doc lists va_list in an example, and does
not anywhere state that va_list MUST be defined as shown in page 6-6. (your
page listing may vary, I got standards docs from google.com)

The va_list definition from the ABI seems a bit of an ad-hoc example, and
besides, when one passes an address of something, one expects to get the
``something'' back if the pointer is dereferenced. The fact that the C
language passes arrays as a pointer to the first item only adds to the
confusion. 

Also, in the ANSI C (9x) documentation (``n843''), taking the address of a
va_list is NOT listed as one of the things that will produce an undefined
result. Actually, on page 7.15 (pg246 as seen by acroread), footnote item 198
specifically states ``It is permitted to create a pointer to a va_list and
pass that pointer to another function,.. in which case the original list may
make further use of the original list after the other function returns.''

And from the various varargs.h that I've seen, its rather cumbersome to
automatically determine exactly what type a va_list really is, and whether
dereferencing a va_list* will return an unexpected result (or not). 

Not to mention, one of the first things one learns in coding image/signal
processing and matrix math stuff is, to never declare (or pass around) fixed
size arrays, which can result in broken code.

Quite frankly, I don't see a clear reason WHY the ABI shows the sample va_list
as implemented like it is, and since the result is unnecessarily unintuitive
code management which makes it difficult to do something specifically allowed
in the ANSI C standards documentation, and since there is a perfectly easy,
portable solution to this, will you reconsider the patches I sent out?

In case of a battling standards docs, one would think a compiler would chose
the language docs over an  ABI doc, don't you think?? 

-jason.


now the va_arg call fails because app is of type (va_list *) or (

Franz Sirl wrote:
> 
> At 07:00 30.11.99 , Jason Kim wrote:
> >Agreed, ssh2 code isn't necessarily the cleanest in the world, but then again
> >the varargs situation in PPC world is a bit peculiar.
> >
> >
> >typedef struct A {
> >   char foo;
> >   char *bar;
> >} B[1], C[1];
> >
> >typedef C D;
> >
> >
> >void tst(D d1)
> >{
> >   D d2;
> >   d1 = d2; // this is legal
> >   // d2 = d1; // this is not
> >}
> >
> >declaring arrays of fixed size seems a bit strange for a type which will
> >be used
> >by user code, since it makes d1 and d2 be different types sometimes. Not to
> >mention, having struct _va_list_tag  AS va_list seem to fix the problems
> >neatly.
> >
> >Is there a technical reason for keeping va_list as an array of 1 element?
> >(instead of just a single element??)
> 
> 1. this behaviour is mandated by the ABI
> 2. it nicely spots a common programming error
> 
> I see nothing peculiar about it :-).

--------------3D3A6DB5172826A737C0EB02--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
