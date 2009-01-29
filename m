Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 96357DDF5B
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 06:52:25 +1100 (EST)
Message-ID: <498208E0.7000707@trimble.com>
Date: Thu, 29 Jan 2009 13:52:00 -0600
From: Mike Timmons <mike_timmons@trimble.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: toolchain for building linux-2.6.27.8 or 2.6.28.1  ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: mike_timmons@trimble.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote a couple days ago needing advice on USB wi fi. I made some 
progress but then I hit a snag loading the USB wi fi adapter firmware.

Jon schooled me on the firmware topic (thanks Jon), and advised me to 
select the following Kconfig options

Kconfig
Device drivers
  generic driver options
     user space firmware support
        check - include in-kernel firmware blobs in kernel binary


My 2.6.24 kernel didn't offer these options, and I also suspected that 
since 2.6.24 some progress on the ralink drivers I need has been made I 
figured I'd just try a new kernel build and try to get my 
ralink-equipped Linksys WUSB54GC to work.

Trouble:
-I was using  Ltib Toolchain (gcc-3.4.3-glibc-2.3.6 (for 603e)) to build 
my 2.6.24 kernel.
-It looks like somewhere after 2.6.24 this toolchain stopped 
successfully compiling the kernel.

So,
-I used crosstool and built 4.1.0 and 4.1.1 toolchains. Both produce the 
following error:

  OBJCOPY arch/powerpc/kernel/vdso32/vdso32.so
objcopy: Unable to recognise the format of the input file 
`arch/powerpc/kernel/vdso32/vdso32.so.dbg'
make[3]: *** [arch/powerpc/kernel/vdso32/vdso32.so] Error 1
make[2]: *** [arch/powerpc/kernel/vdso32] Error 2


Questions:
1) if I want to cross-compile a kernel later than 2.6.24 to hopefully 
get better WAN device support (and clearer options for fw loading), 
which kernel should I try, and which toolchain?

the ltib repository does not appear to have a toolchain newer than  
gcc-3.4.3-glibc-2.3.6 (for 603e)

Admissions, disclaimers, etc
1) I'm using the same ltib script I have used for the 2.6.24 build with 
toolchain gcc-3.4.3-glibc-2.3.6 (for 603e).
I'm simply modifying the kernel spec file to use 2.6.28.1 (and specifyin 
a custom toolchain).
I've also tried to compile 2.6.27.8. I get the same error.


I think I'm slipping into version compatibility hell at this point. 
Please throw me a rope if you can by way of advice if you can.

Thanks!

-Mike
