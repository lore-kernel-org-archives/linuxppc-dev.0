Date: Fri, 2 Apr 2004 19:32:26 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/Makefile wiping out /dev/null
Message-ID: <20040403043226.GO21226@plato.local.lan>
References: <20BB0EB5-841D-11D8-9FF0-000A95A07384@sands-edge.com> <20040402045027.GG21226@plato.local.lan> <BDE6B8B0-8525-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BDE6B8B0-8525-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 02, 2004 at 11:16:55PM -0500, John Whitney wrote:
>
> Can you explain the insecurity a bit more? Any ideas on a better

$$ maps to the process pid, which is not hard to predict, especially
on linux where PIDs are allocated incrementally rather then randomly.

so unless $(AS) opens its output file O_EXCL there is a race where
someone can create a symlink or hardlink to another file as
/tmp/.as.$$$$, $(AS) will then overwrite the target with its output.
(even if it unlinks the file first, thats no good unless its final
open() includes the O_EXCL flag).

short story it lets another user destroy any file you have
permissions to, if your building as root (bad idea) that means anything.

> construct that won't cause /dev/null to be erased in some cases? I
> just want a solution, it doesn't have to be the one I put in there.
> :-)

well its a good reason to never build software as root, build as a
user, then bugs like this won't break your system.

but in any event im not sure you even need -o at all..

if not then id suggest just creating the file in the object root,
where any other .o file would be build, then be sure to rm it.  since
the build root and source tree is typically not writable by other
users there isn't a security issue that way.

> Would it be possible just to do something like "$(AS) --version"
> instead, as this code is theoretically just checking for an old
> version of as?

theres a lot of crap in that output, and distros seem to like to screw
with it, so thats probably fragile.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
