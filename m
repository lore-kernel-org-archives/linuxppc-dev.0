Subject: Re: TASK_UNMAPPED_BASE
From: Peter Bergner <bergner@vnet.ibm.com>
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <001301c3ebc6$1d9f0a80$0a01a8c0@LUMENTIS02>
References: <001301c3ebc6$1d9f0a80$0a01a8c0@LUMENTIS02>
Content-Type: text/plain; charset=
Message-Id: <1075998857.2843.14.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Date: Thu, 05 Feb 2004 10:34:18 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-02-05 at 02:57, Joakim Tjernlund wrote:
> Too low, does that mean TASK_UNMAPED_BASE < 0x00100000 will fail with
> huge bss's as well? Or will it just fail for
> 0x30000000 => TASK_UNMAPED_BASE <= 0x10000000?
>
> To me it seems like it is a good idea to change(at least in 2.6
> where the bugs you mentioned has been fixed) TASK_UNMAPED_BASE to
> 0x00100000(or lower).

The problem with a TASK_UNMAPPED_BASE that was "too low" was referring to
the bug where we always loaded ld.so at TASK_UNMAPPED_BASE even though
that adress was in the middle of the bss.  Now that has been fixed, "too low"
isn't a concern anymore.

However, I'm not sure moving the TASK_UNMAPPED_BASE below the text section
will work.  It's used for more than just loading shared libs.  Anonymous mmap
areas and the heap are all located relative to it.


> Is there a way I can tell glibc to load it's libs around TASK_UNMAPED_BASE?
> Currently only ld.so follows TASK_UNMAPED_BASE, the other libs always
> loads at 0x0fxxxxxx. Glibc/ld.so version is 2.2.3

IIRC, only ppc32 loads it's libs this way.  For example, ppc64 loads all
its libs above TASK_UNMAPPED_BASE.


Hälsningar,

Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
