Message-ID: <3BEC1A7C.DA3119C4@midrivers.com>
Date: Fri, 09 Nov 2001 11:03:40 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405 -- a little console help, resolution
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem w/ sash "not responding" (it was SEGVing) was
due to the kernel checking for execute permission on the page of
sash it was to execute.

Thanks to David Gibson for his help.

the patch, (found fixed in the _devel tree I just pulled)
in arch/ppc/mm/fault.c:

#if 0
		/* It would be nice to actually enforce the VM execute
		   permission on CPUs which can do so, but far too
		   much stuff in userspace doesn't get the permissions
		   right, so we let any page be executed for now. */
		if (! (vma->vm_flags & VM_EXEC))
			goto bad_area;
#endif

the #if 0 was added to the code fragment.

ALSO, is everyone who sends something to this list getting
an email bounce for hideo noda,mutoh @mutoh.co.jp ?? every post
to this list gives me this bounce.

perhaps some hack to the list server, or, the reply-to of the
list emails I'm responding to?


Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
