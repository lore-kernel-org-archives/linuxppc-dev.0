Message-ID: <40C42337.20209@intracom.gr>
Date: Mon, 07 Jun 2004 11:11:35 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Take two of the new serial uart driver.
References: <40BF3206.8030705@intracom.gr>	 <1086426744.4588.121.camel@imladris.demon.co.uk>	 <20040605192221.GT15195@smtp.west.cox.net> <1086472929.4862.12.camel@localhost.localdomain>
In-Reply-To: <1086472929.4862.12.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------060803070308070108010309"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060803070308070108010309
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

David Woodhouse wrote:

>On Sat, 2004-06-05 at 12:22 -0700, Tom Rini wrote:
>
>>On Sat, Jun 05, 2004 at 10:12:24AM +0100, David Woodhouse wrote:
>>
>>
>>>On Thu, 2004-06-03 at 17:13 +0300, Pantelis Antoniou wrote:
>>>
>>>>Hi
>>>>
>>>>The following patch updates the new CPM1/CPM2 uart driver.
>>>>
>>>It seems to lose queued characters from the kernel output when userspace
>>>/dev/console is first opened. Should you drain the FIFO before resetting
>>>the hardware on open? Or indeed refrain from resetting the hardware if
>>>you're not actually changing anything?
>>>
>>I haven't seen this problem on 8xx myself.
>>
>
>8265 here.
>
>VFS: Mounted root (nfs filesystem).
>Freeing unused kernel memory: 100k iné
>sh-2.05b#
>
>
Hi there.

The following patch fixes the problem by properly waiting
two character times on mode change.

Regards

Pantelis


--------------060803070308070108010309
Content-Type: text/x-patch;
 name="cpm_uart_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_fix.patch"

===== drivers/serial/cpm_uart/cpm_uart.h 1.2 vs edited =====
--- 1.2/drivers/serial/cpm_uart/cpm_uart.h      Fri Jun  4 10:37:06 2004
+++ edited/drivers/serial/cpm_uart/cpm_uart.h   Mon Jun  7 11:07:52 2004
@@ -65,6 +65,9 @@
        uint                     dp_addr;
        void                    *mem_addr;
        dma_addr_t               dma_addr;
+       /* helpers */
+       int                      baud;
+       int                      bits;
 };

 extern int cpm_uart_port_map[UART_NR];
===== drivers/serial/cpm_uart/cpm_uart_core.c 1.1 vs edited =====
--- 1.1/drivers/serial/cpm_uart/cpm_uart_core.c Thu Jun  3 16:42:27 2004
+++ edited/drivers/serial/cpm_uart/cpm_uart_core.c      Mon Jun  7 11:07:52 2004
@@ -43,6 +43,7 @@

 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/delay.h>

 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -242,10 +243,11 @@

        pr_debug("CPM uart[%d]:stop tx\n", port->line);

-       if (IS_SMC(pinfo))
+       if (IS_SMC(pinfo)) {
                smcp->smc_smcm &= ~SMCM_TX;
-       else
+       } else {
                sccp->scc_sccm &= ~UART_SCCM_TX;
+       }
 }

 /*
@@ -479,6 +481,10 @@
        if ((termios->c_cflag & CREAD) == 0)
                port->read_status_mask &= ~BD_SC_EMPTY;

+       /* if previous configuration exists wait 2 character times for tx to finish */
+       if (pinfo->baud != 0 || pinfo->bits != 0)
+               udelay((2 * 1000000 * pinfo->bits) / pinfo->baud);
+
        spin_lock_irqsave(&port->lock, flags);

        /* Start bit has not been added (so don't, because we would just
@@ -499,6 +505,10 @@
        }

        cpm_set_brg(pinfo->brg - 1, baud);
+
+       pinfo->baud = baud;
+       pinfo->bits = bits;
+
        spin_unlock_irqrestore(&port->lock, flags);
 }


--------------060803070308070108010309--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
