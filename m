Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id B2FBA67C38
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 07:28:51 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1752105ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 14:28:48 -0700 (PDT)
Message-ID: <45a1b53e0608211428x645bea26t5e199db93acbf9ab@mail.gmail.com>
Date: Mon, 21 Aug 2006 16:28:48 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: ML403: module make fails with interesting error
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_50469_5706505.1156195728876"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_50469_5706505.1156195728876
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  I created an NFS disk using devrocket 2.03, copied the kernel image from a
devrocket build to the system.ace.  I booted the ml403 board and did an nfs
mount.  I copied the kernel directory created under the devrocket
2.03kernel project into /usr/src/linux

  I created a simple module:
-----------------------------------------------------------------------------------------------------------------
root@ml403:/home/moduletest# cat moduletest.c

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>

MODULE_DESCRIPTION("Test Kernel Module");
MODULE_AUTHOR("wade maxfield (maxfield@ctelcom.net)");
MODULE_LICENSE("$LICENSE$");

static int moduletest_init_module(void)
{
        printk( KERN_DEBUG "Module moduletest init\nHello World!\n" );
        return 0;
}

static void moduletest_exit_module(void)
{
        printk( KERN_DEBUG "Module moduletest exit\nGoodbye Cruel World!\n"
);
}

module_init(moduletest_init_module);
module_exit(moduletest_exit_module);
---------------------------------------------------------------------------------------------------------------------------
   This has compiled under RHEL 4.0 and worked.

   if I go do a build on the ml403 board I get the following (ignore the
time problems)
----------------------------------------------------------------------------------------------------------------------
root@ml403:/home/moduletest# make
make: Warning: File `Makefile' has modification time 1.2e+09 s in the future
make -C /lib/modules/2.6.10_mvl401-ml40x/build SUBDIRS=/home/moduletest
modules
make[1]: Entering directory `/usr/src/linux'
Makefile:503: .config: No such file or directory
make[1]: Warning: File `/usr/src/linux/arch/ppc/Makefile' has modification
time 1.2e+09 s in the future
make[2]: Warning: File `scripts/Makefile.lib' has modification time
1.1e+09s in the future
  CC [M]  /home/moduletest/moduletest.o
/bin/sh: line 1: scripts/basic/fixdep: cannot execute binary file
make[2]: *** [/home/moduletest/moduletest.o] Error 126
make[1]: *** [_module_/home/moduletest] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [default] Error 2
----------------------------------------------------------------------------------------------------------

    I think that "fixdep" was created as x86.  Any suggestions as to getting
fixdep to be powerpc executable?

thanks,
wade

------=_Part_50469_5706505.1156195728876
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>&nbsp; I created an NFS disk using devrocket 2.03, copied the kernel image from a devrocket build to the system.ace.&nbsp; I booted the ml403 board and did an nfs mount.&nbsp; I copied the kernel directory created under the devrocket 
2.03 kernel project into /usr/src/linux<br><br>&nbsp; I created a simple module:<br>-----------------------------------------------------------------------------------------------------------------<br>root@ml403:/home/moduletest# cat 
moduletest.c<br><br>#include &lt;linux/kernel.h&gt;<br>#include &lt;linux/init.h&gt;<br>#include &lt;linux/module.h&gt;<br><br>MODULE_DESCRIPTION(&quot;Test Kernel Module&quot;);<br>MODULE_AUTHOR(&quot;wade maxfield (<a href="mailto:maxfield@ctelcom.net">
maxfield@ctelcom.net</a>)&quot;);<br>MODULE_LICENSE(&quot;$LICENSE$&quot;);<br><br>static int moduletest_init_module(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk( KERN_DEBUG &quot;Module moduletest init\nHello World!\n&quot; );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
<br>}<br><br>static void moduletest_exit_module(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk( KERN_DEBUG &quot;Module moduletest exit\nGoodbye Cruel World!\n&quot; );<br>}<br><br>module_init(moduletest_init_module);<br>module_exit(moduletest_exit_module);
<br>---------------------------------------------------------------------------------------------------------------------------<br>&nbsp;&nbsp; This has compiled under RHEL 4.0 and worked.<br><br>&nbsp;&nbsp; if I go do a build on the ml403 board I get the following (ignore the time problems)
<br>----------------------------------------------------------------------------------------------------------------------<br>root@ml403:/home/moduletest# make<br>make: Warning: File `Makefile' has modification time 1.2e+09
 s in the future<br>make -C /lib/modules/2.6.10_mvl401-ml40x/build SUBDIRS=/home/moduletest modules<br>make[1]: Entering directory `/usr/src/linux'<br>Makefile:503: .config: No such file or directory<br>make[1]: Warning: File `/usr/src/linux/arch/ppc/Makefile' has modification time 
1.2e+09 s in the future<br>make[2]: Warning: File `scripts/Makefile.lib' has modification time 1.1e+09 s in the future<br>&nbsp; CC [M]&nbsp; /home/moduletest/moduletest.o<br>/bin/sh: line 1: scripts/basic/fixdep: cannot execute binary file
<br>make[2]: *** [/home/moduletest/moduletest.o] Error 126<br>make[1]: *** [_module_/home/moduletest] Error 2<br>make[1]: Leaving directory `/usr/src/linux'<br>make: *** [default] Error 2<br>----------------------------------------------------------------------------------------------------------
<br><br>&nbsp;&nbsp;&nbsp; I think that &quot;fixdep&quot; was created as x86.&nbsp; Any suggestions as to getting fixdep to be powerpc executable?<br><br>thanks,<br>wade<br><br>&nbsp;&nbsp; <br>

------=_Part_50469_5706505.1156195728876--
