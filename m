Message-Id: <200001240802.JAA26827@denx.local.net>
To: dony <dony.he@huawei.com.cn>
cc: Wolfgang Denk <wd@denx.de>, Brendan.Simon@ctam.com.au,
        Grant Carter <gcarter@eng.uct.ac.za>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile dynamic apps for mpc860 on ix86
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Jan 2000 14:16:03 +0800."
             <388BEE23.A42DFCB5@huawei.com.cn>
Date: Mon, 24 Jan 2000 09:02:13 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dony,

you did not get my point:

In message <388BEE23.A42DFCB5@huawei.com.cn> you write:
>
> > > Yes.  I have successfully built glibc-2.1.1 and glibc-2.1.2 with egcs-1.1.2 and binutils-2.9.1.0.19a.
> > > I have copied all the shared libraries to my nfs root filesystem under /lib.  I still get segmentation faults when I try to
> > > run the dynamic application.  Arghh !!!  This is so annoying.
> >
> > Make sure you use ONLY files compiled in your  new  environment,  not
> > ANY files that might exist from older versions in your NFS tree.
> >
> > Make sure the shell you are running is statically linked!
>
> Not needed. Both my shell (sash) and my test app can run dynamically.

Then what do you complain  about  segmentation  faults  when  running
dynamically linked applications???

> > The easiest way to test this is to copy all relevant files to  a  new
> > place (say, /test/bin and /test/lib) and then test with "chroot /test".
>
> In a cross-compile environment, It is impossible to do so.  i.e., You can not run any apps for Powerpc on X86 box.

I did not say you should try. Sorry, I thought at  least  *this*  was
obvious.


Ok, once more in detail:

1. Get your PPC target running with the root filesystem mounted  over
   NFS with a known set of working tools (shell, libraries, ...). For
   instance, you can start with the files from the `mbxroot.full.tgz'
   tarball.

2. Put all your new binaries and libraries in  a  separate  directory
   tree.

3. Run a statically linked shell on your PPC  target.  You  may  also
   want to have some more statically linked tools available.

4. Do a "chroot" to your separate directory tree  with  the  binaries
   and  libraries  you  want to test. Try to execute some dynamically
   linked binaries.

5. Fix the problems.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have the simplest tastes.  I am always satisfied with the best.
                                                       -- Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
