Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Wed, 31 Jan 2007 07:52:48 +0100
References: <45BE4ED0.5030808@us.ibm.com> <45BFBB78.7060907@us.ibm.com>
	<45BFCC8E.4000008@us.ibm.com>
In-Reply-To: <45BFCC8E.4000008@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701310752.48632.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 January 2007 23:54, Maynard Johnson wrote:

> >>Why do you store them per spu in the first place? The physical spu
> >>doesn't have any relevance to this at all, the only data that is
> >>per spu is the sample data collected on a profiling interrupt,
> >>which you can then copy in the per-context data on a context switch.
> >=20
> > The sample data is written out to the event buffer on every profiling=20
> > interrupt. =A0But we don't write out the SPU program counter samples=20
> > directly to the event buffer. =A0First, we have to find the cached_info=
=20
> > for the appropriate SPU context to retrieve the cached vma-to-fileoffse=
t=20
> > map. =A0Then we do the vma_map_lookup to find the fileoffset correspond=
ing=20
> > to the SPU PC sample, which we then write out to the event buffer. =A0T=
his=20
> > is one of the most time-critical pieces of the SPU profiling code, so I=
=20
> > used an array to hold the cached_info for fast random access. =A0But as=
 I=20
> > stated in a code comment above, the negative implication of this curren=
t=20
> > implementation is that the array can only hold the cached_info for=20
> > currently running SPU tasks. =A0I need to give this some more thought.
>=20
> I've given this some more thought, and I'm coming to the conclusion that=
=20
> a pure array-based implementation for holding cached_info (getting rid=20
> of the lists) would work well for the vast majority of cases in which=20
> OProfile will be used. =A0Yes, it is true that the mapping of an SPU=20
> context to a phsyical spu-numbered array location cannot be guaranteed=20
> to stay valid, and that's why I discard the cached_info at that array=20
> location when the SPU task is switched out. =A0Yes, it would be terribly=
=20
> inefficient if the same SPU task gets switched back in later and we=20
> would have to recreate the cached_info. =A0However, I contend that=20
> OProfile users are interested in profiling one application at a time.=20
> They are not going to want to muddy the waters with multiple SPU apps=20
> running at the same time. =A0I can't think of any reason why someone woul=
d=20
> conscisouly choose to do that.
>=20
> Any thoughts from the general community, especially OProfile users?
>=20
Please assume that in the near future we will be scheduling SPU contexts
in and out multiple times a second. Even in a single application, you
can easily have more contexts than you have physical SPUs.

The event buffer by definition needs to be per context. If you for some
reason want to collect the samples per physical SPU during an event
interrupt, you should at least make sure that they are copied into the
per-context event buffer on a context switch.

At the context switch point, you probably also want to drain the
hw event counters, so that you account all events correctly.

We also want to be able to profile the context switch code itself, which
means that we also need one event buffer associated with the kernel to
collect events that for a zero context_id.

Of course, the recording of raw samples in the per-context buffer does
not need to have the dcookies along with it, you can still resolve
the pointers when the SPU context gets destroyed (or an object gets
unmapped).

	Arnd <><
