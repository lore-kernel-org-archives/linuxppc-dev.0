Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18187.31582.236420.418530@cargo.ozlabs.ibm.com>
Date: Tue, 9 Oct 2007 23:00:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org, lkml@rtr.ca, linuxppc-dev@ozlabs.org
Subject: crash on shutdown on rs/6000 powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just seen a crash at shutdown with 2.6.23-rc9 on an RS/6000
powerpc box (POWER3, 64-bit).  It crashed immediately after printing
"Disabling non-boot CPUs", so I tried reverting 4047727e and that
fixed it.  It's unfortunate that that commit added the
disable_nonboot_cpus for all architectures, when only x86[-64] needs
it.  (At least it sounds like only x86[-64] needs it; the commit
message seems quite x86-centric.)

In case anyone on the linuxppc-dev list wants to chase this further,
the crash looks like this:

Disabling non-boot CPUs ...
cpu 0x1: Vector: 300 (Data Access) at [c00000003f923950]
    pc: c00000000003bf98: .xics_set_cpu_priority+0x58/0x78
    lr: c00000000003bff4: .xics_migrate_irqs_away+0x3c/0x20c
    sp: c00000003f923bd0
   msr: a000000000001032
   dar: 4
 dsisr: 42000000
  current = 0xc0000000bfb6b060
  paca    = 0xc00000000071c600
    pid   = 2610, comm = kstopmachine
enter ? for help
[c00000003f923c40] c00000000003bff4 .xics_migrate_irqs_away+0x3c/0x20c
[c00000003f923d00] c000000000040d54 .pseries_cpu_disable+0x98/0xb4
[c00000003f923d80] c000000000028e4c .__cpu_disable+0x44/0x58
[c00000003f923df0] c00000000007e204 .take_cpu_down+0x34/0x60
[c00000003f923e70] c00000000008ba3c .do_stop+0x144/0x1e4
[c00000003f923f00] c00000000006fd74 .kthread+0x78/0xc4
[c00000003f923f90] c0000000000272a8 .kernel_thread+0x4c/0x68

I don't have time tonight or tomorrow to track this down further.  I'm
taking the kids to the coast tommorow. :)

Paul.
