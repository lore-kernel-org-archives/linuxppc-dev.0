Date: Thu, 11 May 2000 00:16:44 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000511071644.ZM3969@saguaro.lan>
In-Reply-To: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>
        "who has an opinion on porting source file to Windows ?" (May 11,  1:21pm)
References: <00d901bfbb08$ce61c670$bf0102c8@dell191.sc.mcel.mot.com>
To: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: who has an opinion on porting source file to Windows ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 11,  1:21pm, Rolf Liu wrote:

> I am trying to compiling the kernel 2.2.13 under the Windows NT platform.
> The compiler is from Metrowerks CodeWarrior, command-line tool.
> there is a problem,the path separator under linux is /, but under Windows NT
> is \.
> Furthermore there is a need to translate the '<' and '>' into '"' and '"' .
> And there are so many source files in Kernel 2.2.13,also so many #include
> directives.
> Is there any good method on translating the / into \ in a batch mode?

You have a tough road ahead of you.  The path separator problem and
the other minor syntax problems that you've identified are only the
tip of the iceberg.  Even if you solve these problems, you still have
to contend with a significantly different inline assembler and uses of
features (in the kernel) that are exclusive to GNU C.  It can probably
be done, but is it really worth it?  Suppose you are successful and
you wish to apply the latest kernel patches.  You will have an ongoing
battle ahead of you to port all the new code.

The good people of Metrowerks (where I once worked) are aware of
these problems and have (at one time anyway) considered making the
necessary changes to the compiler in order to build the Linux
kernel.  I have no idea whether they are still considering this
or not, but you may wish to ask.

I do not understand why you wish to do your builds on Windows NT, but
if that is really a requirement, you'll find life much easier if you
use an NT hosted gcc which cross compiles to the PowerPC.  As Gabriel
Ricard mentioned, the Cygwin environment will help make life easier as
well.  (I think that all of those pesky path problems will vanish.)

You may find the following URLs to be useful:

    http://sourceware.cygnus.com/cygwin/

    http://gcc.gnu.org/onlinedocs/gcc_3.html#IDX347

The latter link describes the process of building and installing a
cross compiler.  You will want to make sure you have Cygwin installed
prior to attempting this however.

Kevin

--
Kevin Buettner
kev@primenet.com, kevinb@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
