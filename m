From: Dave_Lee@3com.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <882567D4.00758D7D.00@hqoutbound.ops.3com.com>
Date: Sat, 21 Aug 1999 14:24:11 -0700
Subject: Scheduler problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Hello,

We're trying to port Linux 2.2.10 to a diskless PPC 603e-based platform and
we've gotten the kernel to boot; however, during the device setup code, an
alignment exception occurs in the scheduler.  At the time, the initrd code
(rd.c:rd_load_image () ) is running and copying out a disk image to a RAM disk
(block_dev.c:block_write).  During the write, it eventually calls the scheduler
and we've tracked it to the code below.

        while (p != &init_task) {
                if (can_schedule(p)) {
                        int weight = goodness(prev, p, this_cpu);
                        if (weight > c)
                                c = weight, next = p;
                }
                p = p->next_run; // next_run is NULL
        }

Putting in some test code before going to the next list element, p is PID 0
(swapper?  which I assume is init_task ?).  All it's next/prev pointers are
NULL.

Any ideas on what the problem is and/or suggestions on how to tackle this?

Thanks,
Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
