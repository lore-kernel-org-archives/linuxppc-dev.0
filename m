Date: Tue, 28 May 2002 20:54:28 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: IBM java: Turning on SMP seems more and more likely the key
Message-Id: <20020528205428.23b9a61b.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue May 28 2002, Graham Leggett wrote:

> James Gunning wrote:
>
> >          Have just verified that toggling SMP *on* is the critical
> > switch to get the IBM java to go.
>
> Had the same result here: SMP kernel + java = works.
>
> Trouble is the SMP kernel is noticably slower than the non SMP kernel on
> non SMP systems.

My best guess is that the bug is somewhere in /usr/src/linux/mm/slab.c
since that is the only part of the MM code that's dependent on CONFIG_SMP.
One difference I see is that the SMP code uses kmem_cache_alloc_batch
which is a real function, whereas the non-SMP code uses kmem_cache_alloc_one
which is a macro.  Also the SMP code writes something to the /proc file
system while the non-SMP code does not.  But I don't see anything obviously
wrong, although I'm certainly no expert in this area.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
