Subject: Re: Journeyman configure/build options for gcc & glibc?
To: jgreen@mvista.com (Joe Green)
Date: Thu, 17 Aug 2000 13:16:30 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <00081611524600.29732@minotaur.mvista.com> from "Joe Green" at Aug 16, 2000 11:44:29 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000817031630.9089F238@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Joe,

On Tue, 15 Aug 2000, Graham Stoney wrote:
> I thought I had the whole soft-float thing on 8xx worked out long ago, until I
> upgraded our root filesystem to the one from MontaVista's Journeyman kit, and
> found that my glibc-2.1.3.so (which my binaries work when linked against)
> doesn't work in place of the Journeyman glibc-2.1.2.so.  It's the usual
> symptom: A simple floating-point printf gives the wrong answer.

Joe Green writes:
> I recall the printf problem as something we specifically fixed.  I
> asked the engineer who worked on it, and he said it was a varargs
> problem, so the fix is in the the gcc package.

Thanks for the response.  I tried upgrading my root filesystem from Journeyman
to 1.2, and now binaries built with my compiler work correctly with the HHL1.2
libraries.  I never saw any varargs problems between my gcc-2.95.2 and
glibc-2.1.3 once the other 8xx fixes were applied (the same ones that are
now in the 1.2 SRPMs), so perhaps whatever got "fixed" in Journeyman was a bad
mod that got backed out again for 1.2.

Anyway, I'm happy.  My only gripe about the otherwise excellent Hard Hat kit
is the ugly symlink from /opt/hardhat/devkit/ppc/8xx/powerpc-linux -> /
which is necessary on the _target_.  If you added the following after
-dynamic-linker in the gcc specs file, this wouldn't be necessary:
    --rpath /lib --rpath-link /opt/hardhat/devkit/ppc/8xx/powerpc-linux/lib

Then the cross-compiled binaries will look for their dynamic libraries in
/lib on the target, rather than /opt/hardhat/devkit/ppc/8xx/powerpc-linux/lib.

(Well, actually I'm not thrilled with the gcc/cccp.c relocation hack either;
 this sounds like a job for configure --prefix to me, but aside from that I'm
 happy :-)

Keep up the good work!

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
