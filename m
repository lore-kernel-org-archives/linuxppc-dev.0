Date: Wed, 24 Mar 2004 13:26:52 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI Memory mapping
Message-ID: <20040324122652.GA22171@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston>
Mime-Version: 1.0
In-Reply-To: <1080086640.23208.164.camel@gaston>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just added a [1]
  flush_cache_all();

after copying the buffer from user space, no change.

The same for
__asm__ __volatile__("sync\n");

However, more and more things seem to point to either the DSP or 'the
hardware':

For testing purposes, I allocate a 4k buffer and pass the address of the
buffer +0x400 to the DSP (the corrupted data always occur in the firsts
28 words: from word 5 to word 28).

In userspace, I fill the 0x400 bytes with 0xFF and only use the last
0xC00 bytes with 'userful' data. The 4k buffer is passed to kernel space
where it is mapped on the PCI.

  PPC user
  +-------+
  | 0x400 |
  +-------+
  |       |
  | 0xC00 |
  |       |
  +-------+

     || copy_from_user
     \/

  PPC kern            DSP
  +-------+
  | 0x400 |
  +-------+        +-------+
  |       |  PCI   |       |
  | 0xC00 |  ===>  | 0xC00 |
  |       |        |       |
  +-------+        +-------+



The DSP only reads the last 3k bytes but still, it gets the corrupted
data from word 5 to word 32 when no (excessive) delays are used.

Next to this, consistent_alloc() already uses _PAGE_NO_CACHE to avoid
caching of the buffer (called by pci_consistent_alloc()) in cachemap.c
(yes, the 8245 kernel configuration does not enable
CONFIG_NOT_COHERENT_CACHE normally [2], but I added it but the behaviour
is still identical).

Filling the user buffer with 0xCA after copy_from_user and re-copying it
into the kernel buffer (without interrupting the DSP this time) still
has no effect: the 'corrupted' data is still old data from the last
PCI transferred data on the DSP side (after a subsequent copy_from_user
with useful data and DSP interrupt).

However the first PCI transferred buffer is ALWAYS correct.

On the other hand, this DSP-type did read via PCI master read
operations and a PCI plugin card memory from w32 on an x86 arch (instead
of our internal PCI bus) a couple of yrs ago I'm told.

[1] hmmmmm, this is helpful code for ppc :)

/*
 * No cache flushing is required when address mappings are
 * changed, because the caches on PowerPCs are physically
 * addressed.  -- paulus
 * Also, when SMP we use the coherency (M) bit of the
 * BATs and PTEs.  -- Cort
 */
#define flush_cache_all()               do { } while (0)


[2]
6xx/7xx/74xx/8260      CONFIG_6xx
instead of
CONFIG_8xx

as Processor Type.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
