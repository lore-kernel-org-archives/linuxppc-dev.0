Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Peter Bergner'" <bergner@vnet.ibm.com>,
	"'Franz Sirl'" <Franz.Sirl-ppc@lauterbach.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TASK_UNMAPPED_BASE
Date: Thu, 5 Feb 2004 09:57:41 +0100
Message-ID: <001301c3ebc6$1d9f0a80$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1075905440.2895.23.camel@otta.rchland.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Tue, 2004-02-03 at 09:22, Franz Sirl wrote:
> > At 14:05 03.02.2004, Joakim Tjernlund wrote:
> >> I changed TASK_UNMAPPED_BASE to well under 0x01fffffc and it worked
> >> as well.
> >>
> >> My question: Why is TASK_UNMAPPED_BASE=0x30000000 and would
> >> changing it to something less, say 0x00100000 be a problem?
> >
> > Hmm, might work, but it can also break in subtle ways, cause the
> > shared lib loading algorithm makes a few assumptions about the used
> > address ranges IIRC. But I don't see any use for it if you consider
> > what I said above.
>
> I've seen problems with HPC apps/benchmarks with huge bss's that fail
> to run because TASK_UNMAPED_BASE is set too low.

Too low, does that mean TASK_UNMAPED_BASE < 0x00100000 will fail with
huge bss's as well? Or will it just fail for
0x30000000 => TASK_UNMAPED_BASE <= 0x10000000?

To me it seems like it is a good idea to change(at least in 2.6
where the bugs you mentioned has been fixed) TASK_UNMAPED_BASE to
0x00100000(or lower).

Is there a way I can tell glibc to load it's libs around TASK_UNMAPED_BASE?
Currently only ld.so follows TASK_UNMAPED_BASE, the other libs always
loads at 0x0fxxxxxx. Glibc/ld.so version is 2.2.3

   Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
