Date: Tue, 12 Sep 2000 00:12:15 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint & random crashes?
Message-ID: <20000912001214.B17705@hectic.net>
References: <2F67A63DFFB1D31185D90090278CBB2D014ECF08@apmail6.chn.agilent.com> <39BD4215.6FD9B56F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39BD4215.6FD9B56F@mvista.com>; from mgreer@mvista.com on Mon, Sep 11, 2000 at 01:35:33PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Mark!

On Mon, Sep 11, 2000 at 01:35:33PM -0700, you wrote the following:

> Guys, I'm trying to recreate what you're seeing but I can't.  Definitely seems
> like something is amiss.  The NIP: 00000300 one is definitely interesting.

I always get 'kernel access of bad area' when it crashes, each time
with a different address. (They don't seem to be in any particular
range.) That's what I get if it boots, after working for some
time. Usually it doesn't -- it gets stuck when running init, as I
wrote in a previous message.

Today I think I noticed a very interesting consistency that might be
helpful. I haven't had the time to test it completely; I'll do it
tomorrow and post again. The thing is, there's a little green led on
the board saying "backup power" or something like that. If you turn
off the computer and the power supply, and leave it off for half a
minute or so, the led turns off. If you turn the computer on
afterwards and load the kernel, it loads init and you can work (until
it crashes). If you just reset the computer and load the kernel (after
uploading it via dink of course), init won't load.

I'll verify this finally tomorrow, but if you have any ideas off the
top of your head now, it'll be most helpful.

> I'm on an 8240 and i can't make it crash.  Correct me if I'm wrong, Alex
> you're using a 7400 with a 107; Hai-Tao (is that correct?) you're using a 750
> with a 107, right??  Any other info on your systems/processor boards that may
> be useful for me to know?

That's what I'm using, indeed. Nothing else to say.. The system is as
it was shipped by Motorola, with just the board switches changed as
you posted some time ago.

> It sounds like this is happening during boot up.  Is that correct?  If you get
> up, what sequence of cmds cause it to fail?  I need help recreating it here.

If I do get the kernel to run init (I always use init=/bin/sash), it
crashes after some time that I work, with no apparent consistency. I
tend to poke through /proc after I get it to boot (lots of interesting
stuff there ;-) so often it crashes when I cat one of the files. (But
cattign the same files work at other times.) At one time it crashed
when I entered a non-existent command by mistake. :-) There's some
corruption going on, it really looks to me like it doesn't have
anything to do with my activity on the box at the time.

> You're both using the toolchain and root filesystem from the MontaVista 1.2
> CDK, right?  I use the root filesystem in
> /opt/hardhat/devkit/ppc/82xx/target.  What are you using?

Truth is, I've been a bad boy -- I'm using the emdebian
cross-compilers and not CDK. (They're available as debs so they
integrate better here, that's the only reason I chose them.) It's gcc
2.95.2. I suppose I should try the CDK compilers.. Although I doubt
very much that it would make a difference.

As for the filesystem, I have a lot of stuf there, but basically I'm
using sash from CDK to test it. I also have libc and bash and such
stuff there, which I took from Debian's base.tgz for PowerPC, and
usually if sash loads I type "bash", which works.

I guess I should really try the CDK environment alone at some
point.. However, the question of init not loading still remains.

> I boot fine over NFS and with the above root filesystem on an IDE drive.  Are
> both of you using NFS?  If so, make sure that you have the "IP: BOOTP support"
> selected under the "Networking options" menu item and the "Root file system on
> NFS" on under "File systems/Network File Systems" menu item.

I'm using NFS. Obviously these two are selected, since the machine
gets its IP address and successfully mounts the filesystem and
occasionally even loads a shell for me. :-)


Thanks a lot for your efforts!


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

Wear short sleeves! Support your right to bare arms!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
