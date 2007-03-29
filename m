Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15609.mail.cnb.yahoo.com (web15609.mail.cnb.yahoo.com
	[202.165.102.63]) by ozlabs.org (Postfix) with SMTP id EC8F3DDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Mar 2007 12:40:00 +1000 (EST)
Date: Thu, 29 Mar 2007 10:39:58 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Try to Disable PPC Interrupt
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1874157068-1175135998=:26206"
Message-ID: <904550.26206.qm@web15609.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1874157068-1175135998=:26206
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, all
    I am trying to disable interrupt on a PPC405EP board. I have checked from the 405 maunual that once the EE bit of MSR is set to 0, the external interrupt will be disabled. So I write a simple test module for that:

#ifndef MODULE
#define MODULE
#endif

#ifndef __KERNEL__
#define __KERNEL__
#endif

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/errno.h>

void hw_disable_irq (void) {
        int c;
        __asm__ __volatile__(
                "mfmsr %%r0; \
                wrteei 0; \
                mfmsr %0;":"=r"(c) : );

        printk("%h\n",c);
}

int init_module(void)
{
}

void cleanup_module(void)
{
}

MODULE_LICENSE("GPL");

When I insert this module, it seems nothing happens and there is no output of the varible "c". So would you like to tell me what the problem is here? Thank you very much.


Best wishes

Zhou Rui
Distributed & Embedded System Lab
School of Information Science & Engineering
Lanzhou University, P. R. China
http://dslab.lzu.edu.cn/~zr/
 		
---------------------------------
 Mp3疯狂搜-新歌热歌高速下   
--0-1874157068-1175135998=:26206
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, all<br>&nbsp;&nbsp;&nbsp; I am trying to disable interrupt on a PPC405EP board. I have checked from the 405 maunual that once the EE bit of MSR is set to 0, the external interrupt will be disabled. So I write a simple test module for that:<br><br>#ifndef MODULE<br>#define MODULE<br>#endif<br><br>#ifndef __KERNEL__<br>#define __KERNEL__<br>#endif<br><br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/kernel.h&gt;<br>#include &lt;linux/types.h&gt;<br>#include &lt;linux/errno.h&gt;<br><br>void hw_disable_irq (void) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int c;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "mfmsr %%r0; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wrteei 0; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfmsr %0;":"=r"(c) :
 );<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%h\n",c);<br>}<br><br>int init_module(void)<br>{<br>}<br><br>void cleanup_module(void)<br>{<br>}<br><br>MODULE_LICENSE("GPL");<br><br>When I insert this module, it seems nothing happens and there is no output of the varible "c". So would you like to tell me what the problem is here? Thank you very much.<br><BR><BR>Best wishes<br><br>Zhou Rui<br>Distributed &amp; Embedded System Lab<br>School of Information Science &amp; Engineering<br>Lanzhou University, P. R. China<br>http://dslab.lzu.edu.cn/~zr/<p>&#32;
		<hr size=1><a href="http://music.yahoo.com.cn/?source=mail_mailbox_footer" target=blank> 
Mp3疯狂搜-新歌热歌高速下 
</a>
 
 

--0-1874157068-1175135998=:26206--
