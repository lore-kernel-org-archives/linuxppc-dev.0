Date: Mon, 15 Sep 2003 22:18:03 -0500
Subject: Re: combine PPC "general setup" and "platform setup"?
Content-Type: multipart/mixed; boundary=Apple-Mail-19--524262553
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Tom Rini <trini@kernel.crashing.org>
From: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <20030915151438.GC29517@ip68-0-152-218.tc.ph.cox.net>
Message-Id: <620524B0-E7F4-11D7-B6C9-000A95A0560C@penguinppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-19--524262553
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

On Monday, Sep 15, 2003, at 10:14 US/Central, Tom Rini wrote:

> On Fri, Sep 12, 2003 at 05:32:46PM -0500, Hollis Blanchard wrote:
>
>> In 2.5's menuconfig there are now two "general setup" sections; one is
>> generic and one is ours. We also have a "platform setup" section. It
>> seems like all our "general setup" questions could be folded into
>> "platform setup", e.g. "Workarounds for PPC601 bugs" and "Support for
>> Open Firmware device tree in /proc". Can we get rid of our "general
>> setup"?
>
> I suspect it's an artifact of before we had init/Kconfig.  In theory,
> we
> certainly should.  But if we kill it outright, our 'platform setup'
> gets
> quite large.  How about a bus options menu, like i386 has to break this
> up a bit (and some movement of options with that) ?

This is what I came up with. I tried to split our config options into 3
sections: "processor", "platform options", and "bus options". Maybe
that's not necessary, but... easy to combine them by removing 4 lines.
:) The diff itself is large; it may be better to look at the end result
instead. I didn't actually change any dependencies here, just moved
them around.

I noticed some obsolete config options (e.g. CONFIG_SERIAL_CONSOLE,
CONFIG_PC_KEYBOARD). Also, it's possible to create incorrect
configurations such as CONFIG_POWER3 and CONFIG_SPRUCE. Also, APUS
really deserves its own config file, and the "IBM 4xx options" menu
should be hidden if !CONFIG_4xx. A lot of configure help is also
missing, especially on embedded options. I figure these can be later
patches.

-Hollis


--Apple-Mail-19--524262553
Content-Disposition: attachment;
	filename=kconfig-ppc.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="kconfig-ppc.diff"

===== arch/ppc/Kconfig 1.52 vs edited =====
--- 1.52/arch/ppc/Kconfig	Fri Sep 12 17:47:46 2003
+++ edited/arch/ppc/Kconfig	Mon Sep 15 22:11:49 2003
@@ -2,6 +2,8 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #

+mainmenu "Linux/PowerPC Kernel Configuration"
+
 config MMU
 	bool
 	default y
@@ -20,32 +22,19 @@
 	bool
 	default y

-
-mainmenu "Linux/PowerPC Kernel Configuration"
-
-source "init/Kconfig"
-
-menu "Platform support"
-
 config PPC
 	bool
 	default y
-	---help---
-	  The PowerPC is a modern RISC architecture descended from the POWER
-	  architecture designed by IBM.  The PowerPC architecture is designed
-	  to allow high-speed implementations which can execute several
-	  instructions in each clock cycle.  IBM and Motorola design and
-	  manufacture PowerPC processors aimed at embedded, desktop and server
-	  applications.  PowerPC chips are used in Apple Power Macintoshes
-	  (including iMacs, iBooks and PowerBooks), in IBM pSeries (RS/6000)
-	  and iSeries (AS/400) machines, and in a broad range of embedded
-	  applications.  The Linux PowerPC port has a home page at
-	  <http://penguinppc.org/intro.shtml>.

 config PPC32
 	bool
 	default y

+
+source "init/Kconfig"
+
+menu "Processor"
+
 choice
 	prompt "Processor Type"
 	default 6xx
@@ -82,13 +71,149 @@
 	depends on 44x
 	default y

-source arch/ppc/platforms/4xx/Kconfig
+config ALTIVEC
+	bool "AltiVec Support"
+	depends on 6xx && !8260
+	---help---
+	  This option enables kernel support for the Altivec extensions to the
+	  PowerPC processor. The kernel currently supports saving and restoring
+	  altivec registers, and turning on the 'altivec enable' bit so user
+	  processes can execute altivec instructions.

