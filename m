From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel Gurus Help! Possible kernel bug in conversion of jiffees in nanosleep.
Date: Sat, 12 Feb 2000 23:21:41 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00021223332100.19021@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been tracking down a bug in pthread cond timed wait that I think is
actually related to a kernel bug in linux/kernel/sched.c

See glibc-2.1.3-cvs from Feb 11,

in linuxthreads/condvar.c in pthread_cond_timedwait_relative_new

you can see the following loop.

while ( __libc_nanosleep(&reltime,&reltime) != 0)
;


But in *high* signal environments (such as lots of garbage collection going
on in the jdk) the damn value of reltime actually gets larger and not smaller.

I edited the while loop that repeatedly calls __libc_nanosleep and had it print
out (via MSG()) the reltime value each time an interrupted syscall happened.

Would you believe reltime (the remaining time) was actually increasing!

Here is a short snippet showing the value of reltime.tv_sec, reltime.tv_nsec,
and the value of errno (in this case 4 is EINTR).  There are two threads in
pthread_cond_timedwait in this example, you can look at values for thread 19016
which was originally told to wait for exactly 30 seconds.

19016 : reltime: 30 250000000 4
18987 : reltime: 1 460000000 4
19016 : reltime: 30 250000000 4
18987 : reltime: 1 470000000 4
19016 : reltime: 30 250000000 4
18987 : reltime: 1 480000000 4
19016 : reltime: 30 260000000 4
18987 : reltime: 1 490000000 4
19016 : reltime: 30 270000000 4
18987 : reltime: 1 500000000 4
19016 : reltime: 30 280000000 4
18987 : reltime: 1 510000000 4
19016 : reltime: 30 280000000 4
18987 : reltime: 1 510000000 4
19016 : reltime: 30 280000000 4
18987 : reltime: 1 510000000 4
19016 : reltime: 30 280000000 4


Notice by the end that the tv_nsec field has actually grown.

It seems the kernel routine (see linux/kernel/sched.c) converts the
time to jiffees and when interrupted converts jiffees back to time.

Unfortunately, some bug in this conversion is actually coming back with
a higher time than was passed in if it is interrupted fast enough.

Here is the kernel routine in question:

 asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
{       struct timespec t;
        unsigned long expire;

        if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
                return -EFAULT;

        if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
                return -EINVAL;


        if (t.tv_sec == 0 && t.tv_nsec <= 2000000L &&
            current->policy != SCHED_OTHER)
        {
                /*
                 * Short delay requests up to 2 ms will be handled with
                 * high precision by a busy wait for all real-time processes.
                 *
                 * Its important on SMP not to do this holding locks.
                 */
                udelay((t.tv_nsec + 999) / 1000);
                return 0;
        }


       expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);

        current->state = TASK_INTERRUPTIBLE;
        expire = schedule_timeout(expire);

        if (expire) {
                if (rmtp) {
                        jiffies_to_timespec(expire, &t);
                        if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
                                return -EFAULT;
                }
                return -EINTR;
        }
        return 0;
}


So I think this is a kernel bug that is scratched by this new tight loop and
the very high signal environment used in the jdk.

The previous version used in condvar timed wait always decreased time since
alot of time actually elapsed outside of __libc_nanosleep and it overwhelmed
any tiny increases due to conversion to and from jiffees.

I have no idea whether this bug exists on Linux x86 or not.  The kernel
routine in question is not arch specific so it should be used by
everyone.

This was the first time I have ever seen remaining time actually increase!

I need *help* resolving this issue before glibc 2.1.3 goes final in case this
turns out to be a glibc bug.

Any help here would be greatly appreciated!!!!!

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
