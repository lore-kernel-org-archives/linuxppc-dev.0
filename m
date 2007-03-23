Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 24 Mar 2007 06:38:23 +1100
Message-Id: <1174678703.10836.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Akinobu Mita <mita@fixstars.com>, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-23 at 13:56 +0100, Segher Boessenkool wrote:
> > GCC may generate inline copy loop to handle memcpy() function
> > instead of kernel defined memcpy() with -mstring or -Os.
> > But this inlined version of memcpy() caused an alignment interrupt
> > when copying from SPU local store on PS3.
> > (http://ozlabs.org/pipermail/cbe-oss-dev/2007-March/001348.html)
> >
> > This patch deletes -mstring option on all powerpc and force -mno-string
> > option on Cell.
> 
> Please split into two patches, the first half (deleting
> -mstring) we can all agree on and "the other half".
> 
> What your patch does is setting -mno-string for all files
> if your kernel is configured to support Cell.  It would be
> better to set this option (and all other options needed,
> -mno-multiple and -mno-algebraic come to mind, and that last
> compiler option doesn't even exist yet) unconditionally on
> the few Cell-specific files that are affected, not on the
> whole kernel:
> 
> 	CFLAGS_whatever.o := -msome-flags
> 
> It would be even better to not lie to the compiler by
> telling it it can use the LS area as normal memory, since
> evidently it cannot :-)

It's fair enough to use -mno-string overall. If the kernel is going to
run on cell, performance will suck with string instructions. In fact,
I'm not sure they are worth having on anything anyway.

Ben.
