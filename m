Message-ID: <19981207200522.A4510@tiktok.cygnus.com>
Date: Mon, 7 Dec 1998 20:05:22 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Ralf Weidemann <RalfW@Scalar.de>,
        LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EGCS 1.1.1 FYI
References: <schinder@pobox.com> <199812071128.GAA01786@smtp2.mindspring.com> <9812071511.AA34514@marc.watson.ibm.com> <13932.21810.162591.80793@onyx.nowhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13932.21810.162591.80793@onyx.nowhere.net>; from Ralf Weidemann on Mon, Dec 07, 1998 at 11:22:42PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 07, 1998 at 11:22:42PM +0100, Ralf Weidemann wrote:
> 
> >>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:
> >>>>> "Paul J Schinder" writes:
>     Paul> So are Gary Thomas' patches still necessary?
> 
>     David> 	The trampoline patch now has become a shared library
>     David> compatibility issue for glibc-1.99 support.  It only is
>     David> necessary until LinuxPPC cuts over to glibc-2.1 which will
>     David> require other binary incompatible changes at the same time.
> 
> Can someone clarify where the problem is exact with native
> egcs and libc-1.99 ? I use egcs-1.1.1 since the weekend and
> it seems to work fine. I had no trouble to build some shared
> lib stuff like in the latest jade or sgml-tools. This packages
> didn't compile with older version I tried (also Gary's egcs-1.1b),
> but that were generell compiler issues, I think.

There is a difference of opinion on the difference of the size of the
instruction block for trampolines coupled with a coding error in the trampoline
support module.  Some version of the compiler other than the egcs/fsf compiler
has upped the size of the trampolines to be larger than the 40 bytes checked
for, and the tramp.asm module check for too small of a block aborts due to the
test being backwards.  If you don't use trampolines (including running the
compiler testsuite), you won't see the problem.  If you don't know what
trampolines are then you probably aren't using them.

<arrogant opinion>
Trampolines are a botch, and I have encounted problems with them in just above
every single GCC platform I have worked on in the last 9 years, but RMS loves
them, so they have remained.  What they are is a chunk of stack that the
compiler puts instructions to load up the static chain, and jump to the real
function in the location.  This address is then passed when you take the
address of a nested (lexically scoped) function.
</arrogant opinion>

> But on the other side I also tried to run the SeaMonkeyBrowser
> (Mozilla) from recent cvs-sources. Building went fine, but the
> beast didn't run. I get only a simple "Aborted" message on the
> console and it seems to crash somewhere in the startup code.
> So maybe this is somehow related ?

If SeaMonkeyBrowser calls through a trampoline inside of static constructors,
then yes, this is a symptom.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
