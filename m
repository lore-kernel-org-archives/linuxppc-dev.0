Date: Tue, 24 Jul 2001 11:21:00 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: userspace button controls
Message-Id: <20010724112100.6e00124c.jpgarcia@execpc.com>
In-Reply-To: <Pine.LNX.4.33.0107241730190.1912-100000@opal.biophys.uni-duesseldorf.de>
References: <20010724015531.516c9985.jpgarcia@execpc.com>
	<Pine.LNX.4.33.0107241730190.1912-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Jul 2001 17:36:55 +0200 (CEST)
Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
> You're talking about PMU_IOC_SET/GET_BACKLIGHT? Thanks for breaking pmud
> :-) Please make that a config option, or get Stephan Leemburg to change
> pmud before this leaks into kernels built for the unsuspecting user.

Oh yeah.  That's right. ^_^;  When I get the time, I'll see what I can do.  The patches are for testing purposes.  As Franz pointed out, there are a few things that need to be done before anything can be fully merged.  I presume that since the fbdev ioctl can be used by others, whomever is in charge of that might prefer a slightly different name or parameter.  (still need to contact them)  So it will probably be a bit.. maybe.  I'd rather that the api propagates finality in the kernel before it even hits general user userspace.  that involves finalizing the new keys and the fb.h's ioctl afaik.

In the meantime, kernel space coexistance of the two would be nasty.  I coded this thinking i need cleaner code over maintaining the older code links in the kernel.

fblevel command also uses pmu.

For testing, a 'if(ioctl(pmu,...)<0) ioctl(fb,...);' should work for compatibility, taking with the -EINVAL ioctl failure my patch would generate.  Probably put the fb's ioctl in an #ifdef (IOCTL NAME) so it still compiles elsewhere.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
