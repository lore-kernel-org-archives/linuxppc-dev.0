Date: Fri, 9 Mar 2001 01:26:01 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Graham Stoney <greyham@research.canon.com.au>
Cc: "Srinivas Rao.M" <msrao@vxl.co.in>,
	Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: speed and space Optimization
In-Reply-To: <20010309104703.B6166@brixi.research.canon.com.au>
Message-ID: <Pine.HPX.4.10.10103090105250.9166-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 9 Mar 2001, Graham Stoney wrote:

> On Thu, Mar 08, 2001 at 04:48:21PM +0100, Gabriel Paubert wrote:
> > -Os was faster than -O2 which was faster than -O3 for some routines.
>
> I had similar results benchmarking our application on an 855T: -Os was both
> smallest and fastest on gcc-2.95.2.  This makes sense since the I-cache on
> embedded CPUs is relatively small, and tighter/smaller code takes less time
> to fetch.  The difference between -Os and -O2 in terms of speed and space
> were only very minor.  -O3 made code larger and slower, by inlining functions
> and blowing the cache out too much; I'd strongly recommend against using it.

In my case it was on an FFT on a 603e. The code easily fitted in the cache
and did not call any other subroutine, so inlining was not an effect and I
did not see any loop being unrolled. Basically the code was only accessing
data arrays and performing fmul/fadd and fmadd FPU operations, lots of
shift and mask for addressing with powers of 2. Even in this case -Os
turned out to be better, I suspect that this is due to imperfect
scheduling by the compiler (on a 603e or 750, the rules for retirement are
fairly restrictive, much more than for issuing: the second retired can
only be integer or load, so FP followed by store blocks, like FP followed
by FP and I don't think that gcc takes these rules into account).

It was just an experiment and had no serious scientific value, but
IIRC, the higher optimization levels had a tendency to end up grouping all
the loads at the beginning of the loop, the FP operations in the middle
and the stores at the end. The compiler might be better now, I don't know.

>
> My suggestion is that the best starting point is to use -Os.

Indeed. I often compile my kernels with -Os too. A large part of the
kernel is straight inline code for which cache footprint is a very
important consideration. The few routines which have loops with large
iteration counts have been heaviliy optimized.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
