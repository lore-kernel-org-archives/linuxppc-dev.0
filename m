Return-Path: <prabha.j@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id DD83668802
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 20:33:07 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: prabha.j@tcs.com
Message-ID: <OF8E017799.50E38798-ON652570D8.0030F463-652570D8.0033795C@tcs.com>
Date: Thu, 15 Dec 2005 14:52:13 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 003378EB652570D8_="
Subject: help reqd for mpc8260 linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 003378EB652570D8_=
Content-Type: text/plain; charset="US-ASCII"


Hi All,
I working on custom board(mpc8260) . Now the bootlader is working and when 
i dowload the kernel image through u-boot it gives messages as
"Transferring Conrol to Linux" and then nothing comes. I am using 
Linux-2.4.25 and eldk toolkit ,both from denx.
My boards memory map is SDRAM starts from  0 and flash starts from 
0x30000000. and baudrate is 57600
When i was debugging in
start_here(arch/ppc/kernel/head.S)
It is passing the machine_init and  MMU_init(This i have seen by putting 
printk and seeing it in log_buf) and then in this code 


lis     r4,2f@h
        ori     r4,r4,2f@l
        tophys(r4,r4)
        li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
        FIX_SRR1(r3,r5)
        mtspr   SRR0,r4
        mtspr   SRR1,r3
        SYNC
        bl      MMU_init_prabha //(This is just a printk function).Till 
here its working.

        RFI
If i put the printk after this funtion i am not getting anything in the 
log_buf. I simply commented the RFI instruction then also i didn't see any 
messages.
Can anybody tell me what may be the problem.
Waiting for reply.
Thanks in advance.
Best Regards

Prabha J.
Tata Consultancy Services Limited
Mailto: prabha.j@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 003378EB652570D8_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">I working on custom board(mpc8260) .
Now the bootlader is working and when i dowload the kernel image through
u-boot it gives messages as</font>
<br><font size=2 face="sans-serif">&quot;Transferring Conrol to Linux&quot;
and then nothing comes. I am using Linux-2.4.25 and eldk toolkit ,both
from denx.</font>
<br><font size=2 face="sans-serif">My boards memory map is SDRAM starts
from &nbsp;0 and flash starts from 0x30000000. and baudrate is 57600</font>
<br><font size=2 face="sans-serif">When i was debugging in</font>
<br><font size=2 face="sans-serif">start_here(arch/ppc/kernel/head.S)</font>
<br><font size=2 face="sans-serif">It is passing the machine_init and &nbsp;MMU_init(This
i have seen by putting printk and seeing it in log_buf) and then in this
code </font>
<br>
<br>
<br><font size=2 face="sans-serif">lis &nbsp; &nbsp; r4,2f@h</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; ori &nbsp;
&nbsp; r4,r4,2f@l</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; tophys(r4,r4)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; li &nbsp;
&nbsp; &nbsp;r3,MSR_KERNEL &amp; ~(MSR_IR|MSR_DR)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; FIX_SRR1(r3,r5)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mtspr &nbsp;
SRR0,r4</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mtspr &nbsp;
SRR1,r3</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; SYNC</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bl &nbsp;
&nbsp; &nbsp;MMU_init_prabha //(This is just a printk function).Till here
its working.</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; RFI</font>
<br><font size=2 face="sans-serif">If i put the printk after this funtion
i am not getting anything in the log_buf. I simply commented the RFI instruction
then also i didn't see any messages.</font>
<br><font size=2 face="sans-serif">Can anybody tell me what may be the
problem.</font>
<br><font size=2 face="sans-serif">Waiting for reply.</font>
<br><font size=2 face="sans-serif">Thanks in advance.</font>
<br><font size=2 face="sans-serif">Best Regards</font>
<br><font size=2 face="sans-serif"><br>
Prabha J.<br>
Tata Consultancy Services Limited<br>
Mailto: prabha.j@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 003378EB652570D8_=--
