Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Peter Bergner'" <bergner@vnet.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TASK_UNMAPPED_BASE
Date: Thu, 5 Feb 2004 18:10:52 +0100
Message-ID: <002c01c3ec0b$0240ea70$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1075998857.2843.14.camel@otta.rchland.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Thu, 2004-02-05 at 02:57, Joakim Tjernlund wrote:
> > Too low, does that mean TASK_UNMAPED_BASE < 0x00100000 will fail
> > with huge bss's as well? Or will it just fail for 0x30000000 =>
> > TASK_UNMAPED_BASE <= 0x10000000?
> >
> > To me it seems like it is a good idea to change(at least in 2.6
> > where the bugs you mentioned has been fixed) TASK_UNMAPED_BASE to
> > 0x00100000(or lower).
>
> The problem with a TASK_UNMAPPED_BASE that was "too low" was referring
> to the bug where we always loaded ld.so at TASK_UNMAPPED_BASE even
> though that adress was in the middle of the bss. Now that has been
> fixed, "too low" isn't a concern anymore.

OK, thanks.

> However, I'm not sure moving the TASK_UNMAPPED_BASE below the text
> section will work. It's used for more than just loading shared libs.
> Anonymous mmap areas and the heap are all located relative to it.

hmm, I have tried several values, for instance anything 0x2000 between
(0x10000000-0x16000) appears to work. (0x10000000-0x15000) don't boot,
but then I am on 2.4, so maybe it's the huge bss bug that bites me.

> > Is there a way I can tell glibc to load it's libs around
> > TASK_UNMAPED_BASE? Currently only ld.so follows TASK_UNMAPED_BASE,
> > the other libs always loads at 0x0fxxxxxx. Glibc/ld.so version is
> > 2.2.3
>
> IIRC, only ppc32 loads it's libs this way. For example, ppc64 loads
> all its libs above TASK_UNMAPPED_BASE.

Well, I am ppc32.

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
