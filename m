Mime-Version: 1.0
Message-Id: <a05111b00b92592a276c0@[10.0.0.42]>
In-Reply-To: <20020606132356.B9152@plato.local.lan>
References: <20020606052443.A21838@pants.nu>
 <20020606132356.B9152@plato.local.lan>
Date: Thu, 6 Jun 2002 15:50:31 -0700
To: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: HFS+ support (read-only)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:23 PM -0800 6/6/02, Ethan Benson wrote:
>On Thu, Jun 06, 2002 at 05:24:43AM -0700, Brad Boyer wrote:
>>  but it can handle most standard UNIX features other than
>>  hard links, which will show up as empty files. (Don't ask...)
>
>in case anyone is curious the reason for this is because HFS+ has no
>support whatsoever for hard links.  Apple kludged around this by
>making OSX create a MacOS alias pointing to an inode number (or
>similar) this macos alias has a special magic id to it so OSX knows to
>pretend its a hard link instead of a regular file like it really is.
>MacOS aliases are of course stored entirly in the resource fork, which
>this implementation has no support for, thus hard link -> empty file.

I thought there was also a special file (completely hidden from
userland in X) which tracks all the hard links in the FS.  I'm pretty
sure something like that is necessary to truly implement hard link
semantics.  Consider what happens when a file with hardlinks gets
unlink()ed -- then all its hardlinks point at nothing.  The OS needs
a database of all files that are hardlinked, with full reverse
mappings, so that whenever a file with hardlinks is unlinked it has
enough information to replace one of the hardlinks with the real file.

(For efficiency I'd want a flag bit in the metadata of each file to
indicate that it has been hardlinked, to avoid searching the table
when deleting files that have no hardlinks.  For even more
efficiency, a direct pointer to the table entry.)
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
