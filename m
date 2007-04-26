Return-Path: <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: 64K page support for kexec
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1177539585.14873.202.camel@localhost.localdomain>
References: <1177439513.24866.5.camel@luke-laptop>
	<20070424194348.GA8371@lixom.net>
	<1177455014.14873.144.camel@localhost.localdomain>
	<1177529739.24866.34.camel@luke-laptop>
	<1177539585.14873.202.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 12:28:29 -0300
Message-Id: <1177601310.24866.94.camel@luke-laptop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-26 at 08:19 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2007-04-25 at 16:35 -0300, Luke Browning wrote:
> > This patch fixes a couple of kexec problems related to 64K page 
> > support in the kernel.  kexec issues a tlbie for each pte.  The 
> > parameters for the tlbie are the page size and the virtual address.
> > Support was missing for the computation of these two parameters
> > for 64K pages.  This patch adds that support.  
> > 
> > Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
> 
> Quick look: looks good to me. I suppose you verified it works well
> too :-)

yes.  but only on cell.  

> 
> (Have you added some debug to check we get the 16M case right ?)
> 
> Note that Milton is against using BUG_ON's in here since that code is
> used for crash dumps.

I would prefer to leave BUG_ON()s in the code as they work in many
cases.  It depends on how far you have get in the algorithm.  I added
BUG_ON(size == 16M) which is hit after a hundred entries or so have been
processed.  See output below.  I also put a BUG_ON() at the end of the
table scan but no output was presented so there are limitations, but I
don't believe that there is a downside.  The BUG_ON() at the end of the
sequence presented the original symptom so there is no difference from a
user perspective when the algorithm was completely broken.  During the
development of this feature, we encountered a lot of false hits though
as the system continued and experienced a bunch of false symptoms. This
is worse as it is better to have the system fail in a deterministic way
than to fail in random way.  Some of the failures that we experienced
were dma, timer, and module initialization problems.  These were all red
herrings.  Having BUG_ONs in the code allows developers to make
assertions about the code which is important when diagnosing strange
system crashes and provides a clue to future developers that they need
to add support for something.  Comments are fine, but asserts are better
in that they show up in cscope and other development tools.  So all
things considered I think it is better to include them.

Here's the 16M failure I mentioned above.

------------[ cut here ]------------
kernel BUG
at /home/luke/Desktop/code/cell/SDK3.0/Kexec2/linux-2.6.21-rc4/arch/!
cpu 0x0: Vector: 700 (Program Check) at [c000000000527bd0]
    pc: c00000000002f648: .native_hpte_clear+0x12c/0x220
    lr: c00000000002f568: .native_hpte_clear+0x4c/0x220
    sp: c000000000527e50
   msr: 9000000000021002
  current = 0xc0000000009fe860
  paca    = 0xc000000000454e80
    pid   = 1831, comm = sh
kernel BUG
at /home/luke/Desktop/code/cell/SDK3.0/Kexec2/linux-2.6.21-rc4/arch/!
enter ? for help
[c000000000527e50] 0000000000000000 .__start+0x4000000000000000/0x8
(unreliable)
[c000000000527ee0] c0000000000256b4 .kexec_sequence+0x78/0xac
[c000000000527f90] 0000000000000000 .__start+0x4000000000000000/0x8
[c000000001d13830] c00000000002ae00 .default_machine_kexec+0x1ec/0x1f0
[c000000001d138e0] c00000000002a58c .machine_kexec+0x3c/0x54
[c000000001d13950] c0000000000820a8 .crash_kexec+0x130/0x16c
[c000000001d13b30] c0000000001c0cb0 .sysrq_handle_crashdump+0x28/0x40
[c000000001d13bb0] c0000000001c087c .__handle_sysrq+0xe8/0x1c0
[c000000001d13c60] c000000000114dd8 .write_sysrq_trigger+0x7c/0xa8
[c000000001d13cf0] c0000000000c2364 .vfs_write+0xd8/0x1a4
[c000000001d13d90] c0000000000c2d2c .sys_write+0x4c/0x8c
[c000000001d13e30] c000000000008634 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000ff1a8fc
SP (f997f280) is in userspace


> Appart from that,
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Cheers,
> Ben.
> 
