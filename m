Date: Fri, 10 Mar 2000 10:18:36 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Sean Harding <sharding@dogcow.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
In-Reply-To: <4.3.2.20000309152803.00ca9100@mail.munich.netsurf.de>
Message-ID: <Pine.HPX.4.10.10003100954580.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 9 Mar 2000, Franz Sirl wrote:

> But what compiler options did it use on with your compile? I downloaded it
> myself and it seems to default to a simple -O, which is a rather
> non-optimal choice. Try editing the Makefile and play with combinations of
> these options:
>
> -O2, -O3, -funroll-loops, -funroll-all-loops, -ffast-math (dunno if this
> one has an effect on PPC at all), -finline-functions, -mcpu=604, -mcpu=750

-ffast_math has some effects in the generic part of the compiler
(simplifying some expressions and constant folding) since even some
obvious mathematical relationships do not hold with IEEE floating point.
Main reasons are the existence of NaNs and the distinction between
positive and negative zeroes. (x+0 and x-0 can't be simplified, x==x may
not be true...).  -ffast-math will also replace divisions by constants
with multiplies, which may be slightly less precise but is always
significantly faster (especially on a 604).

If you don't have a 601 -fgfxopt might also help since it will generate
fsel instructions for min/max/conditional moves. fsel is unfortunately not
implemented on 601 so you can't set gfxopt for distributions.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
