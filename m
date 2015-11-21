Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6530C1A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 21:37:44 +1100 (AEDT)
Subject: Re: Recurring Oops in link_path_walk()
To: Al Viro <viro@ZenIV.linux.org.uk>
References: <564F536F.9080109@c-s.fr>
 <20151120175643.GM22011@ZenIV.linux.org.uk>
 <1448045920.27264.207.camel@freescale.com>
 <20151120211745.GN22011@ZenIV.linux.org.uk>
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 BOUET Serge <serge.bouet@c-s.fr>, BARABAN Luc <luc.baraban@c-s.fr>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <56504970.4020409@c-s.fr>
Date: Sat, 21 Nov 2015 11:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <20151120211745.GN22011@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/11/2015 22:17, Al Viro a écrit :
> On Fri, Nov 20, 2015 at 12:58:40PM -0600, Scott Wood wrote:
>
>>> Looks like garbage in dentry->d_inode, assuming that reconstruction of
>>> the mapping of line numbers to addresses is correct...  Not sure it is,
>>> though; what's more, just how does LR manage to point to the insn right
>>> after the call of dput(), of all things?
>> When "bl dput" is executed, LR gets set to the instruction after the bl.
>>   After dput returns, LR still has that value.  Presumably the call to mntput
>> was skipped via the beq.  Nothing else modifies LR between the dput return and
>> the faulting address.
> OK, AFAICS it's this:
> 604)        do {
> 605)                struct path link = *path;
> 606)                void *cookie;
> 607)
> 608)                res = follow_link(&link, nd, &cookie);
> 609)                if (res)
> 610)                        break;
> 611)                res = walk_component(nd, path, LOOKUP_FOLLOW);
> 612)                put_link(nd, &link, cookie);
> and we are seeing assorted garbage as link.dentry->d_inode at put_link()
> call.  What's really interesting, follow_link() has return 0, which means
> that it must have passed through
> 849)        *p = dentry->d_inode->i_op->follow_link(dentry, nd);
> with
> 825)        struct dentry *dentry = link->dentry;
> upstream of that and link as seen by follow_link() is &link as seen by
> caller (nested_symlink()); IOW, at that point link.dentry->d_inode used to
> be a valid pointer.
>
> Do you have something resembling a reproducer or a chance to get a crash
> dump at that point?
>

Unfortunately no, I got no way to reproduce it, it happens very seldom.
Not sure what kind of crash dump I could get when it happens.

Maybe I can try to add delais/scheduling between follow_link() and 
put_link() to see if it happens more often ?


Also got a few other Oops at different functions but even more seldom 
than this one, not sure it has any link with that one, but I put them 
below just in case. Maybe they are worth being investigated as well, in 
that case I could also provide function disassembly for them:



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

Here it is inode->i_sb which seems wrong.

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


[32878.259271] Unable to handle kernel paging request for data at 
address 0xf030f0f4
[32878.266488] Faulting instruction address: 0xc00b65ec
[32878.271404] Oops: Kernel access of bad area, sig: 11 [#1]
[32878.276712] PREEMPT CMPC885
[32878.279510] CPU: 0 PID: 1391 Comm: snmpd Not tainted 3.18.14 #43
[32878.287157] task: c6812b50 ti: c6c2a000 task.ti: c6c2a000
[32878.292482] NIP: c00b65ec LR: c00b65c8 CTR: 00000000
[32878.297395] REGS: c6c2bd40 TRAP: 0300   Not tainted  (3.18.14)
[32878.304860] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 22042422 XER: 00000000
[32878.311408] DAR: f030f0f4 DSISR: c0000000
[32878.311408] GPR00: c00b9bb8 c6c2bdf0 c6812b50 ffffff9c c6478010 
00000051 f0e1f0f0 f030f0f0
[32878.311408] GPR08: f0f8f0f0 c2c05380 f030f0f0 00000220 42042422 
1001c8cc 7fffffff 0ffedab0
[32878.311408] GPR16: 3f800000 1001c314 559b51dc 7fca8508 1001bcb0 
00000000 7fca84f8 1001be28
[32878.311408] GPR24: 0fe8c008 1001be28 00000041 c6478000 c6c2bf08 
ffffff9c c6c2be88 c6c2be88
[32878.343378] NIP [c00b65ec] path_init+0x25c/0x488
[32878.347929] LR [c00b65c8] path_init+0x238/0x488
[32878.352365] Call Trace:
[32878.354798] [c6c2bdf0] [c0531500] 0xc0531500 (unreliable)
[32878.360158] [c6c2be20] [c00b9bb8] path_openat+0x74/0x678
[32878.365402] [c6c2be80] [c00ba1ec] do_filp_open+0x30/0x8c
[32878.370657] [c6c2bf00] [c00ab9ac] do_sys_open+0x14c/0x238
[32878.375997] [c6c2bf40] [c000b27c] ret_from_syscall+0x0/0x38
[32878.381449] Instruction dump:
[32878.384379] 70a70040 41820114 4bf90a81 812203f0 81090004 710a0001 
40820240 81490014
[32878.392039] 80c90010 915f001c 90df0018 7d475378 <814a0004> 71460001 
40820210 80e90004

[122726.996005] Unable to handle kernel paging request for data at 
address 0xf0f0f0f4
[122727.003271] Faulting instruction address: 0xc00b65ec
[122727.008271] Oops: Kernel access of bad area, sig: 11 [#1]
[122727.013667] PREEMPT CMPC885
[122727.016550] CPU: 0 PID: 567 Comm: snmpd Not tainted 3.18.14 #43
[122727.024196] task: c63bb9c0 ti: c647e000 task.ti: c647e000
[122727.029608] NIP: c00b65ec LR: c00b65c8 CTR: 00000000
[122727.034607] REGS: c647fd40 TRAP: 0300   Not tainted  (3.18.14)
[122727.042159] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 24222422 XER: 00000000
[122727.048793] DAR: f0f0f0f4 DSISR: c0000000
[122727.048793] GPR00: c00b9bb8 c647fdf0 c63bb9c0 ffffff9c c6432010 
00000051 f0f0f0f0 f0f0f0f0
[122727.048793] GPR08: f0f0f0f0 c2501040 f0f0f0f0 000000da 44222422 
1001c8cc 00000000 0000000a
[122727.048793] GPR16: 10151c70 7f84fab1 7f84fbe8 7f84ff40 7f84faa8 
00000000 10127b90 7f84fbf0
[122727.048793] GPR24: 0ff681f8 1014a590 00000041 c6432000 c647ff08 
ffffff9c c647fe88 c647fe88
[122727.080850] NIP [c00b65ec] path_init+0x25c/0x488
[122727.085486] LR [c00b65c8] path_init+0x238/0x488
[122727.090008] Call Trace:
[122727.092528] [c647fdf0] [c0531500] 0xc0531500 (unreliable)
[122727.097974] [c647fe20] [c00b9bb8] path_openat+0x74/0x678
[122727.103304] [c647fe80] [c00ba1ec] do_filp_open+0x30/0x8c
[122727.108642] [c647ff00] [c00ab9ac] do_sys_open+0x14c/0x238
[122727.114070] [c647ff40] [c000b27c] ret_from_syscall+0x0/0x38
[122727.119609] Instruction dump:
[122727.122625] 70a70040 41820114 4bf90a81 812203f0 81090004 710a0001 
40820240 81490014
[122727.130370] 80c90010 915f001c 90df0018 7d475378 <814a0004> 71460001 
40820210 80e90004


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
