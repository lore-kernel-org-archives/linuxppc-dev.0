Date: Tue, 2 Feb 1999 16:29:14 +1100
Message-Id: <199902020529.QAA03214@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: frank@mitre.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <36ACDDB2.6DA8ACA7@mitre.org> (message from Frank McPherson on
	Mon, 25 Jan 1999 16:10:12 -0500)
Subject: Re: xmon, BAT structure, etc.
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <36ACDDB2.6DA8ACA7@mitre.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank McPherson <frank@mitre.org> wrote:

> xmon doesn't seem to exist in the linuxppc sources any more and I'm
> having trouble getting the one from the linuxppc.org 2.1.24 sources to
> compile with 2.2.0-pre5, which is the latest version I was able to pull
> from vger's anonymous cvs before it started always refusing connections.
>   Where can I get it, or something equivalent?  What's the best way to

I suggest you get a copy of my tree by anonymous rsync from
samba.anu.edu.au::linux-pmac-devel.  Look at http://rsync.samba.org/
if you need more information about rsync.

> I'm working on getting linux up and running on a non-prep, non-pci VME
> board with a 603e and having some trouble with it.  I've got the kernel
> uncompressing down to where it should be, but it traps when it gets a
> bit of the way in to init/main.c.  When I write the contents of the BAT
> structure to dual port RAM on the VME bus, I get all zeros, leading me
> to believe I'm not setting thins up correctly down in the
> platform-specific sections.  

It could be just that the RAM is set for write-back caching and the
values are still in the cache.  (Write-back caching is the default
when the data MMU is disabled.)  You can use the dcbst instruction to
make sure the stuff you write gets flushed to memory.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
