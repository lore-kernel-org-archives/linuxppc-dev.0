Message-ID: <3D9A998F.9010606@ellemedia.com>
Date: Wed, 02 Oct 2002 10:00:31 +0300
From: Apostolos Meliones <meliones@ellemedia.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch to recover from segmentation fault on HiP4 MPC8260 versions (for kernels 2.4.x, x<10)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here you may find a simple patch for 2.4 kernels up to version 2.4.10 to
support the HiP4 versions of MPC82xx:

In arch/ppc/kernel/misc.S replace _GLOBAL(_get_PVR) with the following:

_GLOBAL(_get_PVR)
mfspr r3,PVR
xor r17,r17,r17
xor r16,r16,r16
addi r17,r17,0x7FFF@l
addi r16,r16,0x10@l
slw r17,r17,r16
ori r17,r17,0xFFFF@l
and r3,r3,r17
blr


Best Regards

Apostol


----------------------------------------
Dr. Apostol Meliones
Ellemedia Technologies
223 Syngrou Ave., 17121, Athens, Greece
Tel: +30-10-9373095, Fax: +30-10-9370386


Allen Curtis wrote:

>>We moved to a new kernel (we were using 2.4.7) to support the PVR of the
>>HiP4 versions of MPC826x, so we tested 2.4.12, 2.4.18 and 2.4.20. We did
>>our porting mostly on 2.4.20. We had almost everything there. However,
>>we encountered a serious error related to memory management regarding
>>one of our drivers that was based on a port from MPC860 coded for kernel
>>2.4.4. Alternatively, we kept on working in parallel on 2.4.7 to find
>>out and cancel the PVR checks that were instructing the kernel to use an
>>incorrect cpu among the several available processor versions. This was
>>responsible for the segmentation fault. We deceived the kernel to take
>>8264 for 8260 and this way the problem was solved !!
>>
>
>Could you provide a patch for you modifications. If they are too ugly, just
>send them to me. I am interested in maintaining an updated kernel for the
>MPC processors.
>
>Thanks
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
