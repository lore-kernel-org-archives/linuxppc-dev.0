Return-Path: <madhvesh.s@ap.sony.com>
Received: from mail76-wa4-R.bigfish.com (mail-wa4.bigfish.com [216.32.181.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B64E5DE020
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 23:57:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Kprobes for book-e
Date: Tue, 17 Jun 2008 19:01:02 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D2BB0F2@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sulibhavi, Madhvesh wrote on Thursday, June 12, 2008 7:59 PM
> > > static void __kprobes prepare_singlestep(struct kprobe *p, struct
> > > pt_regs *regs)
> > > {
> > > +#ifdef CONFIG_BOOKE
> > > +	regs->msr &=3D ~(MSR_EE); /* Turn off 'Externel Interrupt' bits =
*/
> > > +	regs->msr &=3D ~(MSR_CE); /* Turn off 'Critical Interrupt' bits =
*/
> > > +	regs->msr |=3D MSR_DE;
> >=20
> > can we remove MSR_EE and MSR_CE here?
>=20
> Ah! yes?=20

No!!, this code cannot be removed. My tests fail
while doing the probe test for do_gettimeofday and __kmalloc.
I get Oops and Segfault. I think i had got similar results
in my initial port using 2.6.26.39. Here is the log...

------------------------------------------------------------------------
---------------------------------
/ # modprobe k-008
Oops: Exception in kernel mode, sig: 4 [#1]
Ebony
Modules linked in: k_007 k_006 k_005 k_004 k_003 k_002 k_001
NIP: d100601c LR: c0195bfc CTR: 00000000
REGS: c79e56a0 TRAP: 0700   Not tainted  (2.6.26-rc5-dirty)=20
MSR: 00029200 <EE,ME>  CR: 24022088  XER: 00000000
TASK =3D c7854420[761] 'ash' THREAD: c79e4000
GPR00: 00000000 c79e5750 c7854420 00000000 00000000 00000000 000005bc
00000000
GPR08: 00037eec 00000000 00000092 00008000 00037e5a 1001f184 00000000
fff9ed50
GPR16: 8fa72401 fff837f1 00000000 c0a80001 00000000 00000801 00000000
00000070
GPR24: 00000000 00004000 00004000 00000040 c7997000 c786b3c0 c7a11010
00000000
NIP [d100601c] 0xd100601c
LR [c0195bfc] ip_cork_release+0x28/0x50
Call Trace:
[c79e5750] [c786b3c0] 0xc786b3c0 (unreliable)
[c79e5770] [c01972d4] ip_push_pending_frames+0x308/0x3dc
[c79e57a0] [c01b48d8] udp_push_pending_frames+0x104/0x320
[c79e57d0] [c01b4d3c] udp_sendmsg+0x248/0x59c
[c79e5870] [c01bccfc] inet_sendmsg+0x50/0x78
[c79e5890] [c016ce7c] sock_sendmsg+0xac/0xf4
[c79e5980] [c016d280] kernel_sendmsg+0x2c/0x44
[c79e59a0] [c01d09f4] xs_send_kvec+0x88/0x98
[c79e59e0] [c01d18fc] xs_sendpages+0x7c/0x20c
[c79e5a10] [c01d1f3c] xs_udp_send_request+0x48/0x170
[c79e5a30] [c01cfb60] xprt_transmit+0x64/0x224
[c79e5a60] [c01ce820] call_transmit+0x19c/0x274
[c79e5a80] [c01d456c] __rpc_execute+0x7c/0x29c
[c79e5aa0] [c01ccb38] rpc_run_task+0x68/0x94
[c79e5ac0] [c01ccf80] rpc_call_sync+0x4c/0x7c
[c79e5af0] [c00dc4ac] nfs_proc_getattr+0x6c/0xb0
[c79e5b20] [c00d5cc0] __nfs_revalidate_inode+0xf8/0x234
[c79e5be0] [c00d33ac] nfs_lookup_revalidate+0x2f0/0x388
[c79e5d40] [c0085328] do_lookup+0x54/0x1b8
[c79e5d70] [c0086240] __link_path_walk+0xb38/0xee0
[c79e5dc0] [c00860a8] __link_path_walk+0x9a0/0xee0
[c79e5e10] [c0085508] path_walk+0x7c/0x140
[c79e5e40] [c0086858] do_path_lookup+0x68/0x16c
[c79e5e70] [c0086ee8] __path_lookup_intent_open+0x58/0xc0
[c79e5e90] [c00815a4] open_exec+0x28/0xc8
[c79e5ef0] [c0081c4c] do_execve+0x58/0x1c8
[c79e5f20] [c0005f68] sys_execve+0x50/0x7c
[c79e5f40] [c000c710] ret_from_syscall+0x0/0x3c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace eb93901908c2ca13 ]---
Illegal instructUnable to handle kernel paging request for data at
address 0x744
ion
Faulting instruction address: 0xc0076d64
Oops: Kernel access of bad area, sig: 11 [#2]
Ebony
Modules linked in: k_007 k_006 k_005 k_004 k_003 k_002 k_001
NIP: c0076d64 LR: c0090520 CTR: 00000002
REGS: c79bbe40 TRAP: 0300   Tainted: G      D    (2.6.26-rc5-dirty)
MSR: 00029000 <EE,ME>  CR: 42004024  XER: 00000000
DEAR: 74657374, ESR: 00000000
TASK =3D c7856d60[733] 'ash' THREAD: c79ba000
GPR00: 696e670a c79bbef0 c7856d60 1007a000 74657374 1007a000 10079ffc
00000000
GPR08: 00000000 00004000 c02e6000 c02d0000 82004028 1001f184 00000000
fff9ed50
GPR16: 8fa72401 fff837f1 03f940aa c0240000 c02a0000 00000000 00000000
1007a494
GPR24: 00000002 10075000 00000000 c79bbf10 1007a000 00001002 c79e8000
00000002
NIP [c0076d64] kfree+0x3c/0xc0
LR [c0090520] sys_getcwd+0x124/0x194
Call Trace:
[c79bbef0] [1007a000] 0x1007a000 (unreliable)
[c79bbf00] [c0090520] sys_getcwd+0x124/0x194
[c79bbf40] [c000c710] ret_from_syscall+0x0/0x3c
Instruction dump:
93e1000c 90010014 7c651b78 409d005c 3d60c02d 814b851c 3d234000 5529c9f4
7c09502e 7c895214 70094000 40820074 <80040000> 70090080 41820070
8064000c
---[ end trace eb93901908c2ca13 ]---
Segmentation fault


-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
