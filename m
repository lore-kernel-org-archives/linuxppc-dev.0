Message-ID: <39935D73.6B81DD4F@motorola.com>
Date: Thu, 10 Aug 2000 20:57:07 -0500
From: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Versions of Glibc and GCC Status
References: <3992EAE6.27CF4490@motorola.com>
		 <v03110703b5b8b78dd59f@[216.209.101.72]> <v03110700b5b8cf9c9c55@[216.209.101.72]> <39933FA2.F37E7897@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin,

Your suggestions paid off.  I found in my Application that the
LIBC "fork" functions were being called instead of the "fork"
Wrapper Functions that are provided by LinuxThreads.  This
was due to the fact that in my LINK Specification I had the
LIBC (-lc) prior to LinuxThreads (-lpthread) in the Library
Search Order.  I modified the LINK Specification for LinuxThreads
to be the first Library, and now things are working !!!!!

Thanks a lot --- You saved me much time and grief !!!!!

I still plan on working on the migration of the latest
LinuxThreads and GLIB to PPC.  This is due to the bugs, and
corresponding fixes, that I have seen identified on the GNU
and LinuxPPC Development Lists.  I am going to run into the
bugs eventually, so I might as well address them now...

Once again, THANKS !!!!!

Jeff




Jeffrey Hawkins wrote:
>
> Kevin,
>
> FYI... Below is a response from one of the GNU Developers who has
> fixed a number of "fork" and "lock" issues in GLIB 2.1.3.  Although,
> the response was a little off in some areas as it pertains to my
> particular Threads Issue, the information is stil relevant, and I
> thought it might be of some interest to yourself, Franz, and others.
> The Developer is Kaz Kylheku, kaz@ashi.footprints.net.
>
> As far as my next steps, I will investigate your suggestions,
> as well as, attempt to migrate the latest GLIB LinuxThreads
> into LinuxPPC GLIB-2.1.3-15d+ (along with your latest fixes).
> After that, if things still are not working well, then I will
> continue with my adaption of the latest 2.1.x - 2.2.x GLIBs
> to PowerPC (rather than waste my time making major changes
> to this 3rd Party Package that is eventually going to be
> eliminated).  So, maybe I can help you guys out with speeding
> up your adaption of GLIB to PPC - my need for this is ASAP...
> I have the latest BINUTILS, MAKE, and the latest GCC from
> Franz's FTP.
>
> Thanks for the help...
>
> RESPONSE:
> On Wed, 09 Aug 2000 13:32:26 -0500, Jeffrey Hawkins
> <Jeffrey.F.Hawkins@motorola.com> wrote:
> >Has anybody ran into a problem with trying to create
> >a Thread from a Child Process ?  I am currently adapting
> >a Software Package, that does this, from AIX to LinuxPPC.
> >I am encountering a problem where the Thread is created,
> >but the Pthread_Create Call never returns to the invoking
> >Child Process.
>
> Not long ago I did a code inspection to specifically look for fork()
> related
> problems in LinuxThreads and ended up fixing a bunch of bugs.  These
> bugfixes
> are not available in any glibc release (other than the 2.1.91 and 2.1.92
> beta
> test releases) but they probably fix the problem you are having.  The
> fixes
> address the global locks in libio, the pthread_atfork global lock itself
> and
> the lock used by pthread_once.  (Now, if a fork() occurs while a
> pthread_once
> callback is in progress, then in the child, the behavior will be as if
> that
> initialization never took place).
>
> The main problem in 2.1.3 and older is that some global locks are not
> taken
> care of correctly at fork() time so the child process can inherit
> certain locks
> in a bad state.  It is possible that your child process is deadlocking
> on one
> of these locks.  Or possibly, there is something wrong with the child's
> new
> thread manager.
>
> Note that according to POSIX, the child of a multithreaded process can
> only
> execute async-safe library functions, so strictly speaking, what you are
> doing
> is not well-defined. However, it is *intended* to work and so it is a
> bug
> if it does not.
>
> >I am currently running a 2.1.3 version of the GLIBC,
> >which has some other Threads Fixes, but nothing related
> >to my problem...
>
> Sadly, fork() and threads simply do not mix very well in glibc 2.1.3 and
> older.
> See if your problem goes away if you use the latest pre-2.2 test
> release. If
> not, then you should submit a bug report.
>



"Kevin B. Hendricks" wrote:
>
> Hi,
>
> >However, my Thread Problem is not related to the recent fixes
> >discussed on the LinuxPPC List.  The Thread Problem I am having
> >is that when a Child Process attempts to create a Thread, the
> >Thread is created and executes, but the Child Process hangs in
> >the "pthread_create" (NOTE: Only the Child Process is creating
> >threads, not the Main Application Parent).  I don't really like
> >how this Application Package functions, but I don't have much
> >choice, since it is a 3rd Party Application Package that we
> >are using, that I am porting from AIX to LinuxPPC.  I have
> >modified this first Application executable to be
> >a single process with multiple threads - Everything works.
> >But, there are several other executables that have the
> >same Child Process with Threads Architecture, which I
> >just don't have the Project time to change (since the
> >changes ripple through other Package areas).  Thus,
> >I am turning to the updates and fixes to GLIB, which are
> >suppose to correct this issue, as well as, other issues.
>
> I saw that fork was wrappered in the glibc linuxthreads library.  Have you
> looked at the wrappering to see what it does?  Also, you might want to put
> a breakpoint there to check if the wrappered fork is being invoked at all
> if the first thread related thing being done is that a child is making all
> the threads.  Perhaps, it is calling the fork in glibc and not the fork
> inside linuxthreads.  The first call to a linuxthreads routine should
> initialize things in the pthread library.  As a hack you might want to try
> creating and destroying a mutex or a thread in the parent process before
> the fork to make sure the wrappered fork is actually being done properly.
>
> >Can I infer from your statement about the committal of your
> >changes to the GLIBC CVS Tree that GNU GLIBC 2.1.91 Version
> >should be PowerPC compatible ?
>
> It will be eventually but right now I can not get glibc 2.1.92 to pass make
> check (also had to upgrade to make 3.79.1 just to get it to build.  I don't
> think it is ready for prime time on ppc yet, but Franz, and Jack, and I
> will probably be looking at it soon.  Franz did mention that you need the
> very latest binutils (H.J.Lu's versions) and Franz's latest gcc to even get
> it to compile properly.
>
> Take care,
>
> Kevin

--
********************************************************

Jeffrey Hawkins

Senior Staff Software Engineer
Motorola Wireless Data Solutions Engineering

Address: DEPT:  DQ525
         MS:    IL-02-1055A
         1301 East Algonquin Road
         Schaumburg, IL 60196

Phone:   (847)576-7463
FAX:     (847)576-7737

********************************************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
