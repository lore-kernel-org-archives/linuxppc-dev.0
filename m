Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Thu, 6 Jun 2002 23:25:43 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
Subject: Re: HFS+ support (read-only)
Message-ID: <20020606232543.C9152@plato.local.lan>
References: <20020606052443.A21838@pants.nu> <20020606132356.B9152@plato.local.lan> <a05111b00b92592a276c0@[10.0.0.42]>
Mime-Version: 1.0
In-Reply-To: <a05111b00b92592a276c0@[10.0.0.42]>; from tas@mindspring.com on Thu, Jun 06, 2002 at 03:50:31PM -0700
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 03:50:31PM -0700, Timothy A. Seufert wrote:
> I thought there was also a special file (completely hidden from
> userland in X) which tracks all the hard links in the FS.  I'm pretty
> sure something like that is necessary to truly implement hard link
> semantics.  Consider what happens when a file with hardlinks gets
> unlink()ed -- then all its hardlinks point at nothing.  The OS needs
> a database of all files that are hardlinked, with full reverse
> mappings, so that whenever a file with hardlinks is unlinked it has
> enough information to replace one of the hardlinks with the real file.

i don't know about that, maybe.  to be honest it would not surprise me
if apple just let that break.

> (For efficiency I'd want a flag bit in the metadata of each file to
> indicate that it has been hardlinked, to avoid searching the table
> when deleting files that have no hardlinks.  For even more
> efficiency, a direct pointer to the table entry.)

you cannot use the word efficient to describe this puke inducing
kludge.  the efficient way is to design the filesystem properly to
begin with, which apple did not do with HFS+.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