-config GENERIC_ISA_DMA
+	  This option is only usefully if you have a processor that supports
+	  altivec (G4, otherwise known as 74xx series), but does not have
+	  any affect on a non-altivec cpu (it does, however add code to the
+	  kernel).
+
+	  If in doubt, say Y here.
+
+config TAU
+	bool "Thermal Management Support"
+	depends on 6xx && !8260
+	help
+	  G3 and G4 processors have an on-chip temperature sensor called the
+	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
+	  temperature within 2-4 degrees Celsius. This option shows the current
+	  on-die temperature in /proc/cpuinfo if the cpu supports it.
+
+	  Unfortunately, on some chip revisions, this sensor is very inaccurate
+	  and in some cases, does not work at all, so don't assume the cpu
+	  temp is actually what /proc/cpuinfo says it is.
+
+config TAU_INT
+	bool "Interrupt driven TAU driver (DANGEROUS)"
+	depends on TAU
+	---help---
+	  The TAU supports an interrupt driven mode which causes an interrupt
+	  whenever the temperature goes out of range. This is the fastest way
+	  to get notified the temp has exceeded a range. With this option off,
+	  a timer is used to re-check the temperature periodically.
+
+	  However, on some cpus it appears that the TAU interrupt hardware
+	  is buggy and can cause a situation which would lead unexplained hard
+	  lockups.
+
+	  Unless you are extending the TAU driver, or enjoy kernel/hardware
+	  debugging, leave this option off.
+
+config TAU_AVERAGE
+	bool "Average high and low temp"
+	depends on TAU
+	---help---
+	  The TAU hardware can compare the temperature to an upper and lower
+	  bound.  The default behavior is to show both the upper and lower
+	  bound in /proc/cpuinfo. If the range is large, the temperature is
+	  either changing a lot, or the TAU hardware is broken (likely on some
+	  G4's). If the range is small (around 4 degrees), the temperature is
+	  relatively stable.  If you say Y here, a single temperature value,
+	  halfway between the upper and lower bounds, will be reported in
+	  /proc/cpuinfo.
+
+	  If in doubt, say N here.
+
+config MATH_EMULATION
+	bool "Math emulation"
+	depends on 4xx || 8xx
+	---help---
+	  Some PowerPC chips designed for embedded applications do not have
+	  a floating-point unit and therefore do not implement the
+	  floating-point instructions in the PowerPC instruction set.  If you
+	  say Y here, the kernel will include code to emulate a floating-point
+	  unit, which will allow programs that use floating-point
+	  instructions to run.
+
+	  If you have an Apple machine or an IBM RS/6000 or pSeries machine,
+	  or any machine with a 6xx, 7xx or 7xxx series processor, say N
+	  here.  Saying Y here will not hurt performance (on any machine) but
+	  will increase the size of the kernel.
+
+config CPU_FREQ
+	bool "CPU Frequency scaling"
+	help
+	  Clock scaling allows you to change the clock speed of CPUs on the
+	  fly. This is a nice method to save battery power on notebooks,
+	  because the lower the clock speed, the less power the CPU consumes.
+
+	  For more information, take a look at linux/Documentation/cpufreq or
+	  at <http://www.brodo.de/cpufreq/>
+
+	  If in doubt, say N.
+
+config CPU_FREQ_TABLE
 	bool
-	depends on POWER3 || 6xx && !8260
+	depends on CPU_FREQ
 	default y

+config CPU_FREQ_PROC_INTF
+	bool "/proc/cpufreq interface (DEPRECATED)"
+	depends on CPU_FREQ && PROC_FS
+	help
+	  This enables the /proc/cpufreq interface for controlling
+	  CPUFreq. Please note that it is recommended to use the sysfs
+	  interface instead (which is built automatically).
+
+	  For details, take a look at linux/Documentation/cpufreq.
+
+	  If in doubt, say N.
+
+config CPU_FREQ_24_API
+	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
+	depends on CPU_FREQ
+	help
+	  This enables the /proc/sys/cpu/ sysctl interface for controlling
+	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
+	  uses a sysfs interface instead. Please note that some drivers do
+	  not work well with the 2.4. /proc/sys/cpu sysctl interface,
+	  so if in doubt, say N here.
+
+	  For details, take a look at linux/Documentation/cpufreq.
+
+	  If in doubt, say N.
+
+config CPU_FREQ_PMAC
+	bool "Support for Apple PowerBooks"
+	depends on CPU_FREQ && ADB_PMU
+	help
+	  This adds support for frequency switching on Apple PowerBooks,
+	  this currently includes some models of iBook & Titanium
+	  PowerBook.
+
+config PPC601_SYNC_FIX
+	bool "Workarounds for PPC601 bugs"
+	depends on 6xx && !POWER3
+	help
+	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
+	  mean that extra synchronization instructions are required near
+	  certain instructions, typically those that make major changes to the
+	  CPU state.  These extra instructions reduce performance slightly.
+	  If you say N here, these extra instructions will not be included,
+	  resulting in a kernel which will run faster but may not run at all
+	  on some systems with the PPC601 chip.
+
+	  If in doubt, say Y here.
+
+source arch/ppc/platforms/4xx/Kconfig
+
 config PPC64BRIDGE
 	bool
 	depends on POWER3
@@ -99,18 +224,17 @@
 	depends on 6xx || POWER3
 	default y

-config SERIAL_CONSOLE
-	bool
-	depends on 8xx || 8260
-	default y
-
 config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || 8xx
 	default y

+endmenu
+
+menu "Platform options"
+
 choice
-	prompt "Machine Type"
+	prompt "8xx Machine Type"
 	depends on 8xx
 	default RPXLITE

@@ -333,16 +457,6 @@

 endchoice

-config TQM8xxL
-	bool
-	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L || SM850)
-	default y
-
-config EMBEDDEDBOOT
-	bool
-	depends on 8xx || 8260
-	default y
-
 choice
 	prompt "Machine Type"
 	depends on 6xx || POWER3
