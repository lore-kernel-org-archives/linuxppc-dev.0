Message-ID: <3C0BE612.51F79C59@intldata.ca>
Date: Mon, 03 Dec 2001 15:52:34 -0500
From: Heather Peterson <hpeterson@intldata.ca>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxrc thread doesn't terminate
Content-Type: text/plain; charset=us-ascii
Reply-To: hpeterson@intldata.ca
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm relatively new to linux.  I hope this isn't a repeat
question, but I tried searching through the old postings
and couldn't find an answer.

I'm using an 860P custom board running the 2.2.14 kernel
from HardHat.  I got it working using both NFS and with an
initial ramdisk.  However, now I want to start up with a
small initrd and then mount the real root filesystem off a
compact flash card.

My system is configured with CONFIG_BLK_DEV_INITRD and
my boot argument is root=/dev/cfda2 (my compact flash
device).  My initrd has a linuxrc file that loads the
drivers neccessary to access the compact flash device.

I put print statements in init/main.c

    pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);

    printk("My printk: launched thread to call linuxrc,
            pid = %d\n", pid);

    if (pid>0)
        while (pid != wait(&i));

    printk("\nMy printk: Thread terminated\n");

Here is my linuxrc file:
    #!/bin/sh

    echo 'Loading compact flash drivers.'
    insmod ports.o
    insmod i2c.o
    insmod cfd.o
    echo 'End of linuxrc.'

When it runs I see the first print statement, I see the
output from my linuxrc script, but I never see the second
print statement.  Is the thread not terminating properly?
How can I tell?

I also tried adding a counter to the loop and using waitpid
instead of wait:
    pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
    printk("My printk: launched thread to call linuxrc,
            pid = %d\n", pid);
    rc = 0;
    loopCount = 0;
    if (pid>0)
    {
        printk("My printk: waiting:\n");
        while ((pid != rc) && (loopCount++ < 80000))
        {
            current->policy |= SCHED_YIELD;
            schedule();
            rc = waitpid(pid, &i, WNOHANG);
        }
    }
    if (rc == pid)
        printk("\nMy printk: Thread terminated\n");
    else
        printk("\nMy printk: continuing without
                  termination of linuxrc thread\n");

This seems to work.  My drivers load from the linuxrc
script and then I see the print statement "continuing
without termination of linux rc thread", and it goes on
to call change_root().  Any ideas why wait and waitpid
never return with the pid of the linuxrc thread?  What
am I doing wrong?

Any help would be greatly appreciated.

Thanks,

Heather


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
