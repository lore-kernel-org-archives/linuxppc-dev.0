Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCVrb52sdzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 19:42:07 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so3490016pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 02:42:07 -0700 (PDT)
Date: Mon, 15 Aug 2016 17:42:02 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org
Subject: Re: [PATCH v2 18/20] powerpc: tm: Always use fp_state and vr_state
 to store live registers
Message-ID: <20160815094201.GA32347@simonLocalRHEL7.x64>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
 <20160811232819.11453-19-cyrilbur@gmail.com>
 <20160814015602.GA21144@simonLocalRHEL7.x64>
 <1471245953.24478.0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1471245953.24478.0.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,
On Mon, Aug 15, 2016 at 05:25:53PM +1000, Cyril Bur wrote:
> > There are 2 "giveall_all()" in above path:
> > __switch_to()
> >         giveup_all()  // first time
> >         __switch_to_tm()
> >                 tm_reclaim_task()
> >                         tm_reclaim_thread()
> >                                 giveup_all()  // again????
> > We should remove the one in __switch_to().
> 
> I don't think that will be possible, if a thread is not transactional
> the second giveup_all() won't get called so we'll need to preserve the
> one in __switch_to().
> I don't think removing the second is a good idea as we can enter
> tm_reclaim_thread() from other means than __switch_to_tm().
> I did think that perhaps __switch_to_tm() could call giveup_all() in
> the non transactional case but on reflection, doing nothing on the non
> transactional case is cleaner.
> The two calls are annoying but in the case where two calls are made,
> the second should realise that nothing needs to be done and exit
> quickly.
Ah, yes. I somehow ignored non-transactional case....

> 
> > And another question, for following code in tm_reclaim_thread():
> >         /* Having done the reclaim, we now have the checkpointed
> >          * FP/VSX values in the registers.  These might be valid
> >          * even if we have previously called enable_kernel_fp() or
> >          * flush_fp_to_thread(), so update thr->regs->msr to
> >          * indicate their current validity.
> >          */
> >         thr->regs->msr |= msr_diff;
> > 
> > Does it imply the task being switched out of CPU, with TIF_RESTORE_TM
> > bit set,  might end with MSR_FP enabled? (I thought MSR_FP should
> > not 
> > be enabled for a switched out task, as specified in
> > flush_fp_to_thread())
> 
> Correct! I mistakenly thought it was solving a problem but you're
> right. What you say is correct but it breaks signals, I've been
> hesitating on how to get signals to work with the correct solution
> here, I wasn't happy with my ideas but looks like it's pretty much the
> only way to go unfortunately.
Currently there will be an oops on flush_fp_to_thread() with this
patch, when ptrace a transaction application.

I think originally there is no giveup_all() call before tm_reclaim_thread(), 
so TIF_RESTORE_TM bit is not set. And finally thr->regs->msr is not
marked with MSR_FP enabled.

[  363.473851] kernel BUG at arch/powerpc/kernel/process.c:191!
[  363.474242] Oops: Exception in kernel mode, sig: 5 [#1]
[  363.474595] SMP NR_CPUS=2048 NUMA pSeries
[  363.474956] Modules linked in: isofs sg virtio_balloon ip_tables xfs libcrc32c sr_mod cdrom sd_mod virtio_net ibmvscsi scsi_transport_srp virtio_pci virtio_ring virtio
[  363.476021] CPU: 0 PID: 3018 Comm: ptrace-tm-gpr Not tainted 4.8.0-rc1+ #5
[  363.476547] task: c000000072c66b80 task.stack: c00000007e64c000
[  363.476949] NIP: c000000000017650 LR: c00000000000dc10 CTR: c000000000011538
[  363.477428] REGS: c00000007e64f960 TRAP: 0700   Not tainted (4.8.0-rc1+)
[  363.477948] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 42000088  XER: 20000000
[  363.478488] CFAR: c000000000017620 SOFTE: 1 
GPR00: c00000000000dc10 c00000007e64fbe0 c000000000f3d800 c000000072c65600 
GPR04: c0000000008706a8 0000000000000000 0000000000000108 0000000000000000 
GPR08: 0000010008410180 0000000000000001 0000000000000001 c000000000870f18 
GPR12: 0000000000000000 c00000000fe80000 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000010008410180 
GPR28: 0000000000000000 0000000000000000 0000000000000108 c000000072c65600 
[  363.482451] NIP [c000000000017650] flush_fp_to_thread+0x50/0x70
[  363.482855] LR [c00000000000dc10] fpr_get+0x40/0x120
[  363.483194] Call Trace:
[  363.483362] [c00000007e64fbe0] [c00000007e64fcf0] 0xc00000007e64fcf0 (unreliable)
[  363.483872] [c00000007e64fc00] [c00000000000dc10] fpr_get+0x40/0x120
[  363.484304] [c00000007e64fd60] [c000000000011578] arch_ptrace+0x628/0x7e0
[  363.485811] [c00000007e64fde0] [c0000000000c3340] SyS_ptrace+0xa0/0x180
[  363.486276] [c00000007e64fe30] [c000000000009404] system_call+0x38/0xec
[  363.486725] Instruction dump:
[  363.486927] 40820010 4e800020 60000000 60420000 7c0802a6 f8010010 f821ffe1 e92d0210 
[  363.487459] 7c694a78 7d290074 7929d182 69290001 <0b090000> 4bffff25 38210020 e8010010 
[  363.488005] ---[ end trace 58650a99c675b48c ]---
[  363.490137] 
[  365.490279] Kernel panic - not syncing: Fatal exception

Thanks,
- Simon
