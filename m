From: Brad Boyer <flar@pants.nu>
Message-Id: <200002282147.QAA05378@marcus.pants.nu>
Subject: Re: HFS+ feature request
To: bdowning@wolfram.com (Brian Downing)
Date: Mon, 28 Feb 2000 13:47:46 -0800 (PST)
Cc: tas@mindspring.com (Timothy A. Seufert),
        geert@linux-m68k.org (Geert Uytterhoeven),
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200002251949.NAA09042@wolfram.com> from "Brian Downing" at Feb 25, 2000 01:49:44 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian Downing wrote:
> The filesystem isn't case-sensitive.  This doesn't bug me _that_ much, I
> suppose, but some system calls feel a little broken:
>
> % touch README
> % touch test
> % mv test readme
> mv: rename test to readme: file exists
> % mv test README
> % ls
> README
>
> The mv error is from the rename(2) system call returning -1.  Fine,
> except that in the documentation it states that if the "to" argument
> exists, it is removed first.  In a case-insensitive filesystem, I expect
> "README" to be replaced with "readme".

The official format of HFS+ does specify that the strings are compared
in a case insensitive way.  In fact, it goes further and specifies a
bunch of details about actual Unicode sequences and I really don't want
to break all of that.

> Symlinks show up as a file in MacOS.  I was hoping they would be able
> to do them as aliases, but I suppose they can't.
>
> Aliases show up a zero-length files in Unix, because all of the alias'
> stuff is in the resource fork, which I haven't been able to find a way
> to get at with Unix calls.
>
> Hard links (this is scary) make _all_ linked files show up as aliases
> to diskname:FileNodeDataXXXXX in the MacOS, where XXXXX is a number
> (inode number, or the HFS+ equivalent?).  The aliases are unresolvable,
> and the FileNodeData file does not exist.

If you can give me an image of an HFS+ filesystem with some of this UNIX style
stuff, I can enable that stuff in the linux driver as well.  The official
spec doesn't say much about the permissions, ownership, devices, etc.  It
just says that they will be supported, and reserves a block for UNIX style
info like device numbers and uid/gid.  I figured I'd ignore that stuff until
I could get more info about the way OSX would handle it.

Just in case anyone is wondering, I have some preliminary code that a few
other people are helping me with, but I'm swamped at work and haven't had
much time.  Volunteers are much appreciated.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
