Return-Path: <eguan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wylnf0BVrzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:41:25 +1000 (AEST)
Date: Thu, 29 Jun 2017 11:41:22 +0800
From: Eryu Guan <eguan@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, liwan@redhat.com
Subject: Re: [v4.12-rc1 regression] mount ext4 fs results in kernel crash on
 PPC64le host
Message-ID: <20170629034122.GI23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 03:16:10AM +1000, Balbir Singh wrote:
> On Wed, Jun 28, 2017 at 6:32 PM, Eryu Guan <eguan@redhat.com> wrote:
> > Hi all,
> >
> > Li Wang and I are constantly seeing ppc64le hosts crashing due to bad
> > page access. But it's not reproducing on every ppc64le host we've
> > tested, but it usually happened in filesystem testings.
> >
> > [  207.403459] Unable to handle kernel paging request for unaligned access at address 0xc0000001c52c5e7f
> > [  207.403470] Faulting instruction address: 0xc0000000004d470c
> > [  207.403475] Oops: Kernel access of bad area, sig: 7 [#1]
> > [  207.403477] SMP NR_CPUS=2048
> > [  207.403478] NUMA
> > [  207.403480] pSeries
> > [  207.403483] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmveth ibmvscsi scsi_transport_srp
> > [  207.403503] CPU: 0 PID: 2263 Comm: mount Not tainted 4.12.0-rc7 #26
> > [  207.403506] task: c0000003ef2fde00 task.stack: c0000003de394000
> > [  207.403509] NIP: c0000000004d470c LR: c00000000011cd24 CTR: c000000000130de0
> > [  207.403512] REGS: c0000003de397450 TRAP: 0600   Not tainted  (4.12.0-rc7)
> > [  207.403515] MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
> > [  207.403521]   CR: 28028844  XER: 00000001
> > [  207.403525] CFAR: c00000000011cd20 DAR: c0000001c52c5e7f DSISR: 00000000 SOFTE: 0
> > [  207.403525] GPR00: c00000000011cce8 c0000003de3976d0 c000000001049500 c0000003f2c6ec20
> > [  207.403525] GPR04: c0000003f2c6ec20 c0000001c52c5e7f 0000000000000000 0000000000000001
> > [  207.403525] GPR08: 000c5543cab19830 0000000198e19900 0000000000000008 0000000000000000
> > [  207.403525] GPR12: c000000000130de0 c00000000fac0000 0000000000000000 c0000003f1328000
> > [  207.403525] GPR16: 0000000000000000 c0000003de700400 0000000000000000 c0000003de700594
> > [  207.403525] GPR20: 0000000000000002 0000000000000000 0000000000004000 c000000000cc5780
> > [  207.403525] GPR24: 00000001c45ffc5f 0000000000000000 00000001c45ffc5f c00000000107dd00
> > [  207.403525] GPR28: c0000003f2c6f434 0000000000000004 0000000000000800 c0000003f2c6ec00
> > [  207.403567] NIP [c0000000004d470c] llist_add_batch+0xc/0x40
> > [  207.403571] LR [c00000000011cd24] try_to_wake_up+0x4a4/0x5b0
> > [  207.403573] Call Trace:
> > [  207.403576] [c0000003de3976d0] [c00000000011cce8] try_to_wake_up+0x468/0x5b0 (unreliable)
> > [  207.403581] [c0000003de397750] [c000000000102cc8] create_worker+0x148/0x250
> > [  207.403585] [c0000003de3977f0] [c000000000105e7c] alloc_unbound_pwq+0x3bc/0x4c0
> > [  207.403589] [c0000003de397850] [c0000000001064bc] apply_wqattrs_prepare+0x2ac/0x320
> > [  207.403593] [c0000003de3978c0] [c00000000010656c] apply_workqueue_attrs_locked+0x3c/0xa0
> > [  207.403597] [c0000003de3978f0] [c000000000106acc] apply_workqueue_attrs+0x4c/0x80
> > [  207.403601] [c0000003de397930] [c00000000010866c] __alloc_workqueue_key+0x16c/0x4e0
> > [  207.403615] [c0000003de3979f0] [d000000013de5ce0] ext4_fill_super+0x1c70/0x3390 [ext4]
> > [  207.403620] [c0000003de397b30] [c00000000031739c] mount_bdev+0x21c/0x250
> > [  207.403633] [c0000003de397bd0] [d000000013dddb80] ext4_mount+0x20/0x40 [ext4]
> > [  207.403637] [c0000003de397bf0] [c000000000318944] mount_fs+0x74/0x210
> > [  207.403641] [c0000003de397ca0] [c000000000340638] vfs_kern_mount+0x68/0x1d0
> > [  207.403644] [c0000003de397d10] [c000000000345348] do_mount+0x278/0xef0
> > [  207.403648] [c0000003de397de0] [c0000000003463e4] SyS_mount+0x94/0x100
> > [  207.403652] [c0000003de397e30] [c00000000000af84] system_call+0x38/0xe0
> > [  207.403655] Instruction dump:
> > [  207.403658] 60420000 38600000 4e800020 60000000 60420000 7c832378 4e800020 60000000
> > [  207.403663] 60000000 e9250000 f9240000 7c0004ac <7d4028a8> 7c2a4800 40c20010 7c6029ad
> > [  207.403669] ---[ end trace 4fa94bf890f28f69 ]---
> >
> > Today I've finally found a host that could reliably trigger the crash by
> > mounting an ext4 filesystem and I've done a git bisect. The first bad
> > pointed to this commit:
> 
> Thanks for the excellent bug report, I am a little lost on the stack
> trace, it shows a bad page access that we think is triggered by the
> mmap changes? The patch changed the return type to integrate the call
> into trace-cmd. Could you point me to the tests that can help
> reproduce the crash. Could you also suggest how long to try the test
> cases for?

Sorry, I should have provided it in the first place. It's as simple as
mounting an ext4 filesystem on my test ppc64le host, i.e.

mkdir -p /mnt/ext4
mkfs -t ext4 -F /dev/sda5
mount /dev/sda5 /mnt/ext4

Kernel crash happened right after the mount command, and it's 100%
reproduced for me. I've tried the same reproducer on other ppc64 or
ppc64le hosts but not all of them could reproduce.

BTW, I just reverted the commit in question (9c355917fc) on top of
v4.12-rc7 kernel and the crash is gone.

Thanks,
Eryu
