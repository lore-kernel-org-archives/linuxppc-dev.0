Subject: Re: PPC FPU handling [was: Re: NaN patch]
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Keith Whitwell <keith_whitwell@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org, devel@xfree86.org,
	Brian Paul <brian_e_paul@yahoo.com>,
	"mesa3d-dev@lists.sourceforge.net" <mesa3d-dev@lists.sourceforge.net>,
	"Torrey T. Lyons" <torrey@mrcla.com>
In-Reply-To: <3BFA7A67.79E95609@yahoo.com>
References: <a05101008b81db33a53db@[216.86.206.219]>
	<3BF9667F.747AD52@yahoo.com> <3BF8314B.95111448@yahoo.com>
	<3BFA1ADD.8B8E8F29@yahoo.com>  <3BFA7A67.79E95609@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 19 Nov 2001 18:02:18 +0100
Message-Id: <1006189338.32090.0.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2001-11-20 at 16:44, Keith Whitwell wrote:
> Keith Whitwell wrote:
> >
>
> > >
> > > I'd consider adding NaN-checking code to the indirect rendering path,
> > > since it's slow anyway but am hesitant to add it to client-side (and
> > > hardware) code for performance reasons.
> > >
> >
> > Well rather than doing this, can we isolate where the bug is and wrap that
> > section in START_FAST_MATH/END_FAST_MATH.  I'm pretty sure this sort of
> > explicit NaN checking isn't in the SI, and if you think about what code is in
> > the indirect path but not the direct path, it doesn't add up to much -
> > certainly not worth this heavyhanded approach.  Alternately there might be
> > some code that could be slightly tweaked to avoid the crashes.
> >
>
> OK.  There is no implementation of START_FAST_MATH/END_FAST_MATH for PPC (this
> is a macintosh-specific problem).

No, it's not. :) But it's funny you mention this, the following code in
mmath.h doesn't look right to me:

/* The mac float really is a float, with the same precision as a
 * single precision 387 float.
 */
#if defined(macintosh)
#define HAVE_FAST_MATH
#endif


Shouldn't that rather be #if defined(__powerpc__) ?


>  One is required for this and every
> architecture which runs Mesa, otherwise there is a need for a check on every
> single float that comes into the api, which is in the squillions.  Have a look
> at mmath.h in xc/extras/Mesa/src, and try and do something similar.
>
> The big requirement is to turn off the ieee inf/nan exceptions (on the x86 we
> also stop the fpu keeping excess precision).  Turn the exceptions off in
> START_FAST_MATH (and back to their original state in END_FAST_MATH) and your
> problem should go away.  The documentation of these macros only talks about
> precision in 3.4.2, but is accurate in 4.0.


Also, further down:

#if defined(__i386__) || defined(__sparc__) || defined(__s390x__) || \
    ( defined(__alpha__) && ( defined( __IEEE_FLOAT ) || !defined( VMS )
) )
#define USE_IEEE
#define IEEE_ONE 0x3f7f0000
#endif


Shouldn't these be defined for __powerpc__ too, or isn't the PPC FPU
IEEE conformant (or what do these defines mean anyway)?


Looking forward to any insights...


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
