Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kn.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 87C62DE055
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 03:17:18 +1000 (EST)
Message-ID: <482486F7.3090805@nortel.com>
Date: Fri, 09 May 2008 11:16:39 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, roland@redhat.com, paulus@samba.org,
	benh@kernel.crashing.org
Subject: patch to install unstripped vDSO on disk breaks powerpc kernel build
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm using gcc 3.4.3 and binutils 2.15.92.0.2.  I originally saw the 
following problem in 2.6.25 but it's present in git head as well:

   CALL /home/cfriesen/kernels/2.6.25/linux-2.6.25/scripts/checksyscalls.sh
   CHK     include/linux/compile.h
   CALL 
/home/cfriesen/kernels/2.6.25/linux-2.6.25/arch/powerpc/kernel/systbl_chk.sh
   AS      arch/powerpc/kernel/systbl.o
   OBJCOPY arch/powerpc/kernel/vdso64/vdso64.so
BFD: arch/powerpc/kernel/vdso64/vdso64.so: The first section in the 
PT_DYNAMIC segment is not the .dynamic section
/home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-objcopy: 
arch/powerpc/kernel/vdso64/vdso64.so: Bad value
BFD: arch/powerpc/kernel/vdso64/vdso64.so: The first section in the 
PT_DYNAMIC segment is not the .dynamic section
/home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-objcopy: 
arch/powerpc/kernel/vdso64/vdso64.so: Bad value
make[3]: *** [arch/powerpc/kernel/vdso64/vdso64.so] Error 1
make[2]: *** [arch/powerpc/kernel/vdso64] Error 2
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [sub-make] Error 2



I installed git and bisected the problem.  It turns out that it's due to 
the following commit:


commit 8150caad02266623b5b9f58088d589f130fccd97
Author: Roland McGrath <roland@redhat.com>
Date:   Tue Oct 2 13:30:04 2007 -0700

[POWERPC] powerpc vDSO: install unstripped copies on disk
This keeps an unstripped copy of the vDSO images built before they are 
stripped and embedded in the kernel.  The unstripped copies get 
installed in $(MODLIB)/vdso/ by "make install".  These files can be 
useful when they contain source-level debugging information.

     Signed-off-by: Roland McGrath <roland@redhat.com>
     Cc: Sam Ravnborg <sam@ravnborg.org>
     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     Signed-off-by: Paul Mackerras <paulus@samba.org>



Anyone have any idea what's going on?


Thanks,

Chris
