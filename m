From: phandel@cise.ufl.edu
Date: Sun, 10 Dec 2000 00:56:54 -0800 (PST)
Subject: kernel oops with rm in hfs - hit BUG() in line 236 of dcache.h
To: linuxppc-dev@lists.linuxppc.org
Cc: asun@cobaltnet.com, asun@asun.cobaltnet.com
Message-id: <Pine.LNX.4.21.0012100040330.1317-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


PowerCenter Pro 210mhz 604e, 224MB RAM, Linux 2.4-pre11 (rsync from Paul 12/8)

I was removing multiple files from my hfs drive, when I hit the BUG() at
line 236 in /usr/src/linux/include/linux/dcache.h:

static __inline__ struct dentry * dget(struct dentry *dentry)
{
        if (dentry) {
                if (!atomic_read(&dentry->d_count))
                        BUG();
                atomic_inc(&dentry->d_count);
        }
        return dentry;
}


Dec  9 18:09:21 like kernel: kernel BUG at /usr/src/linux/include/linux/dcache.h:236!
Dec  9 18:09:21 like kernel: Oops: Exception in kernel mode, sig: 7
Dec  9 18:09:21 like kernel: NIP: C00712FC XER: 00000000 LR: C00712FC SP: C1087DB0 REGS: c1087d00 TRAP: 0700
Dec  9 18:09:21 like kernel: MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Dec  9 18:09:21 like kernel: TASK = c1086000[12310] 'rm' Last syscall: 10
Dec  9 18:09:21 like kernel: last math c1086000 last altivec 00000000
Dec  9 18:09:21 like kernel: GPR00: C00712FC C1087DB0 C1086000 00000039 00001032 00000001 C0210000 00000000
Dec  9 18:09:21 like kernel: GPR08: 00000000 C01B0000 0000001F C1087CF0 22822842 1001ECE8 100302E8 10030000
Dec  9 18:09:21 like kernel: GPR16: 10030000 10030000 10030000 10030000 00000000 C96D7C20 00000000 C0210000
Dec  9 18:09:21 like kernel: GPR24: C291D62C C0180000 C0180000 C291D600 C4193C60 C291EE40 C291D628 C9947520
Dec  9 18:09:21 like kernel: Call backtrace:
Dec  9 18:09:21 like kernel: C00712FC C0047854 C00479A8 C00048D8 10001D8C 100031D0 10001358
Dec  9 18:09:21 like kernel: 0FF0B734 00000000

>From the System.map:
c007122c T hfs_unlink
c00476d8 T vfs_unlink
c00478c0 T sys_unlink
c00048d8 T ret_from_syscall_1


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
