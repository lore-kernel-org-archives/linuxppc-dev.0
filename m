Message-ID: <38745AC8.9923A42F@crf.canon.fr>
Date: Thu, 06 Jan 2000 10:05:12 +0100
From: Eric Valette <valette@crf.canon.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Official (non vger) Linux 2.2.14 still does not work on MCP750
 (Mesquite)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


1) first, as usual it does not compile due to missing #include
<asm/dma.h>
*** pmac_setup.c~       Tue Jan  4 19:12:12 2000
--- pmac_setup.c        Wed Jan  5 15:27:37 2000
***************
*** 56,61 ****
--- 56,62 ----
  #include <asm/feature.h>
  #include <asm/ide.h>
  #include <asm/machdep.h>
+ #include <asm/dma.h>
  
  #include "time.h"
  #include "local_irq.h"

2) God thing : the motorola Prep IDE handling has been corrected (byte
swapping
   problem). I can now read IDE disks that I can boot directly via
PPCBUG => hurra

3) BUT : I probably have no interrupts...

I have a bizarre message : Keyboard timeout[2]

and later I keep having message : hdc : lost interrupts allthough I
managed to correctly
read the hdc partition table after a while...


4) There is one thing I dislike it is the initialization of the
PCI/IDE/ISA/USB/XXX
bridge at several places including places that does not take into
account
specific IDE driver for the VIA... The VIA initialization is also
incorrect
as for the new boards, level/edge detection must be reprogrammed and
4d0/4d1 enabled
before doing so...

5) I still do not understand why PCI IRQ number reassigning is necessary
in 
prep_pcibios_fixup...

Once I fixes the bug I will post my patches on the list. Any suggestion
welcome...


-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
