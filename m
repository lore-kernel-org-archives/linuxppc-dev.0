Date: Wed, 26 Mar 2003 20:55:08 -0500
From: Daniel Jacobowitz <drow@mvista.com>
To: Kalpesh Jasapara <kjasapara@yahoo.com>
Cc: gdb@sources.redhat.com, linuxppc-dev@lists.linuxppc.org,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: GDB server and threaded application
Message-ID: <20030327015508.GA31754@nevyn.them.org>
References: <20030326134141.GA32522@nevyn.them.org> <20030327000011.97424.qmail@web14607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030327000011.97424.qmail@web14607.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


No, --attach to a threaded application is _not_ currently supported.

On Wed, Mar 26, 2003 at 04:00:11PM -0800, Kalpesh Jasapara wrote:
>
> I believe I have the solib path set correctly and all the symbols are
> being loaded when I connect to the remote target.
>
> BTW I am able to debug core files correctly and the core files
> show all the threads. Its an issue if I try to attach to a running
> multithreaded process.
>
> gdbserver :12345 --attach <PID>, I just pick up one of the PID's of
> the multithreaded process. I guess this is supported.
>
> --- Daniel Jacobowitz <drow@mvista.com> wrote:
> > On Tue, Mar 25, 2003 at 09:39:01PM -0800, Vladimir
> > Gurevich wrote:
> > >
> > > Kalpesh Jasapara wrote:
> > > >I am having a problem with remote gdb debugging using gdbserver
> > > >to work with multi threads. The command "info threads" shows only
> > > >one thread.
> > >
> > > Here is a relevant excerpt from Wolfgang Denk's posting from
> > > ppc-embedded:
> >
> > As usual, Wolfgang's answer is somewhat biased. GDB 5.3's
> > multithreaded debug support is complete, and works very well once
> > you have it set up. The only thing missing in the FSF tree is the
> > little "[New thread 21211]" messages, which are purely cosmetic;
> > I never came to an agreement about how to implement them in the
> > current protocol.
> >
> > Neither the version originally in HHL 2.0 nor gdb 5.2.1 supported it
> > however. Kalpesh said he was trying gdb 5.3, which does.
> >
> > I would also like to offer Wolfgang a BIG KICK IN THE HEAD. I have
> > looked at the relevant path on his FTP site that you referenced
> > below; despite his name as the only name on the "ChangeLog entry" in
> > the README and the claim of "we spend some work", it is my work. I
> > wrote just about every line of that patch.
> >
> > As usual proper credit would be appreciated.
> >
> > > >in message <20020820144703.16442.qmail@web20107.mail.yahoo.com> you wrote:
> > > >
> > > >>I'm trying to debug a multi-threaded application using gdbserver
> > > >>on the remote/target side and I`m having some problems, the
> > > >>output I got is depicted below:
> > > >
> > > >
> > > >I'm not surprised. This is broken in most versions of GDB /
> > > >gdbserver floating around.
> > > >
> > > >
> > > >>I`m using gdbserver5.2.1 (I tried the one from HHL-2.0
> > > >>Journeyman and didn`t worked too) compiled by myself using
> > > >>Mvista HHL 2.0 tools and gdb 5.2.1 on my i386. Am I doing
> > > >>something wrong or remote thread debugging is not supported by
> > > >>gdb? I have read something about
> > > >
> > > >Let's say the support is incomplete :-)
> > > >
> > > >>problems with multi-thread application debugging but I thought
> > > >>that it may be OK at this time... Could someone explain to me
> > > >>what`s happening?
> > > >
> > > >Check out our ELDK (see http://www.denx.de/ELDK); it contains an
> > > >extended / bug fixed version of GDB / gdbserver; remote target
> > > >debugging of MT applications was one of the areas where we spend
> > > >some work.
> > > >
> > > >If you're just looking for the patches: these
> > > >can be found on our FTP server; the README
> > > >including description of the test procedure is at
> > > >ftp://ftp.denx.de/pub/ppc/patches/README-GDB-MT-Support

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
