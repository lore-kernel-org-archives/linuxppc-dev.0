Date: 7 Nov 2001 14:35:57 -0000
Message-ID: <20011107143557.14912.qmail@mailweb32.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: EPIC Initizn
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Reader,
 I m trying to enable linux on a sandpoint X2 board.,
hosting MPC8240. EPIC is proving to be a great pain for
me.
 I have initialized the EPIC to generate vectors
from 16-40 and the 8259 generates vector from 0-15.
s6 is down and 8259 is connected to IRQ1 of EPIC.
 All interrupts are LevelTriggered
and have -ve polarity. ( I have changed 8259 initz,
so that 8259 generates LEVEL triggered interrupts
just like the PCI devices ). The "get_irq" functin
has also been properly written. ( check for cascade
etc..)
   I had setup the IRQ in pci_dev structure according
to their slot/pin configuration.

 I am trying to NFS mount the ROOT file system.

 The linux code is able to identify the NE2K ethernet
card sitting on PCI bus and is able to talk with it.
But my problem is that I am not getting interrupts.
( I verified by putting a printk in the ei_interrupt
 code )
 Another puzzling fact is that, if I program IRQ 16
( used by the NE2k driver. Card slot num 16,
  and hence connected to IRQ0 of EPIC ) of the EPIC for
+ve polarity & Level Triggered , I get non-stop
continous interrupts which just freeze the CPU.
  I am using the OpenPIC code, with slight modifns
(modifns invovle chaning the OpenPIC data structure
to reflect the  EPIC register layout.. added a PADding..
Another one is, I had changed OpenPIC init so that
it initializes for 16-40 ( 16 inclusive ). )

  I just checked Mvista code. The "disable_IRQ" and
"enable_IRQ" OpenPIC functions have been slightly changed
to suit LEVEL triggered interrupt handling,
May I know the necessity of the change ? My code
doesnt work even after incorporating this  fundaa
into mine.

  Am I missing something ??
  Any help would be greatly appreciated.

Sincerely
Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
