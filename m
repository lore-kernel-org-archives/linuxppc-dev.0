Message-ID: <002401c10c07$0027d780$277ceccb@dasan.com>
Reply-To: =?ks_c_5601-1987?B?wMy9wrW/KFNldW5nZG9uZyBMZWUp?= <sdlee@da-san.com>
From: =?ks_c_5601-1987?B?wMy9wrW/KFNldW5nZG9uZyBMZWUp?= <sdlee@da-san.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: mm bug ? - endless access fault
Date: Sat, 14 Jul 2001 10:47:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Recently I found a strange thing in linux-2.2.13 running on mpc8xx systems.
To simplify the problem, following shell script was used.

while true; do sh -c ls > /dev/null; done

Above thing runs well, but if I press ^C to terminate the script, then all processes hang.
Interrupt and bottom half (e.g. ping reply) is processed correctly, but process scheduling is frozen.

I investigated the problem and found that endless page fault happens in
.../arch/ppc/kernel/signal.c:handle_signal() function.
When kernel calls "__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)", page fault happens.
I tried to read sc->handler before access fault, and it was OK.
That is, that page seems to have read-only attribute.
Only write-access generates page fault.
I think that the first fault is normal and handled by handle_mm_fault.(Is this due to "copy-on-write" logic?)
But, the problem is that fault continues even after mm fault handling.
I confirmed that page table entry is changed at first fault in .../arch/ppc/kernl/fault.c:do_page_fault() function.
page table entry(aka pte) is changed actually by handle_mm_fault function which is architecture independent
part of mm.
Upgated page table entry is not changed in further fault. So, program stops at that point.

Signal handling does not alway make trouble.
In my case, when fault address is 0x7ffff7c4, problem is usually reproduced.

I checked this problem in kernel 2.4.4, but it was OK.
So, there is some difference between two kernel.

Does anyone have some idea about this?

Thanks.

-- Seungdong Lee

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
