Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: Debugging with BDI
Date: Fri, 18 Jul 2003 11:26:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200307181126.35714.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm trying to debug my u-boot with BDI. It's a 405GP system.
In the telnet sessoin I can insert "reset run" and the u-boot starts. When I
enter "reset halt" and then "go" it won't do anything. I have tried with ddd
and I see a few instructions work up to the mtmsr instruction (with "restart
halt", "bi 0xfffc0100"and "go" at the BDI telent and then start the ddd)

See file cpu/ppc4xx/start.S:
#if defined(CONFIG_405GP) || defined(CONFIG_405CR) || defined(CONFIG_405)
 /*----------------------------------------------------------------------- */
 /* Clear and set up some registers. */
 /*----------------------------------------------------------------------- */
          addi    r4,r0,0x0000
          mtspr   sgr,r4
          mtspr   dcwr,r4
          mtesr   r4               /* clear Exception Syndrome Reg */
          mttcr   r4                /* clear Timer Control Reg */
          mtxer   r4               /* clear Fixed-Point Exception Reg */
          mtevpr  r4              /* clear Exception Vector Prefix Reg */
          addi  r4,r0,0x1000    /* set ME bit (Machine Exceptions) */
          oris  r4,r4,0x0002      /* set CE bit (Critical Exceptions) */
          mtmsr   r4                  /* change MSR */
When I step the mtmsr instruction ddd shows address 0x700, and the esr
register has 0x8800'0000 (illegal instruction occured?????).
Same when I place a breakpoint behind the mtmsr instruction und use "cont"
instead of "stepi".

What is the difference between "reset run" and "reset halt", "go"?

Thanks in advance for any suggestion.

-- JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
