Message-ID: <39666CB7.DE6B2BC5@noos.fr>
Date: Sat, 08 Jul 2000 01:50:16 +0200
From: Guillaume Laurès <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Trying to enable backside on a G4
Content-Type: text/plain; charset=iso-8859-1; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm just starting writing kernel-level code :-), and I was trying to set
the L2CR register on a G4 upgrade for a PCI PowerMac (actually a
8600/250 upgraded with a XLR8 MACh Carrier G4 350/233)

So this is my code, extracted from arch/ppc/kernel/setup.c :

/* Programme réalisant l'initialisation du registre l2cr sur G3 ou G4
   08/07/00 Guillaume Laures
*/

#include <linux/config.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <linux/reboot.h>
#include <linux/delay.h>
#include <linux/blk.h>


int main()
{
  unsigned long val = 0xb5100000;       // XLR8 MACh Carrier G4 350/233
//  unsigned long val = 0xb9100000;       // XLR8 MACh Carrier G4
350/175
//  unsigned long val = 0xb9000000;       // Apple G4 450/225 SawTooth
cpu module
//  unsigned long val = 0xb5000000;       // Apple G4 450/300 ?

  if ( ((_get_PVR() >> 16) == 8) || ((_get_PVR() >> 16) == 12) )
    {
      printk(KERN_INFO "l2cr set to %lx\n", val);
      _set_L2CR(0);
//      _set_L2CR(val);
      return 0;
    }
  else
    return 1;
}

And here is my makefile :

all:            l2cr_ini

clean:
                rm -f l2cr_ini l2cr_ini.o

l2cr_ini.o:     l2cr_ini.c
                gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -c l2cr_ini.c

l2cr_ini:       l2cr_ini.o
                gcc -o l2cr_ini l2cr_ini.o

I can get the .o, but obviously not the executable, does anyone could
help me get it please ?

--
Guillaume


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