@@ -463,6 +577,16 @@

 endchoice

+config TQM8xxL
+	bool
+	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L || SM850)
+	default y
+
+config EMBEDDEDBOOT
+	bool
+	depends on 8xx || 8260
+	default y
+
 config 8260
 	bool "MPC8260 CPM Support" if WILLOW
 	depends on 6xx
@@ -473,7 +597,6 @@
 	  you wish to build a kernel for a machine with specifically an 8260
 	  for a CPU.

-
 config PPC_CHRP
 	bool
 	depends on PPC_MULTIPLATFORM
@@ -504,6 +627,11 @@
 	depends on 6xx && (PCORE || POWERPMC250)
 	default y

+config GT64260
+	bool
+	depends on EV64260
+	default y
+
 config EPIC_SERIAL_MODE
 	bool
 	depends on 6xx && (LOPEC || SANDPOINT)
@@ -513,16 +641,6 @@
 	bool "Enable MPC10x store gathering"
 	depends on FORCE || SANDPOINT

-config GT64260
-	bool
-	depends on EV64260
-	default y
-
-config SERIAL_CONSOLE_BAUD
-	int
-	depends on EV64260
-	default "115200"
-
 config CPC710_DATA_GATHERING
 	bool "Enable CPC710 data gathering"
 	depends on K2
@@ -535,6 +653,24 @@
 	bool "Spruce baud clock support"
 	depends on SPRUCE

+config PC_KEYBOARD
+	bool "PC PS/2 style Keyboard"
+	depends on 4xx || 8260
+
+config SERIAL_CONSOLE
+	bool
+	depends on 8xx || 8260
+	default y
+
+config SERIAL_CONSOLE_BAUD
+	int
+	depends on EV64260
+	default "115200"
+
+config PPCBUG_NVRAM
+	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
+	default y if PPC_PREP
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -581,241 +717,15 @@
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.

