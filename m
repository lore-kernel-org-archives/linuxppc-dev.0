Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 44275DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 18:15:09 +1100 (EST)
Sender: miltonm@bga.com
From: "Milton Miller" <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org,linux-kbuild@vger.kernel.org
Subject: [BUG] ppc64 relocatable vmlinux builds even with undefined symbols
Date: Wed, 19 Nov 2008 01:14:49 -0600
Message-id: <4923bce9.bc.3e34.1353742792@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: Paul Mackerras <paulus@samba.org>
Reply-To: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the additon of -pie to build CONFIG_RELOCATABLE
CONFIG_PPC64 kernels, even
if a function is undefined we still get a vmlinux,
System.map, and other files
with no error message.
 
This is with binutils 2.17 as built by debian
 
with 2.6.28-rc5, CONFIG_EMBEDDED=y CONFIG_HOTPLUG=n
CONFIG_PCI=y, CONFIG_RELOCATABLE=n
 
arch/powerpc/kernel/built-in.o: In function
`.pcibios_remove_root_bus':
(.text+0x12dc4): undefined reference to
`.pcibios_unmap_io_space'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2
 
 
with CONFIG_RELOCATABLE=y
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map

Note that we set -pie for this combination.  I tried adding
seperately both
--no-undefined and --no-allow-shlib-undefined to
LDFLAGS_vmilnux,
but the link still did not error out.

I note that nm -u will detect the U symbol:

$ nm -u /tmp/p-test/vmlinux                  w mach_cell
                 w mach_iseries
                 w mach_powermac
                 U pcibios_unmap_io_space

but that would either require duplicating cmd_vmlinux and
adding an additonal
check or modifing rule_vmlinux. 

milton 
