Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15611.mail.cnb.yahoo.com (web15611.mail.cnb.yahoo.com
	[202.165.102.207]) by ozlabs.org (Postfix) with SMTP id 79F56DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Mar 2007 14:20:26 +1000 (EST)
Date: Thu, 29 Mar 2007 12:20:24 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Re: Try to Disable PPC Interrupt
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0703281947s5ab2e971y395abda5462e9870@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-837925074-1175142024=:60794"
Message-ID: <175002.60794.qm@web15611.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-837925074-1175142024=:60794
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi
Sorry for my silly mistake, and I modify it like this:
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
                 mfmsr %0;":"=r"(c) :  );
 
         printk("%x\n",c);
 }
 
 int init_module(void)
 {
             hw_disable_irq();
 }
 
 void cleanup_module(void)
 {
 }
 
 MODULE_LICENSE("GPL");

 
 I can get the output is 0x21030. But I also use BDI2000 here and when I halt the board from BDI2000, I get
 405EP>halt
     Core number            : 0
     Core state                 : debug mode
     Debug entry cause : JTAG stop request
     Current PC               : 0xc00042d8
     Current CR               : 0x22004082
     Current MSR           : 0x00029030
     Current LR               : 0xc00042d8
 Hope my understanding for big endian is right. It seems 0x00029030 in MSR is
 00000000 00000010 10010000 00110000, but 0x21030 is
 00000000 00000010 00010000 00110000.
 It seems the 16th bit (EE) has been set to 0, but what should I do to make sure whether the external interrupt is disabled or not? Thank you very much.

Grant Likely <grant.likely@secretlab.ca> Ð´µÀ£º On 3/28/07, Zhou Rui  wrote:
> Hi, all
>     I am trying to disable interrupt on a PPC405EP board. I have checked
> from the 405 maunual that once the EE bit of MSR is set to 0, the external
> interrupt will be disabled. So I write a simple test module for that:
>
> #ifndef MODULE
> #define MODULE
> #endif
>
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
>
> #include 

> #include 

> #include 

> #include 

>
> void hw_disable_irq (void) {
>         int c;
>         __asm__ __volatile__(
>                 "mfmsr %%r0; \
>                 wrteei 0; \
>                 mfmsr %0;":"=r"(c) : );
>
>         printk("%h\n",c);
> }
>
> int init_module(void)
> {
> }
>
> void cleanup_module(void)
> {
> }
>
> MODULE_LICENSE("GPL");
>
> When I insert this module, it seems nothing happens and there is no output
> of the varible "c". So would you like to tell me what the problem is here?
> Thank you very much.

Umm, because this modules doesn't do anything perhaps?  You've
declared init and cleanup routines, but there are two problems with
them.
1. You haven't used the module_init and module_exit macros to actually
register them as init/exit routines.
2. They're empty

There is no possible way for your hw_disable_irq() routine to get called.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
Sorry for my silly mistake, and I modify it like this:
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
                mfmsr %0;":"=r"(c) :  );

        printk("%x\n",c);
}

int init_module(void)
{
            hw_disable_irq();
}

void cleanup_module(void)
{
}

MODULE_LICENSE("GPL");


I can get the output is 0x21030. But I also use BDI2000 here and when I halt the board from BDI2000, I get
405EP>halt
    Core number            : 0
    Core state                 : debug mode
    Debug entry cause : JTAG stop request
    Current PC               : 0xc00042d8
    Current CR               : 0x22004082
    Current MSR           : 0x00029030
    Current LR               : 0xc00042d8
Hope my understanding for big endian is right. It seems 0x00029030 in MSR is
00000000 00000010 10010000 00110000, but 0x21030 is
00000000 00000010 00010000 00110000.
It seems the 16th bit (EE) has been set to 0, but what should I do to make sure whether the external interrupt is disabled or not? Thank you very much.


Best wishes

Zhou Rui
Distributed and Embedded System Lab
Room 532, Information Building
School of Information Science
 		
