Message-ID: <388804D3.DF16EE2F@mpifr-bonn.mpg.de>
Date: Fri, 21 Jan 2000 08:03:47 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: gcc 2.95/PPC bug
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When trying to find the cause for crashes of LAME, I think I found a
bug in the gcc.  The code below (which is actually a simpilified excerpt
from LAME) will NOT pass the parameter `buggy' correctly to the
subroutine.  Changing the number/type/sorting of the parameters will,
however, produce a working code in some cases.  Some facts about the
system:

  Machines: PowerMac 7300 (604e), LinuxPPC 2.2.11
	    PB "Lombard" (G3), LinuxPPC 2.2.12
  gcc:      versions 2.95 and 2.95.1
  options:  gcc -O0 -Wall gcc-2.95-ppc-bug.c -o gcc-2.95-ppc-bug

Is this a known (and hopefully already fixed ;-) bug, or should it go
directly to gcc-bugs@gcc.gnu.org?

Thanks, Albrecht.

---snip here:gcc-2.95-ppc-bug.c-----------------------------------------------
#include <stdio.h>

void vartest (double xr[2][2][576],
              int l3_enc[2][2][576],
              int var1, int var2, int var3, int var4, int var5, int var6,
              int var7, int var8, int var9, double var10, int buggy)
{
  printf ("%d %d %d %d %d %d %d %d %d %g %d\n",
          var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, buggy);
}

int main ()
{
  double xxx [2][2][576];
  int eee [2][2][576];

  vartest (xxx, eee, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10.1, 11);

  return 0;
}
---end of bug demo code-------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
