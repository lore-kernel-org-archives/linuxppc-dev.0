Date: Thu, 12 Jun 2003 16:05:24 -0400 (EDT)
From: Chris Studholme <cvs@cs.utoronto.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: pismo upgraded to 750fx not detected correctly
Message-ID: <Pine.LNX.4.44.0306121603120.1349-100000@ike>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I have a Powerbook G3 (Pismo) 400MHz that I've been running Linux on for
almost 3 years now.  It has been working great, but to ensure that it
continues to serve me well, I purchased the Powerlogix BlueChip G3 900MHz
upgrade <http://www.powerlogix.com/products2/bcg3pismo/index.html>.  The
machine still runs Linux ok, but I have a few problems.

First off, the new processor is an IBM 750FX, but it is recognized as a
740/750.

  $ cat /proc/cpuinfo
  cpu             : 740/750
  temperature     : 20 C (uncalibrated)
  clock           : 550MHz
  revision        : 2.2 (pvr 0008 0202)
  bogomips        : 1795.68
  machine         : PowerBook3,1
  motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
  detected as     : 70 (PowerBook Pismo)
  pmac flags      : 00000007
  L2 cache        : 1024K unified
  memory          : 256MB
  pmac-generation : NewWorld

I believe pvr should be 7000 0202.  Also, the clock speed is 900MHz, not
550MHz.  I have verified, using some numerical cpu bound programs I have,
that this machine is running at least twice as fast as it did before the
upgrade.  Also, note that the bogomips value seems to imply the machine is
actually running at 900MHz.  Finally, the L2 cache is now only 512K, but
included on the processor die running at 900MHz.

I don't know the linux source that well, but it looks to me like these
values are being read from the open firmware and not from the cpu
directly.  Is there a way I can alter linux to double check the values and
correct them if the firmware is wrong?  As a first stab at the problem, I
made the following change to arch/ppc/kernel/cputable.c (in 2.4.20-ben10):

*** cputable.c.orig     Tue May 27 16:38:20 2003
--- cputable.c  Tue May 27 16:42:14 2003
***************
*** 161,166 ****
--- 161,175 ----
        32, 32,
        __setup_cpu_750fx
      },
+     { /* 750FX (Powerlogix Pismo upgrade) */
+       0xffffffff, 0x00080202, "750FX",
+       CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+       CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
+       CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
+       COMMON_PPC,
+       32, 32,
+       __setup_cpu_750fx
+     },
      { /* 740/750 (L2CR bit need fixup for 740) */
        0xffff0000, 0x00080000, "740/750",
        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |

This corrects cpuinfo slightly, but is obviously not a very good solution.

  $ cat /proc/cpuinfo
  cpu             : 750FX
  temperature     : 20 C (uncalibrated)
  clock           : 550MHz
  revision        : 2.2 (pvr 0008 0202)
  bogomips        : 1795.68
  machine         : PowerBook3,1
  motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
  detected as     : 70 (PowerBook Pismo)
  pmac flags      : 0000000f
  L2 cache        : 1024K unified
  memory          : 256MB
  pmac-generation : NewWorld

Also, note that MacOS also fails to correctly detect the cpu and clock
speed.  To get the correct values and fiddle with the 750fx's fancy
features (like clock speed scaling), I had to install a tool developed by
Powerlogix called CPU Director
<http://www.powerlogix.com/support2/cpudirector/index.html>.

My motivation for this work is not just to get cpuinfo to display the
correct data, but to get cpufreq working on this machine.  With the
following patch to arch/ppc/platforms/pmac_cpufreq.c I think I've come
close.

*** pmac_cpufreq.c.orig Wed May 21 23:33:27 2003
--- pmac_cpufreq.c      Thu Jun 12 14:22:22 2003
***************
*** 19,25 ****
  #include <asm/cputable.h>
  #include <asm/time.h>

! #undef DEBUG_FREQ

  extern void low_choose_750fx_pll(int pll);
  extern void low_sleep_handler(void);
--- 19,25 ----
  #include <asm/cputable.h>
  #include <asm/time.h>

! #define DEBUG_FREQ

  extern void low_choose_750fx_pll(int pll);
  extern void low_sleep_handler(void);
***************
*** 304,309 ****
--- 304,318 ----
                has_freq_ctl = 1;
                cpufreq_uses_pmu = 1;
        }
+       /* Else check for Pismo/Powerlogix 900 */
+       else if (machine_is_compatible("PowerBook3,1")) {
+               printk("CPUFREQ: pismo detected\n");
+               cur_freq = 900000;
+               low_freq = 400000;
+               hi_freq = 900000;
+               cpufreq_uses_pmu = 0;
+               has_freq_ctl = 1;
+       }
        /* Else check for 750FX */
        else if (PVR_VER(mfspr(PVR)) == 0x7000) {
                if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)

