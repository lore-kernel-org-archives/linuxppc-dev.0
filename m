Message-ID: <001a01c0ad9f$9311da80$ef0fa8c0@mystore>
From: "Nguyen Xuan Hoang" <jerry.nguyen@serialsystem.com.sg>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20010314145358.B5558@ecam.san.rr.com> <20010314193402.C5558@ecam.san.rr.com>
Subject: detect idle and suspend the CPU
Date: Thu, 15 Mar 2001 14:30:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am writting a code to automatically suspend the CPU (MPC823) and system
after it goes idle a few minutes.

I try to modify the idled() function in /arch/ppc/kernel/idle.c to count if
the CPU running in this code more than 5 minutes without reschedule , so I
will consider it idle.

for(;;)
{
    if(work) start_idle = jiffies;
    if(jiffies - start_idle > HARD_IDLE_TIMEOUT) {
        detect_idle(); // suspend CPU here
    }
    work = current->need_resched;
    __sti();
    check_pgt_cache();
    ....
}

However just after every 20s, the current->need_resched turn on, as a result
I can not detect the system idle (I already kill all process, excepet
init,kupdate,bdflush,sh).

I found out the init will automatically wake up after 20s.

My question is:

1. How the Linux Kernel for PC do this? I can see PC will automatically
suspend after 15 minutes.

2. Where should be the best place to put the suspend code ? (in idled() ?)

3. Is there anyone have implemented this feature for MPC823, where can I get
the information?

Thank in advances
Jerry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
