Date: Thu, 6 Jun 2002 13:23:56 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
Subject: Re: HFS+ support (read-only)
Message-ID: <20020606132356.B9152@plato.local.lan>
References: <20020606052443.A21838@pants.nu>
Mime-Version: 1.0
In-Reply-To: <20020606052443.A21838@pants.nu>; from flar@pants.nu on Thu, Jun 06, 2002 at 05:24:43AM -0700
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 05:24:43AM -0700, Brad Boyer wrote:
> but it can handle most standard UNIX features other than
> hard links, which will show up as empty files. (Don't ask...)

in case anyone is curious the reason for this is because HFS+ has no
support whatsoever for hard links.  Apple kludged around this by
making OSX create a MacOS alias pointing to an inode number (or
similar) this macos alias has a special magic id to it so OSX knows to
pretend its a hard link instead of a regular file like it really is.
MacOS aliases are of course stored entirly in the resource fork, which
this implementation has no support for, thus hard link -> empty file.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
