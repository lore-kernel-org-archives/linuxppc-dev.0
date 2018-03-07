Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxKKv6cYmzF1hF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 03:46:43 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27Gj3eK144752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 11:46:41 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjgn0snww-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 11:46:40 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 16:46:39 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/1] Exclude real mode code from ftrace
Date: Wed,  7 Mar 2018 22:16:18 +0530
Message-Id: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the function tracer is enabled when starting a guest, we get the 
below oops:

------------[ cut here ]------------
Delta way too big! 17582052940437522358 ts=17582052944931114496 write stamp = 4493592138
Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
LE SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in:
CPU: 0 PID: 1380 Comm: qemu-system-ppc Not tainted 4.16.0-rc3-nnr+ #148
NIP:  c0000000002635f8 LR: c0000000002635f4 CTR: c0000000001c1384
REGS: c0000000fffd1d80 TRAP: 0700   Not tainted  (4.16.0-rc3-nnr+)
MSR:  9000000002823003 <SF,HV,VEC,VSX,FP,ME,RI,LE>  CR: 28242222  XER: 20000000
CFAR: c000000000144f94 SOFTE: 3 
GPR00: c0000000002635f4 c0000000a26931d0 c0000000013fbe00 0000000000000058 
GPR04: 0000000000000001 0000000000000000 0000000000000001 0000000000000000 
GPR08: 00000000fe8d0000 c000000001287368 c000000001287368 
0000000028242224 GPR12: 0000000000002000 c00000000fac0000 
c00000000012cd04 c0000000f0279a00 GPR16: c0000000a26938e0 
c000000000de2044 c0000000015c5488 0000000000000000 GPR20: 
0000000000000000 0000000000000001 0000000000000000 0000000000000001 
GPR24: 0000000000000001 0000000000000000 0000000000000000 
0000000000000003 GPR28: 0000000000000000 0000000000000000 
00000000000003e8 c0000000a2693260 NIP [c0000000002635f8] 
rb_handle_timestamp+0x88/0x90
LR [c0000000002635f4] rb_handle_timestamp+0x84/0x90
Call Trace:
[c0000000a26931d0] [c0000000002635f4] rb_handle_timestamp+0x84/0x90 (unreliable)
[c0000000a2693240] [c000000000266d84] ring_buffer_lock_reserve+0x174/0x5d0
[c0000000a26932b0] [c0000000002728a0] trace_function+0x50/0x190
[c0000000a2693310] [c00000000027f000] function_trace_call+0x140/0x170
[c0000000a2693340] [c000000000064c80] ftrace_call+0x4/0xb8
[c0000000a2693510] [c00000000012720c] kvmppc_hv_entry+0x148/0x164
[c0000000a26935b0] [c000000000126ce0] kvmppc_call_hv_entry+0x28/0x124
[c0000000a2693620] [c00000000011dd84] __kvmppc_vcore_entry+0x13c/0x1b8
[c0000000a26937f0] [c00000000011a8c0] kvmppc_run_core+0xec0/0x1e50
[c0000000a26939b0] [c00000000011c6e4] kvmppc_vcpu_run_hv+0x484/0x1270
[c0000000a2693b30] [c0000000000f8ea8] kvmppc_vcpu_run+0x38/0x50
[c0000000a2693b50] [c0000000000f4a8c] kvm_arch_vcpu_ioctl_run+0x28c/0x380
[c0000000a2693be0] [c0000000000e6978] kvm_vcpu_ioctl+0x4c8/0x780
[c0000000a2693d40] [c0000000003e64e8] do_vfs_ioctl+0xd8/0x900
[c0000000a2693de0] [c0000000003e6d7c] SyS_ioctl+0x6c/0x100
[c0000000a2693e30] [c00000000000bc60] system_call+0x58/0x6c
Instruction dump:
2f890000 409effd4 e8c300b0 e8bf0000 39200001 3ce2ffc9 3c62ffc2 38e78808 
38638058 992a7032 4bee1939 60000000 <0fe00000> 4bffffa4 3c4c011a 38428800 
---[ end trace 6c43107948f7546d ]---

The KVM entry code updates the timebase register based on the guest's 
tb_offset, which upsets ftrace ring buffer time stamps resulting in a 
WARN_ONCE() in rb_handle_timestamp(). Furthermore, WARN() inserts a trap 
instruction which is now hit while we are in guest MMU context, 
resulting in the oops above.

The obvious way to address this is to exclude all KVM C code that can be 
run when we are in KVM_GUEST_MODE_HOST_HV from ftrace using the 
'notrace' annotation (*). But, there are a few problems doing that:
- the list grows quickly since we need to blacklist not just the top 
  level function, but every other function which those can call and any 
  and all functions that those can in turn call, and so on...
- even if we do the above, it is hard to ensure that all functions are 
  covered and that this continues to be the case due to code refactoring 
  adding new functions.

The other ways to handle this need a slightly larger hammer:
1. exclude all KVM code from ftrace
2. exclude all real mode code from ftrace

(1) is fairly easy to do, but is still not sufficient since we do call 
into various mm/ helpers and they will need to be additionally excluded.  
It also ends up excluding a lot of KVM code that can still be traced.

(2) is the approach implemented by the subsequent patch (+) and looks 
like a reasonable tradeoff since it additionally excludes all real mode 
code, rather than just the KVM code. However, I am not completely sure 
how much real mode C code we have, that we would like to be able to 
trace. So, it would be good to hear what is preferable.

Please let me know your thoughts.


Thanks,
Naveen

-
(*) Afaics, KVM real mode code is not segregated into a separate file 
and is not trivial to do. If this is not true, then this may be an 
option to consider.
(+) This RFC only handles -mprofile-kernel, and would need to be updated 
to deal with other ftrace entry code.



Naveen N. Rao (1):
  powerpc/ftrace: Exclude real mode code from being traced

 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.16.1
