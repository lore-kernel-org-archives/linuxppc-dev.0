From: "Tameen Khan" <tameen@cisco.com>
To: "'linuxppc-dev list'" <linuxppc-dev@lists.linuxppc.org>
Subject: stack frame for interrupts/exceptions in PPC
Date: Tue, 27 Apr 2004 18:11:09 -0700
Message-ID: <006001c42cbd$b07e12f0$273147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am tryting to implement kernel backtracing for PPC.

I need to understand how the process kernel stack/interrupt stack is managed
for PPC in the event of interrupts and exceptions.
ANY pointer to docs/code etc explaining above topic will be appreciated.

What is STACK_FRAME_OVERHEAD_PPC used for??? Its defined to be 16 for PPC
and 112 for PPC64.

I'm have the following issues right now.
1) How to identify stack frames which need special handling. For PPC64 if
the function name is .ret_from_syscall_1 or .ret_from_except, it is deemed
to be an interrupt_frame and handled seperately. There is also special
handling for frame __switch_to.

2) How to get the newpc, newlr and newsp values for these special frames.
Code used for PPC64 is given below.

nip_offset = byte offset of nip in struct pt_regs
r1_offset =  byte offset of r1 in struct pt_regs
lr_offset = byte offset of lr in struct pt_regs

         if (interrupt_frame) {
                newpc = KL_VREAD_PTR(sp +
                    KL_STACK_FRAME_OVERHEAD_PPC +
                    nip_offset);
                newsp = KL_VREAD_PTR(sp +
                    KL_STACK_FRAME_OVERHEAD_PPC +
                    r1_offset);
                newlr = KL_VREAD_PTR(sp +
                    KL_STACK_FRAME_OVERHEAD_PPC +
                    lr_offset);
                frm_size = get_frame_size(sp, newsp, saddr);
            }


Thanks
Tameen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
