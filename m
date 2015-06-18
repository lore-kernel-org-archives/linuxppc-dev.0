Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 8933A1A0E85
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 18:41:14 +1000 (AEST)
Message-ID: <55828426.2080204@c-s.fr>
Date: Thu, 18 Jun 2015 10:41:10 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Oops in 3.18.14 in destroy_inode()
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[46796.501487] Unable to handle kernel paging request for data at 
address 0x000002dd
[46796.514365] Faulting instruction address: 0xc00c5978
[46796.524217] Oops: Kernel access of bad area, sig: 11 [#1]
[46796.529351] PREEMPT CMPC885
[46796.532144] CPU: 0 PID: 1107 Comm: snmpd Not tainted 3.18.14 #43
[46796.539790] task: c682d340 ti: c6728000 task.ti: c6728000
[46796.545119] NIP: c00c5978 LR: c00c5974 CTR: c00efeb4
[46796.550033] REGS: c6729e00 TRAP: 0300   Not tainted (3.18.14)
[46796.557497] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 24042424 XER: 20000000
[46796.564043] DAR: 000002dd DSISR: c0000000
[46796.564043] GPR00: c00c5974 c6729eb0 c682d340 00000000 c5a02734 
00000003 00000000 00851d4a
[46796.564043] GPR08: 000005ae 000002b9 00009032 000001e4 24042424 
1001c8cc 7fc835f8 100ad378
[46796.564043] GPR16: 00000000 7fc835f0 7fc835e8 7fc835e0 7fc835d8 
7fc835d0 7fc835c8 7fc835c0
[46796.564043] GPR24: 0fe59f14 000002ac c6a44b48 c6056110 c5e03168 
c5a026e0 c6728000 c1a026e0
[46796.596017] NIP [c00c5978] destroy_inode+0x38/0x84
[46796.600736] LR [c00c5974] destroy_inode+0x34/0x84
[46796.605344] Call Trace:
[46796.607793] [c6729eb0] [c00c5974] destroy_inode+0x34/0x84 (unreliable)
[46796.614271] [c6729ec0] [c00c1d90] __dentry_kill+0x2a8/0x304
[46796.619763] [c6729ee0] [c00c27c8] dput+0xd0/0x1d8
[46796.624416] [c6729f00] [c00adf54] __fput+0x134/0x1fc
[46796.629319] [c6729f20] [c002de28] task_work_run+0xac/0xf4
[46796.634655] [c6729f40] [c000bba4] do_user_signal+0x74/0xc4
[46796.640023] Instruction dump:
[46796.642955] 39430078 93e1000c 90010014 7c7f1b78 81230078 7d295278 
7d290034 5529d97e
[46796.650612] 69290001 0f090000 4bffff45 813f0014 <81290024> 81290004 
2f890000 419e0020
[46796.658466] ---[ end trace 0abe99599a8bf31d ]---


c00c5940 <destroy_inode>:
     struct inode *inode = container_of(head, struct inode, i_rcu);
     kmem_cache_free(inode_cachep, inode);
}

static void destroy_inode(struct inode *inode)
{
c00c5940:    7c 08 02 a6     mflr    r0
c00c5944:    94 21 ff f0     stwu    r1,-16(r1)
     BUG_ON(!list_empty(&inode->i_lru));
c00c5948:    39 43 00 78     addi    r10,r3,120
     struct inode *inode = container_of(head, struct inode, i_rcu);
     kmem_cache_free(inode_cachep, inode);
}

static void destroy_inode(struct inode *inode)
{
c00c594c:    93 e1 00 0c     stw     r31,12(r1)
c00c5950:    90 01 00 14     stw     r0,20(r1)
c00c5954:    7c 7f 1b 78     mr      r31,r3
     BUG_ON(!list_empty(&inode->i_lru));
c00c5958:    81 23 00 78     lwz     r9,120(r3)
c00c595c:    7d 29 52 78     xor     r9,r9,r10
c00c5960:    7d 29 00 34     cntlzw  r9,r9
c00c5964:    55 29 d9 7e     rlwinm  r9,r9,27,5,31
c00c5968:    69 29 00 01     xori    r9,r9,1
c00c596c:    0f 09 00 00     twnei   r9,0
     __destroy_inode(inode);
c00c5970:    4b ff ff 45     bl      c00c58b4 <__destroy_inode>
     if (inode->i_sb->s_op->destroy_inode)
c00c5974:    81 3f 00 14     lwz     r9,20(r31)
==> c00c5978:    81 29 00 24     lwz     r9,36(r9)
c00c597c:    81 29 00 04     lwz     r9,4(r9)
c00c5980:    2f 89 00 00     cmpwi   cr7,r9,0
c00c5984:    41 9e 00 20     beq     cr7,c00c59a4 <destroy_inode+0x64>
         inode->i_sb->s_op->destroy_inode(inode);
     else
         call_rcu(&inode->i_rcu, i_callback);
}
c00c5988:    80 01 00 14     lwz     r0,20(r1)

Looks like inode->i_sb (apparently contained in r9) has value 0x2b9 
which is obviously wrong, hence the bad access at 0x2dd when trying to 
get inode->i_sb->s_op

What else can I look at to investigate this issue ?

Christophe
