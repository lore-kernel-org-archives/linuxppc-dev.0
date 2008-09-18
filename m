Return-Path: <blackfin.kang@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.190])
	by ozlabs.org (Postfix) with ESMTP id C07E1DDF9C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 23:49:35 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so2229191tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 06:49:34 -0700 (PDT)
Message-ID: <a7f827420809180649j1f0c6005iea4b9bc82aff3dad@mail.gmail.com>
Date: Thu, 18 Sep 2008 21:49:34 +0800
From: Michael.Kang <blackfin.kang@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: confusions of boot sequence in MPC8572?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yu Chen <chyyuu@gmail.com>, Xin-Xin.Yang@freescale.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am reading the boot code in arch/powerpc/kernel/head_fsl_booke.S for
MPC8572( dual e500 core). The second core will encounter the following
code:

 319 #ifdef CONFIG_SMP
 320         /* Check to see if we're the second processor, and jump
 321          * to the secondary_start code if so
 322          */
 323         mfspr   r24,SPRN_PIR
 324         cmpwi   r24,0
 325         bne     __secondary_start
 326 #endif

And jump to __secondary_start -> call_setup_cpu,  source code in
call_setup_cpu as the following:
112 _GLOBAL(call_setup_cpu)
113         addis   r4,r3,cur_cpu_spec@ha
114         addi    r4,r4,cur_cpu_spec@l
115         lwz     r4,0(r4)
116         add     r4,r4,r3
117         lwz     r5,CPU_SPEC_SETUP(r4)
118         cmpwi   0,r5,0
119         add     r5,r5,r3
120         beqlr
121         mtctr   r5
122         bctr

here it seems cur_cpu_spec here is not a valid value since
cur_cpu_spec will only be set in identify_cpu() [
arch/powerpc/kernel/cputable.c: 1301] later.

So what is my mistake? Who responsible for initialize cur_cpu_spec
variable for second core??

Thanks
MK



-- 
www.skyeye.org
