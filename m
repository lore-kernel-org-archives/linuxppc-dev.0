Message-ID: <3938FB56.F6900AB@pop.agri.ch>
Date: Sat, 03 Jun 2000 14:34:37 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 7200 & bitkeeper/linuxcare devel?
References: <Pine.LNX.3.96LJ1.1b7.1000602162200.22680A-101000@ofey.inetnebr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Takashi Oe wrote:
>
> Hi,
>
> On Fri, 2 Jun 2000, Andreas Tobler wrote:
>
> > Hi,
> > has anyone gotten a bitkeeper 2.4.0test1-ac7 or a linuxcare 2.3.99p9 to
> > boot under a 7200?
>
> I think I know why the kernel fails to boot on your machine.  I had to get
> around this problem for my current project.  I've sent a patch for it to
> Paul about a week ago, but, so far, nothing happened yet.  Just in case,
> the same patch is attached here.
>
> In your last post, you had a xmon log which said something like ".....
> vector: 700 ....", and I infer that kernel died with program check
> exception.
>
> Anyway, in arch/ppc/kernel/time.c, timer_interrupt() and do_gettimeofday()
> use "mftb" instruction which is not implemented in PPC 601, hence, the
> exception.  The patch workarounds this, but, personally, I feel the
> previous implementation which just used DEC register was better than my
> patch or the current one when all PPCs are considered.

Well, I applied this patch to the bitkeeper 2.4.0-test1-ac7, bingo, it
boots again. Until the detection of my adaptec happens. Boop. Here I get
a resource conflict and the machine wants to reboot since all my disk
are hanging on the 2940UW. This is a known problem for all linuxers,
also the ia32 and others. Have to read the posts on lk about this. Right
now I build a 2.3.99p9 from linuxcare with your patch. I expect it to
boot since the adaptec stuff was broken on 2.4 up.

So a big thanks to you Takashi, I can't say right now about the quality
about the patch, I have to study it exactly. But so far I'm able to work further.

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
