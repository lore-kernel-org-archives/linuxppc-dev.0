Date: Mon, 11 Sep 2000 13:32:00 -0700
From: Dan Foster <dsf@gblx.net>
To: Todd Lipcon <tlipcon@mercea.net>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Roles for distributions
Message-ID: <20000911133200.A20561@gblx.net>
References: <v03110706b5e196db363a@[64.229.14.120]> <Pine.LNX.4.10.10009111558170.25787-100000@mercea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009111558170.25787-100000@mercea.net>; from tlipcon@mercea.net on Mon, Sep 11, 2000 at 04:01:57PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hot Diggety! Todd Lipcon was rumored to have wrote:
>
> Anyway- I am a fairly decent C, C++, and Java programmer. I'd love to be
> able to contribute to the Linux/PPC effort, however I don't even know
> where to start. Most of the projects that are large enough to actually
> need patches to run correctly on PPC are so large that they are inherently
> intimidating to one not familiar with the source. Do any of you veteran
> hackers have suggestions for the contribution-newbie? What projects are in
> the largest need of help, and how can someone who has never seen their
> source get into the flow of helping out?

Suggestion.... learn the kernel before you tackle arch-specific issues.

Alessandro Rubini's book (_Linux Device Drivers_, wasn't it?) is *excellent*
for a nice introduction to the kernel from a kernel programmer's perspective.

Also look through any UNIX OS textbooks. I love my copy of the Vahalia book
because it covers all areas of the UNIX kernel well, and treats us to a case
by case comparison of how several different UNIX OSes handles it. Digital UNIX,
AIX, FreeBSD, Solaris, ...

Then, usually very helpful to also just read (and re-read and re-read even
more) various kernel source files... a couple key directories. It may be
about 110 MB uncompressed, but sheer majority of that is for device drivers.
The actual kernel core stuff is *MUCH* smaller.

Try writing some kernel modules, like ones in the Rubini book, even if they're
'dummy modules', just so you get a feel for things.

Then when you're feeling more comfortable with the UNIX kernel itself -
then start digging into all the files in arch/ppc/* as well as read
linuxppc-dev (or the online archives) to get an appreciation of arch-specific
issues.

Endianness is one *big* one - lots of times, people in x86 world will release
drivers that assumes the x86 endianness without thinking to use macros that
will automagically ensure correct byte order for whatever platform you use.
This issue bites the other platforms, too.

Then of course, we have the PPC hardware stuff. OpenFirmware docs are *great*
to read... looking at how the boot loader does it will tell you a thousand
things about how things actually *happen* in the dark ages before a kernel is
booted. It's a little work, but you can usually eventually manage to dig up
hardware tech docs for various chips, so that one knows how to manipulate them.
For example, the Motorola web site has PDF files on the CPU and the memory
controller (ie MPC106 aka "Grackle").

IMO, if you can understand a boot loader, you've probably taught yourself a lot
of the concepts needed to understand hardware at a low level, and how/why
the kernel is structured the way it does for the arch-specific stuff. It's also
(IMO) one of the most interesting pieces of software, too.

And so on... lots of stuff that you can indeed do. I've been doing all of
the above (why dispense advice if one doesn't take one's own advice, eh?) for
a while now and it's been a rather pleasant, interesting, and fun journey
into the innards of Linux for the PowerPC family.

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
