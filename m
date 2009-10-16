Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 29DF3B7B78
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 12:12:36 +1100 (EST)
Received: by yxe8 with SMTP id 8so1416681yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 18:12:35 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 Oct 2009 09:12:34 +0800
Message-ID: <e997b7420910151812m3de16f67hdb756bcd1f40ddc@mail.gmail.com>
Subject: Problem when disabled interrupt in system call (ppc8270)
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc 8270, kernel 2.6.21.7

I took the following steps:


In a system call function , say , sys_reboot, interrupt was disabled
by local_irq_disable.

Then ,  value at the address of 0xc000050  was set to a value , say ,
0x1234.  Code was like this :

sys_reboot()
{
local_irq_disable();
*(volatile unsigned long * )0xc1000050 = 0x1234;
 while(1)
   {
    ;
   }
}

Finally, I reset the board (with power still on)  into uboot,using
'md 0x1000050' to display the content at physical address 0x1000050,
and found that , it was not 0x1234.


However, if I delete the local_irq_disable() in sys_reboot, everything
went well---After I reset the board, 'md 0x1000050' return the value
0x1234.


So, this really puzzled me , could someone explain why this happed?  Thank you.



PS:

static inline unsigned long local_irq_disable(void)
{
	unsigned long flags, zero;

	__asm__ __volatile__("li %1,0; lbz %0,%2(13); stb %1,%2(13)"
	: "=r" (flags), "=&r" (zero)
	: "i" (offsetof(struct paca_struct, soft_enabled))
	: "memory");

	return flags;
}
