Message-ID: <3E198948.4090709@elitedvb.net>
Date: Mon, 06 Jan 2003 14:48:56 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: non-PCI OHCI (STBxxxx)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

i'm using a IBM STB04xxx-based system (PPC405 core with Set-Top-Box MPEG
functions as well as some other stuff), which has an integrated OHCI
controller  i'd like to use.
Obviously there is no PCI bus on that system, so it's not as simple as
possible.

I hacked a 2.4.19-preX ohci-driver to use some consistent_alloc, _sync
instead of the pci functions and hardcoded baseaddress and IRQ. This
worked (a bit), but was very unstable and stopped working totally with
-rc3. Don't know what exactly changed, since i'm very new into USB at
all, and i'm really unable to debug what's going wrong for example on
"device not accepting new address" etc., since this already requires
working USB transfers etc.

A  bit disappointed by commtens in ohci.h which state that it's "not so
easy" to use non-PCI OHCI controllers i looked into the SA1111-case, but
- well, it didn't helped me too much and seems to require huge hacks
(for example they emulate the pci-functions.. or is that the way to go?)

I then tried to use a 2.5 kernel. The ohci-stuff is well structured
there, and i made some ohci-ocp.c and hacked the use of the
pci-functions again. Result was a working USB support, but somewhere
there's still an error, as there is some data inconsistency. for
example, i burned an audio cd, and it contained noise about every
second. When i read a FAT disk, there're randomly some "invalid cluster
chain" error messages etc. Maybe some cache problems. Don't know, and as
said, i'm unable to debug this further without help :(

So i'm asking: Is there any standard approach to this? Maybe there's
already a patch flying around? If someone from Monta Vista is reading
this: Is this going to be supported?

If not: How is this going to be? What exactly are the issues regarding
consistent_alloc, _sync versus their pci-variants? Is it maybe possible
to USE the pci-functions with some dummy pci device?

If i understand correctly,
consistent_alloc allocates contigouus, non-pagable memory which is
directly mapped to bus-addresses,
consistent_sync flushes all writeback caches (if TODEVICE) or
invalidates them (if FROMDEVICE)

is this correct? Do pci_pool_alloc alloc compatible memory? does
pci_map_single "nothing more" (in functional meaning, if we don't look
at other, more complex hardware/bridges) that a consistent_sync and
bus2virt?

And finally: I usually ioremap() to use hardware memory. What's the
difference of using ioremap() vresus bus2virt and virt2bus? are they
deprecated ? are they only possible after an ioremap? or is
kernel-memory all the time mapped to bus addresses which can be
retrieved using virt2bus?

thanks in advance,
Felix Domke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