-config ALTIVEC
-	bool "AltiVec Support"
-	depends on 6xx && !8260
-	---help---
-	  This option enables kernel support for the Altivec extensions to the
-	  PowerPC processor. The kernel currently supports saving and restoring
-	  altivec registers, and turning on the 'altivec enable' bit so user
-	  processes can execute altivec instructions.
-
-	  This option is only usefully if you have a processor that supports
-	  altivec (G4, otherwise known as 74xx series), but does not have
-	  any affect on a non-altivec cpu (it does, however add code to the
-	  kernel).
-
-	  If in doubt, say Y here.
-
-config TAU
-	bool "Thermal Management Support"
-	depends on 6xx && !8260
-	help
-	  G3 and G4 processors have an on-chip temperature sensor called the
-	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
-	  temperature within 2-4 degrees Celsius. This option shows the current
-	  on-die temperature in /proc/cpuinfo if the cpu supports it.
-
-	  Unfortunately, on some chip revisions, this sensor is very inaccurate
-	  and in some cases, does not work at all, so don't assume the cpu
-	  temp is actually what /proc/cpuinfo says it is.
-
-config TAU_INT
-	bool "Interrupt driven TAU driver (DANGEROUS)"
-	depends on TAU
-	---help---
-	  The TAU supports an interrupt driven mode which causes an interrupt
-	  whenever the temperature goes out of range. This is the fastest way
-	  to get notified the temp has exceeded a range. With this option off,
-	  a timer is used to re-check the temperature periodically.
-
-	  However, on some cpus it appears that the TAU interrupt hardware
-	  is buggy and can cause a situation which would lead unexplained hard
-	  lockups.
-
-	  Unless you are extending the TAU driver, or enjoy kernel/hardware
-	  debugging, leave this option off.
-
-config TAU_AVERAGE
-	bool "Average high and low temp"
-	depends on TAU
-	---help---
-	  The TAU hardware can compare the temperature to an upper and lower
-	  bound.  The default behavior is to show both the upper and lower
-	  bound in /proc/cpuinfo. If the range is large, the temperature is
-	  either changing a lot, or the TAU hardware is broken (likely on some
-	  G4's). If the range is small (around 4 degrees), the temperature is
-	  relatively stable.  If you say Y here, a single temperature value,
-	  halfway between the upper and lower bounds, will be reported in
-	  /proc/cpuinfo.
-
-	  If in doubt, say N here.
-
-config MATH_EMULATION
-	bool "Math emulation"
-	depends on 4xx || 8xx
-	---help---
-	  Some PowerPC chips designed for embedded applications do not have
-	  a floating-point unit and therefore do not implement the
-	  floating-point instructions in the PowerPC instruction set.  If you
-	  say Y here, the kernel will include code to emulate a floating-point
-	  unit, which will allow programs that use floating-point
-	  instructions to run.
-
-	  If you have an Apple machine or an IBM RS/6000 or pSeries machine,
-	  or any machine with a 6xx, 7xx or 7xxx series processor, say N
-	  here.  Saying Y here will not hurt performance (on any machine) but
-	  will increase the size of the kernel.
-
-config CPU_FREQ
-	bool "CPU Frequency scaling"
-	help
-	  Clock scaling allows you to change the clock speed of CPUs on the
-	  fly. This is a nice method to save battery power on notebooks,
-	  because the lower the clock speed, the less power the CPU consumes.
-
-	  For more information, take a look at linux/Documentation/cpufreq or
-	  at <http://www.brodo.de/cpufreq/>
-
-	  If in doubt, say N.
-
-config CPU_FREQ_TABLE
-	bool
-	depends on CPU_FREQ
-	default y
-
-config CPU_FREQ_PROC_INTF
-	bool "/proc/cpufreq interface (DEPRECATED)"
-	depends on CPU_FREQ && PROC_FS
-	help
-	  This enables the /proc/cpufreq interface for controlling
-	  CPUFreq. Please note that it is recommended to use the sysfs
-	  interface instead (which is built automatically).
-
-	  For details, take a look at linux/Documentation/cpufreq.
-
-	  If in doubt, say N.
-
-config CPU_FREQ_24_API
-	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
-	depends on CPU_FREQ
-	help
-	  This enables the /proc/sys/cpu/ sysctl interface for controlling
-	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
-	  uses a sysfs interface instead. Please note that some drivers do
-	  not work well with the 2.4. /proc/sys/cpu sysctl interface,
-	  so if in doubt, say N here.
-
-	  For details, take a look at linux/Documentation/cpufreq.
-
-	  If in doubt, say N.
-
-config CPU_FREQ_PMAC
-	bool "Support for Apple PowerBooks"
-	depends on CPU_FREQ && ADB_PMU
-	help
-	  This adds support for frequency switching on Apple PowerBooks,
-	  this currently includes some models of iBook & Titanium
-	  PowerBook.
-
-endmenu
-
-menu "General setup"
-
 config HIGHMEM
 	bool "High memory support"

-config ISA
-	bool "Support for ISA-bus hardware"
-	depends on PPC_PREP || PPC_CHRP
-	help
-	  Find out whether you have ISA slots on your motherboard.  ISA is the
-	  name of a bus system, i.e. the way the CPU talks to the other stuff
-	  inside your box.  If you have an Apple machine, say N here; if you
-	  have an IBM RS/6000 or pSeries machine or a PReP machine, say Y.  If
-	  you have an embedded board, consult your board documentation.
-
-config EISA
-	bool
-	help
-	  The Extended Industry Standard Architecture (EISA) bus is a bus
-	  architecture used on some older intel-based PCs.
-
-config SBUS
-	bool
-
-# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
-config MCA
-	bool
-	help
-	  MicroChannel Architecture is found in some older IBM RS/6000
-	  machines.  It is a bus system similar to PCI or ISA.  MCA-based
-	  RS/6000 machines are currently not supported by Linux.
-
-config PCI
-	bool "PCI support" if 40x || 8260
-	default y if !40x && !8260 && !8xx && !APUS
-	default PCI_PERMEDIA if !4xx && !8260 && !8xx && APUS
-	default PCI_QSPAN if !4xx && !8260 && 8xx
-	help
-	  Find out whether your system includes a PCI bus. PCI is the name of
-	  a bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box.  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support PCI bus devices.
-
-config PCI_DOMAINS
-	bool
-	default PCI
-
-config PC_KEYBOARD
-	bool "PC PS/2 style Keyboard"
-	depends on 4xx || 8260
-
-config PCI_QSPAN
-	bool "QSpan PCI"
-	depends on !4xx && !8260 && 8xx
-	help
-	  Say Y here if you have a system based on a Motorola 8xx-series
-	  embedded processor with a QSPAN PCI interface, otherwise say N.
-
-config PCI_PERMEDIA
-	bool "PCI for Permedia2"
-	depends on !4xx && !8xx && APUS
-
 config KERNEL_ELF
 	bool
 	default y

 source "fs/Kconfig.binfmt"

-source "drivers/pci/Kconfig"
-
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
-
-source "drivers/pcmcia/Kconfig"
-
-source "drivers/parport/Kconfig"
-
-config PPC601_SYNC_FIX
-	bool "Workarounds for PPC601 bugs"
-	depends on 6xx && !POWER3
-	help
-	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
-	  mean that extra synchronization instructions are required near
-	  certain instructions, typically those that make major changes to the
-	  CPU state.  These extra instructions reduce performance slightly.
-	  If you say N here, these extra instructions will not be included,
-	  resulting in a kernel which will run faster but may not run at all
-	  on some systems with the PPC601 chip.
-
-	  If in doubt, say Y here.
-
 config PROC_DEVICETREE
 	bool "Support for Open Firmware device tree in /proc"
 	depends on PPC_OF && PROC_FS
@@ -878,10 +788,6 @@
 	  (lsresidual) to parse it.  If you aren't on a PReP system, you don't
 	  want this.

-config PPCBUG_NVRAM
-	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
-	default y if PPC_PREP
-
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"

@@ -1032,6 +938,87 @@

 endmenu

+menu "Bus options"
+
+config ISA
+	bool "Support for ISA-bus hardware"
+	depends on PPC_PREP || PPC_CHRP
+	help
+	  Find out whether you have ISA slots on your motherboard.  ISA is the
+	  name of a bus system, i.e. the way the CPU talks to the other stuff
+	  inside your box.  If you have an Apple machine, say N here; if you
+	  have an IBM RS/6000 or pSeries machine or a PReP machine, say Y.  If
+	  you have an embedded board, consult your board documentation.
+
+config GENERIC_ISA_DMA
+	bool
+	depends on POWER3 || 6xx && !8260
+	default y
+
+config EISA
+	bool
+	help
+	  The Extended Industry Standard Architecture (EISA) bus is a bus
+	  architecture used on some older intel-based PCs.
+
+config SBUS
+	bool
+
+# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
+config MCA
+	bool
+
+config PCI
+	bool "PCI support" if 40x || 8260
+	default y if !40x && !8260 && !8xx && !APUS
+	default PCI_PERMEDIA if !4xx && !8260 && !8xx && APUS
+	default PCI_QSPAN if !4xx && !8260 && 8xx
+	help
+	  Find out whether your system includes a PCI bus. PCI is the name of
+	  a bus system, i.e. the way the CPU talks to the other stuff inside
+	  your box.  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support PCI bus devices.
+
+config PCI_DOMAINS
+	bool
+	default PCI
+
+config PCI_QSPAN
+	bool "QSpan PCI"
+	depends on !4xx && !8260 && 8xx
+	help
+	  Say Y here if you have a system based on a Motorola 8xx-series
+	  embedded processor with a QSPAN PCI interface, otherwise say N.
+
+config PCI_PERMEDIA
+	bool "PCI for Permedia2"
+	depends on !4xx && !8xx && APUS
+
+source "drivers/pci/Kconfig"
+
+config HOTPLUG
+	bool "Support for hot-pluggable devices"
+	---help---
+	  Say Y here if you want to plug devices into your computer while
+	  the system is running, and be able to use them quickly.  In many
+	  cases, the devices can likewise be unplugged at any time too.
+
+	  One well known example of this is PCMCIA- or PC-cards, credit-card
+	  size devices such as network cards, modems or hard drives which are
+	  plugged into slots found on all modern laptop computers.  Another
+	  example, used on modern desktops as well as laptops, is USB.
+
+	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
+	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
+	  Then your kernel will automatically call out to a user mode "policy
+	  agent" (/sbin/hotplug) to load modules and set up software needed
+	  to use devices as you hotplug them.
+
+source "drivers/pcmcia/Kconfig"
+
+source "drivers/parport/Kconfig"
+
+endmenu

 menu "Advanced setup"


--Apple-Mail-19--524262553--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
