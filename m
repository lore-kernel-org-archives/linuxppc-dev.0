Return-Path: <tsawyer@broadcom.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 4450267B70
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 22:48:06 +1000 (EST)
Message-ID: <44730484.4090208@broadcom.com>
Date: Tue, 23 May 2006 08:48:04 -0400
From: "Travis B. Sawyer" <tsawyer@broadcom.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problem mapping GPIO regs on ppc440gx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings:

We've been using a 2.4.30 kernel (with numerous patches) on a AMCC 440gx
custom built board for quite some time now.

We're building some new hardware that forces us to go to a 2.6 kernel.
So, I've downloaded 2.6.16.16 from kernel.org and am porting everything
forward from our 2.4.30 kernel.

The problem lies in mapping the GPIO regs of the 440 to user space using
/dev/mem:

    gpio_fd = open("/dev/mem", O_RDWR | O_SYNC);

    if (0 > gpio_fd) {
        perror("mbGpioGet(): Unable to open gpio");
        return(-1);
    }

    addr = (ppc440_gpio_regs_t *)mmap(0, getpagesize() * 2,
                                      PROT_READ | PROT_WRITE,
                                      MAP_SHARED, gpio_fd,
                                      (off_t)(0x40000000));

    if (MAP_FAILED == addr) {
        perror("mbGpioGet(): map error");
        close(gpio_fd);
        return(-1);
    }

    pGpioRegs = (ppc440_gpio_regs_t *)((uint32_t)addr + 0x700);

    data = pGpioRegs->in & (MB_GPIO_PRI_N_K | MB_GPIO_SEC_PRES_K);

    munmap(0, sizeof(ppc440_gpio_regs_t));
    close(gpio_fd);

The data I get back is 0.  Always.  /SEC_PRES_K should be 1 in this case.

(gdb) print /x addr
$7 = 0x30015000
(gdb) print /x pGpioRegs
$8 = 0x30015700


Checking /proc/<PID>/map shows the mapping:
30015000-30019000 rw-p 30015000 00:00 0


On a board running the 2.4.30 kernel, I show the SAME entry in 
/proc/<PID>/map
but I do get data back.

Any idea what I'm doing wrong here?

TIA,

Travis Sawyer
