Subject: Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243:
	error: invalid lvalue in asm statement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Miles Lane <miles.lane@comcast.net>, linuxppc-dev@lists.linuxppc.org,
	Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <5.2.1.1.2.20030804104557.01f0fe00@mail.lauterbach.com>
References: <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
	 <200308021823.30382.miles.lane@comcast.net>
	 <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
	 <5.2.1.1.2.20030804104557.01f0fe00@mail.lauterbach.com>
Content-Type: text/plain
Message-Id: <1059990141.3232.1.camel@gaston>
Mime-Version: 1.0
Date: 04 Aug 2003 11:42:21 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-08-04 at 10:49, Franz Sirl wrote:
> >
> >No Paul, it's not your fault, if you look closely at evdev, that code
> >can't really work properly anyway.
>
> Well, his patch to get_user exposed it, but the bug is really in the very
> questionable use of the gcc extension to accept ?: expressions as lvalue,
> see <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=11564>
>
> >I talked to Vojtech at OLS and he'll be fixing that to always pass
> >either an u32 or an int to userspace.
>
> I've sent him a patch too as a result of the above GCC PR.

It's still totally wrong to access userland with a variable sized
data since my understanding is that userland doesn't know what size
the kernel will use for access here, thus it works for little endian
but not big endian (well... afaik).

Vojtech and I agreed that this should be changed into uniform use
of a single sized type (u32 or int) that gets only converted in
the kernel.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
