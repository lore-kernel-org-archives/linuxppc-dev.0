Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id E6B0967B16
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 07:18:49 +1000 (EST)
Message-ID: <42545228.9060003@xiphos.ca>
Date: Wed, 06 Apr 2005 17:18:32 -0400
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: rtai@rtai.org
Subject: Unhandled relocation of type 11
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please excuse this cross-post, but I think it is of interest to both 
RTAI and Linux PPC folks.

I am making a kernel module (an RTAI task) that needs floating point 
support so I'm using IBMs perflib floating-point libraries (on a 
Virtex-II Pro, aka ppc405).

This is actually built from Matlab/simulink real-time workshop output (I 
can't use rtai-lab because I don't think lxrt is available for ppc)... 
so there end up being many object files to link.

So, in the end I have a linker command as follows.

powerpc-405-linux-gnu-ld -r -m elf32ppclinux -L/some/directories
matlab_root/rtw/c/libsrc/rt_zcfcn.o other.o inputs.o -o module_output.o
perflibs/fpopt/libppcfp.a

Then I go to insert the module and....
/var/shm # insmod test001_build_rtmodule.o
Warning: loading test001_build_rtmodule.o will taint the kernel: non-GPL 
license - Proprietary
  See http://www.tux.org/lkml/#export-tainted for information about 
tainted modules
test001_build_rtmodule.o: Unhandled relocation of type 11 for __fixdfsi
test001_build_rtmodule.o: Unhandled relocation of type 11 for __fixdfsi

Hrmm... so any ideas on what type 11 is?  I can see from the code in 
modutils that this value is inside rel->r_info, such as R_PPC_ADDR32 or 
R_PPC_ADDR16_HA.

But where do I get more info about where r_info gets assigned?  Do I 
need to link libppcfp.a in a particular way?

Any hints would be appreciated.

Thanks in advance.

Joshua

-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.
