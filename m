Date: Tue, 28 May 2002 23:07:55 -0400
From: Bill Fink <billfink@mindspring.com>
To: Bill Fink <billfink@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM java: Turning on SMP seems more and more likely the key
Message-Id: <20020528230755.74e88559.billfink@mindspring.com>
In-Reply-To: <20020528205428.23b9a61b.billfink@mindspring.com>
References: <20020528205428.23b9a61b.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Oops, I meant to send this to linuxppc-user, but since it appears to
be a kernel issue, maybe this is an appropriate forum after all, and
maybe someone will have some ideas about what might be wrong.

The basic problem is that the IBM J2RE java software (build 1.3.1)
gets an "out of memory" error when run on a UP system with a UP
2.4.19-pre8-ben0 kernel.  The current "fix" is to enable SMP, i.e.
running an SMP 2.4.19-pre8-ben0 kernel on the same UP system causes
the java code to work fine.

Note I am not running the java code myself.  I was just offering some
comments on the IBM java problem as reported by several other users
(at least three users reported that enabling SMP "fixed" the IBM J2RE
java "out of memory" problem).

						-Bill



On Tue, 28 May 2002, Bill Fink wrote:

> On Tue May 28 2002, Graham Leggett wrote:
>
> > James Gunning wrote:
> >
> > >          Have just verified that toggling SMP *on* is the critical
> > > switch to get the IBM java to go.
> >
> > Had the same result here: SMP kernel + java = works.
> >
> > Trouble is the SMP kernel is noticably slower than the non SMP kernel on
> > non SMP systems.
>
> My best guess is that the bug is somewhere in /usr/src/linux/mm/slab.c
> since that is the only part of the MM code that's dependent on CONFIG_SMP.
> One difference I see is that the SMP code uses kmem_cache_alloc_batch
> which is a real function, whereas the non-SMP code uses kmem_cache_alloc_one
> which is a macro.  Also the SMP code writes something to the /proc file
> system while the non-SMP code does not.  But I don't see anything obviously
> wrong, although I'm certainly no expert in this area.
>
> 						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
