Message-ID: <39C653F2.FC013380@mvista.com>
Date: Mon, 18 Sep 2000 10:42:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint & random crashes?
References: <2F67A63DFFB1D31185D90090278CBB2D014ECF08@apmail6.chn.agilent.com> <39BD4215.6FD9B56F@mvista.com> <20000912001214.B17705@hectic.net> <39BD66B9.9A1A362F@mvista.com> <20000918171328.A4328@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey Alex.

I now have a sandpoint that exhibits problems like you were seeing.  That's good
because now I have some to test with.

In addition, I'm planning on a fairly major overhaul sometime "soon".  The
problem is, I'm neck deep in other work right now.

I'll let you know when I have that work done.  If you fix any problems, please
let the community know.

Thanks,

Mark
--

> Hi, Mark!
>
> On Mon, Sep 11, 2000 at 04:11:53PM -0700, you wrote the following:
>
> > > Today I think I noticed a very interesting consistency that might be
> > > helpful. I haven't had the time to test it completely; I'll do it
> > > tomorrow and post again. The thing is, there's a little green led on
> > > the board saying "backup power" or something like that. If you turn
> > > off the computer and the power supply, and leave it off for half a
> > > minute or so, the led turns off. If you turn the computer on
> > > afterwards and load the kernel, it loads init and you can work (until
> > > it crashes). If you just reset the computer and load the kernel (after
> > > uploading it via dink of course), init won't load.
> > >
> >
> > This almost sounds like a hardware problem.  How old is your
> > processor module?  Remember this is a test platform for MOT SPS
> > where they test out new processors, etc.  They may have given you an
> > early rev board or processor or host bridge or...  If you have an
> > old one, you may want to ask for a newer one.
>
> We've just bought those boards now from Motorola. I checked on their
> site and we have the latest revisions...
>
> As to hardware problems, I took the other box we have here (an
> identical configuration) and tested there, with the same results. :-(
> So if it's a hardware problem, it's in all those boards. I also ran
> the memory test that dink has on all the memory that I can (from 90000
> to the end; before that resides dink itself) and it didn't find any
> errors. (I ran all the six or seven tests, 19 times in a row -- about
> 19-20 hours of testing.) So unless I'm extremely unlucky (and there
> are problems in the low range), the memory isn't a problem either.
>
> I downloaded the compilers from CDK 1.2 and compiled a kernel with
> them. Made no difference.
>
> Here are some more crash dumps, FWIW. Something is definitely fishy in
> regard to memory management.
>
> This one is weird -- I don't have any swap.
>
> > mount-t^H ^H^H^H
>
> sh: mount-: coBad swap file entry 00000085
> kernel BUG at swap_state.c:71!
>
> NIP: C002F0D4 XER: 20000000 LR: C002F0D4 REGS: c0283ce0 TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0282000[7] 'sh' Last syscall: 1
> last math c0282000 last altivec 00000000
> GPR00: C002F0D4 C0283D90 C0282000 0000001F 00001032 C0105734 C0140000 00000000
> GPR08: C0140000 C0100000 C0110000 C0283CD0 44262824 100A09F8 00000000 100A6190
> GPR16: 00000000 00000000 00000000 00000000 C01310E0 C0284100 1024D000 0FF2E000
> GPR24: 00000000 00000000 0032E000 00000041 C03CDB4C C0284100 00000085 C01AF6B8
> Call backtrace:
> C002F0D4 C002F1EC C002F328 C00208B8 C002393C C0013F84 C0016FB0
> C00171F4 C0004CC0 0FE79968 1002190C 10020DC8 1001D75C 1004D09C
> 10010B08 1000FBC4 0FE6F75C 00000000
> Kernel panic: Exception in kernel pc c002f0d4 signal 4
>
> backtrace:
> 0xc002f0d4 -- 0xc002f080 + 0x0054   __delete_from_swap_cache
> 0xc002f1ec -- 0xc002f14c + 0x00a0   delete_from_swap_cache_nolock
> 0xc002f328 -- 0xc002f280 + 0x00a8   free_page_and_swap_cache
> 0xc00208b8 -- 0xc0020730 + 0x0188   zap_page_range
> 0xc002393c -- 0xc0023838 + 0x0104   exit_mmap
> 0xc0013f84 -- 0xc0013f4c + 0x0038   mmput
> 0xc0016fb0 -- 0xc0016ed0 + 0x00e0   do_exit
> 0xc00171f4 -- 0xc00171f4 + 0x0000   sys_wait4
> 0xc0004cc0 -- 0xc0004cc0 + 0x0000   ret_from_syscall_1
>
> And this one is crazy -- 14,500,000 worked fine, 15,000,000 gave me
> "Out of memory", and the middle between them gave me this:
>
> bash-2.03# perl -e '$a="A"x14750000'
> kmem_free: Bad obj addr (objp=c0177500, name=size-64)
> kernel BUG at slab.c:1695!
> NIP: C002CDD4 XER: 20000000 LR: C002CDD4 REGS: c0104cd0 TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0103000[0] 'swapper' Last syscall: 36
> last math 00000000 last altivec 00000000
> GPR00: C002CDD4 C0104D80 C0103000 0000001B 00001032 C0105734 C0140000 00000000
> GPR08: C0140000 C0100000 C0110000 C0104CC0 24462024 100A09F8 00000000 00000000
> GPR16: 00000000 00000000 00000000 00000000 00000000 00104EB0 C02F7042 C02FFA40
> GPR24: C0177500 00000014 0000001C C01023E0 C017755C C0177FE0 C0177500 C01A0160
> Call backtrace:
> C002CDD4 C009E1E4 C009EA68 C009DA98 C009DF70 C0093E4C C00189EC
> C0004F60 00000000 C0006130 C0006144 C011678C 00003C60
> Kernel panic: Exception in kernel pc c002cdd4 signal 4
> In interrupt handler - not syncing
> Rebooting in 180 seconds..
>
> backtrace:
> 0xc002cdd4 -- 0xc002ca04 + 0x03d0   kfree
> 0xc009e1e4 -- 0xc009e0e4 + 0x0100   ip_free
> 0xc009ea68 -- 0xc009e740 + 0x0328   ip_defrag
> 0xc009da98 -- 0xc009da70 + 0x0028   ip_local_deliver
> 0xc009df70 -- 0xc009dc44 + 0x032c   ip_rcv
> 0xc0093e4c -- 0xc0093c48 + 0x0204   net_rx_action
> 0xc00189ec -- 0xc0018934 + 0x00b8   do_softirq
> 0xc0004f60 -- 0xc0004f60 + 0x0000   do_bottom_half_ret
> 0x00000000 -- unknown address
> 0xc0006130 -- 0xc00060c0 + 0x0070   idled
> 0xc0006144 -- 0xc0006134 + 0x0010   cpu_idle
> 0xc011678c -- 0xc0116644 + 0x0148   start_kernel
> 0x00003c60 -- unknown address
>
> --
> Alex Shnitman                            | http://www.debian.org
> alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
> http://alexsh.hectic.net    UIN 188956    PGP key on web page
>        E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA
>
> /real/ kernel hackers
>     dd if=/dev/urandom of=/vmlinuz
> and influence the Universal Randomosity Field.
>         -- Gaal Yahas

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
