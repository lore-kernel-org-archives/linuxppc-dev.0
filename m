Date: Mon, 4 Mar 2002 08:05:29 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200203041605.g24G5Ts15070@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mmap wrapping around to 0 revisited
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


2.4.2-hhl had a problem with mmap right at the end of memory not working
because in a function do_mmap there was a check if
offset + PAGE_ALIGN(len) < offset
then fail.

I fixed it in that version by changing the comparison to
offset + PAGE_ALIGN(len)-1 < offset

The problem was offset + PAGE_ALIGN(len) ended up being zero due to wrapping
of the 32 bit value.

2.4.17 and probably lots of other kernels have the same mmap problem but
for a different reason. The new policy in the mmap is to not deal with the
byte offset but instead deal with the page offset, so the byte offset is
shifted right by usually 12 bits. This works fine on x86. On ppc the problem
is the offset is an off_t type, which isn't unsigned. So shifting it right
12 bits maintains the sign bit.

The fix is in
arch/ppc/kernel/syscalls.c
in the sys_mmap function, change this line:
	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
to
	err = do_mmap2(addr, len, prot, flags, fd, (unsigned long)offset >> PAGE_SHIFT);

Possibly it would be better to have the argument as an unsigned long instead
of an off_t.

In our box there is a flashrom that goes right to the end of memory. We could
never mmap that last page properly to flash it.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
