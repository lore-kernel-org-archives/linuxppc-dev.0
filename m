From: Dave_Lee@3com.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <882567D7.000940CB.00@hqoutbound.ops.3com.com>
Date: Mon, 23 Aug 1999 18:41:15 -0700
Subject: Memory question + Re: Scheduler problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




After examining the panic output, it turns out that it isn't the scheduler but a
result of the fact that we have the data cache off (to improve performance of
the emulator, which runs horribly slow when the dcache is on).  The fault
actually occurs in clear_page, which uses the dcbz instruction, which faults
when the data cache is off.  The dcache is on now and will stay on. :-)






Dave_Lee@3com.com on 08/21/99 02:24:11 PM

Sent by:  Dave_Lee@3com.com


To:   linuxppc-dev@lists.linuxppc.org
cc:    (Dave Lee/HQ/3Com)
Subject:  Scheduler problem







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
