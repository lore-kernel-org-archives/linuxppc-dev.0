Date: Sat, 13 Jan 2001 12:56:16 -0800
From: Keith Clayton <clay-ton@pacbell.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Fighting with Sonnet g3/l2 upgrade
Message-ID: <20010113125616.A478@yoda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

If you're out there, this question is directed toward you though anyone can
chime in.

A bit of quick history first.  Just installed a 400mhz Sonnet g3/l2 upgrade
into my umax c500.  Card is working in MacOS.  When booting via bootx I get
hda: lost interrupts.  Tried bootx versions between 1.1.3 and 1.2.2  Tried
my own kernel (2.2.18pre18) and precompiled kernels 2.2.12, 2.2.18-4hpmac
2.2.17-0.6.1 from yd site.  In all cases, same problem.  One thing that is
constant throughout is that under options for BootX the Set G3 Cache option
stays grey'd out.  Oh, Crescendo extension changed to type scri and renamed
to load before BootX.  I've tried using Cache Profiler loading after
Crescendo but before BootX with configure BootX option both on and off.

In every case, I get hda: lost interrupt

Ok, history done . . now . . I tried the G3 Cache Utility and it failed.  Said
not a G3 family processor.  I looked at the source and saw it was failing at
the cpuFamily != getstalt750 line.  So looks like the problem is that the
system isn't reporting back that a g3 is running.

A look at the bootx source shows that the Set G3 cache option will be
available only if the gestalt returns with a g3 processor.

Now my questions . . is it possible to modify the GrabG3Cache util to print
out the gestalt result to see what processor type is reported, then skip the
cpu family check so that the util proceeds and see what happens?  I'd do it
myself but I don't have CodeWarrior (or any compiler on the Mac side for that
matter).

Also, while this is probably a BAD idea, is it possible to create a BootX build
where the g_l2cr_available (i think that's right) flag is set to true from the
start so that the Set G3 cache option is available for me?  Using the
powerlogix util I can find the G3 Cache value and I can use resedit to set it
by hand in the BootX Settings file. Then maybe have a bunch of debugging
output or something.

I don't expect this to be a magic bullet or anything but I'm hoping to
understand where things are going wrong and see if it can be worked around.

Sorry to bug you Ben . . if I had CodeWarrior myself, I'd be able to do more
experimentation myself first.


Thanks for any help.  I'm sure your busy but if you could slide in a build,
that'd be fantastic.

Keith Clayton



--
<><><><><><><><><><><><>
Keith Clayton
clay-ton@pacbell.net

"If you don't trust me with your source code,
            why should I trust you with my computer?"

GPG key: http://home.pacbell.net/clay-ton/keith_public_key.html
         http://www.keyserver.net

GPG fingerprint: 0C47 F1A1 0434 588C 9457  D53F D86A 5449 43F6 09A0


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
