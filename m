To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A few questions in embedded linux
References: <20030117223204.83501.qmail@web11507.mail.yahoo.com>
From: Roland Dreier <roland@topspin.com>
Date: 17 Jan 2003 14:47:07 -0800
In-Reply-To: <20030117223204.83501.qmail@web11507.mail.yahoo.com>
Message-ID: <52u1g74cno.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Khai" == Khai Trinh <kqtrinh@yahoo.com> writes:

    Khai> Regarding to my question 1 below. After I check and use high
    Khai> mem, and CMDLINE="mem=60M", recompile my kernel, static link
    Khai> my driver using the 4M reserved RAM space, I got this
    Khai> message

    Khai> kernel: __ioremap(): phys addr 3c00000 is RAM lr c000a57c

Look at arch/ppc/mm/pgtable.c, where that message is being printed.
The kernel thinks that the address 3c00000 (which is 60 MB) is below
high_memory, which is where it thinks the top of memory is.

The most likely explanation is that you are doing something wrong when
you pass "mem=60M" to the kernel.

Have your driver print out virt_to_phys(high_memory) and check that
the kernel really thinks it only has 60 MB of memory.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