---------------------------------
ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡ 
--0-837925074-1175142024=:60794
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi<br>Sorry for my silly mistake, and I modify it like this:<br> #ifndef MODULE<br> #define MODULE<br> #endif<br> <br> #ifndef __KERNEL__<br> #define __KERNEL__<br> #endif<br> <br> #include &lt;linux/module.h&gt;<br> #include &lt;linux/kernel.h&gt;<br> #include &lt;linux/types.h&gt;<br> #include &lt;linux/errno.h&gt;<br> <br> void hw_disable_irq (void) {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int c;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "mfmsr %%r0; \<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wrteei 0; \<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfmsr %0;":"=r"(c) :  );<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%x\n",c);<br> }<br> <br> int init_module(void)<br> {<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp; 
 hw_disable_irq();<br> }<br> <br> void cleanup_module(void)<br> {<br> }<br> <br> MODULE_LICENSE("GPL");<br><br> <br> I can get the output is 0x21030. But I also use BDI2000 here and when I halt the board from BDI2000, I get<br> 405EP&gt;halt<br> &nbsp;&nbsp;&nbsp; Core number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br> &nbsp;&nbsp;&nbsp; Core state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : debug mode<br> &nbsp;&nbsp;&nbsp; Debug entry cause : JTAG stop request<br> &nbsp;&nbsp;&nbsp; Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc00042d8<br> &nbsp;&nbsp;&nbsp; Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x22004082<br> &nbsp;&nbsp;&nbsp; Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x00029030<br> &nbsp;&nbsp;&nbsp; Current
 LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc00042d8<br> Hope my understanding for big endian is right. It seems 0x00029030 in MSR is<br> 00000000 00000010 <span style="color: rgb(255, 0, 0);">1</span>0010000 00110000, but 0x21030 is<br> 00000000 00000010 <span style="color: rgb(255, 0, 0);">0</span>0010000 00110000.<br> It seems the 16th bit (EE) has been set to 0, but what should I do to make sure whether the external interrupt is disabled or not? Thank you very much.<br><b><i><br>Grant Likely &lt;grant.likely@secretlab.ca&gt;</i></b> Ð´µÀ£º<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On 3/28/07, Zhou Rui <vancasperz@yahoo.com.cn> wrote:<br>&gt; Hi, all<br>&gt;     I am trying to disable interrupt on a PPC405EP board. I have checked<br>&gt; from the 405 maunual that once the EE bit of MSR is set to 0, the external<br>&gt; interrupt will be disabled. So I
 write a simple test module for that:<br>&gt;<br>&gt; #ifndef MODULE<br>&gt; #define MODULE<br>&gt; #endif<br>&gt;<br>&gt; #ifndef __KERNEL__<br>&gt; #define __KERNEL__<br>&gt; #endif<br>&gt;<br>&gt; #include <linux module.h=""><br>&gt; #include <linux kernel.h=""><br>&gt; #include <linux types.h=""><br>&gt; #include <linux errno.h=""><br>&gt;<br>&gt; void hw_disable_irq (void) {<br>&gt;         int c;<br>&gt;         __asm__ __volatile__(<br>&gt;                 "mfmsr %%r0; \<br>&gt;                 wrteei 0; \<br>&gt;                 mfmsr %0;":"=r"(c) : );<br>&gt;<br>&gt;         printk("%h\n",c);<br>&gt; }<br>&gt;<br>&gt; int init_module(void)<br>&gt; {<br>&gt; }<br>&gt;<br>&gt; void cleanup_module(void)<br>&gt; {<br>&gt; }<br>&gt;<br>&gt; MODULE_LICENSE("GPL");<br>&gt;<br>&gt; When I insert this module, it seems nothing happens and there is no output<br>&gt; of the varible "c". So would you like to tell me what the problem is here?<br>&gt; Thank you very
 much.<br><br>Umm, because this modules doesn't do anything perhaps?  You've<br>declared init and cleanup routines, but there are two problems with<br>them.<br>1. You haven't used the module_init and module_exit macros to actually<br>register them as init/exit routines.<br>2. They're empty<br><br>There is no possible way for your hw_disable_irq() routine to get called.<br><br>Cheers,<br>g.<br><br>-- <br>Grant Likely, B.Sc. P.Eng.<br>Secret Lab Technologies Ltd.<br>grant.likely@secretlab.ca<br>(403) 399-0195<br></linux></linux></linux></linux></vancasperz@yahoo.com.cn></blockquote>Sorry for my silly mistake, and I modify it like this:<br>#ifndef MODULE<br>#define MODULE<br>#endif<br><br>#ifndef __KERNEL__<br>#define __KERNEL__<br>#endif<br><br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/kernel.h&gt;<br>#include &lt;linux/types.h&gt;<br>#include &lt;linux/errno.h&gt;<br><br>void hw_disable_irq (void) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int
 c;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "mfmsr %%r0; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wrteei 0; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfmsr %0;":"=r"(c) :  );<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%x\n",c);<br>}<br><br>int init_module(void)<br>{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  hw_disable_irq();<br>}<br><br>void cleanup_module(void)<br>{<br>}<br><br>MODULE_LICENSE("GPL");<br><br><br>I can get the output is 0x21030. But I also use BDI2000 here and when I halt the board from BDI2000, I get<br>405EP&gt;halt<br>&nbsp;&nbsp;&nbsp; Core number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>&nbsp;&nbsp;&nbsp; Core
 state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : debug mode<br>&nbsp;&nbsp;&nbsp; Debug entry cause : JTAG stop request<br>&nbsp;&nbsp;&nbsp; Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc00042d8<br>&nbsp;&nbsp;&nbsp; Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x22004082<br>&nbsp;&nbsp;&nbsp; Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x00029030<br>&nbsp;&nbsp;&nbsp; Current LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc00042d8<br>Hope my understanding for big endian is right. It seems 0x00029030 in MSR is<br>00000000 00000010 10010000 00110000, but 0x21030 is<br>00000000 00000010 00010000 00110000.<br>It seems the 16th bit (EE) has been set to 0, but what should I do to make sure whether the external interrupt is disabled or not? Thank
 you very much.<br><BR><BR>Best wishes<br><br>Zhou Rui<br>Distributed and Embedded System Lab<br>Room 532, Information Building<br>School of Information Science<p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com" target=blank>ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡</a> 
--0-837925074-1175142024=:60794--
