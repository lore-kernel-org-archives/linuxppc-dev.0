Message-ID: <001701c30c9f$dc8ae790$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <paulus@samba.org>
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
References: <3EA94CB4.8050509@embeddededge.com><IGEFJKJNHJDCBKALBJLLKEEJFMAA.joakim.tjernlund@lumentis.se> <16043.7040.957962.917725@nanango.paulus.ozlabs.org>
Subject: Re: _PAGE_HWWRITE missing in pte_mkdirty()?
Date: Sun, 27 Apr 2003 11:31:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > OK, I wasn't aware that you can have dirty pages without _PAGE_RW.
>
> Yes, think about what happens if a process has a writable dirty page
> (in a private or anonymous mapping) and the process does a fork.  The
> page becomes copy-on-write, so we have to make it non-writable, but it
> is still dirty.

Yes, that makes sense. Thanks.

> Whether the kernel actually ever calls pte_mkdirty on a non-writable
> page is a different question, of course. :)

I don't think the kernel calls pte_mkdirty in this case. I tried it on my mpc862 system and it worked fine.
I was just trying to avoid DTLB errors.

   Jocke

PS.
  Could comment on my previous post about cacheable_memcpy() as well?
  http://lists.linuxppc.org/linuxppc-dev/200304/msg00057.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