After boot with this change, I get:

  $ cat /proc/cpuinfo
  cpu             : 750FX
  temperature     : 20 C (uncalibrated)
  clock           : 900MHz
  revision        : 2.2 (pvr 0008 0202)
  bogomips        : 1795.68
  machine         : PowerBook3,1
  motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
  detected as     : 70 (PowerBook Pismo)
  pmac flags      : 0000000f
  L2 cache        : 1024K unified
  memory          : 256MB
  pmac-generation : NewWorld
  $ cat /proc/cpufreq
            minimum CPU frequency  -  maximum CPU frequency  -  policy
  CPU  0       400000 kHz ( 44 %)  -     900000 kHz (100 %)  -  performance

Now, I can try to change processor speed as follows:

  # echo -n "0:0:0:powersave" > /proc/cpufreq
  # cat /proc/cpuinfo
  cpu             : 750FX
  temperature     : 24 C (uncalibrated)
  clock           : 400MHz
  revision        : 2.2 (pvr 0008 0202)
  bogomips        : 798.08
  machine         : PowerBook3,1
  motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
  detected as     : 70 (PowerBook Pismo)
  pmac flags      : 0000000f
  L2 cache        : 1024K unified
  memory          : 256MB
  pmac-generation : NewWorld
  # cat /proc/cpufreq
            minimum CPU frequency  -  maximum CPU frequency  -  policy
  CPU  0       400000 kHz ( 44 %)  -     400000 kHz ( 44 %)  -  powersave

And to return to top speed:

  # echo -n "0:900000:900000:performance" > /proc/cpufreq
  # cat /proc/cpuinfo
  cpu             : 750FX
  temperature     : 39 C (uncalibrated)
  clock           : 900MHz
  revision        : 2.2 (pvr 0008 0202)
  bogomips        : 1795.68
  machine         : PowerBook3,1
  motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
  detected as     : 70 (PowerBook Pismo)
  pmac flags      : 0000000f
  L2 cache        : 1024K unified
  memory          : 256MB
  pmac-generation : NewWorld
  # cat /proc/cpufreq
            minimum CPU frequency  -  maximum CPU frequency  -  policy
  CPU  0       900000 kHz (100 %)  -     900000 kHz (100 %)  -  performance

Relevent lines from `dmesg` are:

  Memory BAT mapping: BAT2=256Mb, BAT3=0Mb, residual: 0Mb
  Total memory = 256MB; using 512kB for hash table (at c0280000)
  Linux version 2.4.20-ben10 (cvs@achilles) (gcc version 2.95.4 20011002 (Debian prerelease)) #10 Thu May 29 16:51:37 EDT
  Found Uninorth memory controller & host bridge, revision: 7
  Mapped at 0xfdffc000
  Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf7c000
  Processor NAP mode on idle enabled.
  PowerMac motherboard: PowerBook Pismo
  CPU HID1 : 0x92000000

  .. other stuff ..

  Initializing RT netlink socket
  Thermal assist unit using timers, shrink_timer: 200 jiffies
  CPUFREQ: pismo detected
  Starting kswapd

  .. other stuff ..

  Linux Kernel Card Services 3.1.22
    options:  [pci] [cardbus] [pm]
  Yenta IRQ list 0000, PCI irq58
  Socket status: 30000086
  HID1, before: 92000000
  HID1, after: 92010000
  Calibrating delay loop... 897.84 BogoMIPS
  HID1, before: 92010000
  HID1, after: 92000000
  Calibrating delay loop... 1795.68 BogoMIPS

Note that at low speed (400MHz), the bogomips value reported in cpuinfo is
as expected, but the debug message above seems to indicate a clock speed
of 450MHz.

Anyway, all this appeared quite nice, but it doesn't work.  I wrote the
following little program to try to verify the cpu freq change:

  #include <stdio.h>
  #include <time.h>

  int main() {
    clock_t start,end;
    int i,j;
    do {
      start = clock();
      j = 0;
      for (i=0; i<100*1000*1000; ++i) j+=i;
      end = clock();
      printf("%d\n",(int)(end-start));
    } while (1);
    return 0;
  }

and compiled it without any optimization.  Here's some sample output:

  $ ./speed
  1150000
  1140000
  1140000
  1140000
  1150000
  1150000
  1140000
  1140000
  1120000
  1090000
  1130000
  1140000
  1150000

These lines are output about one per second.  I expect both the number and
the rate at which the lines are output to change by about a factor of 2
when the cpu freq changes; however, this does not happen.

At this point, I'm stuck.  I hope you can provide comments and
suggestions.  Please let me know if there is any more info I can provide
or if there is something else I should try.  Thanks.

Chris.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
