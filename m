Message-ID: <276737EB1EC5D311AB950090273BEFDD01F4DB3F@elway.lss.emc.com>
From: "tsombakos, mark" <tsombakos_mark@emc.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Booting Sandpoint 8240??
Date: Thu, 22 Feb 2001 13:26:06 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Well, I got the thing to boot, though now I don't quite understand it.
  I ended up changing the address used in zsrec and the "go" address
  to "0x90000" instead of "0x900000".  I saw the memory map in the
  DINK32 manual that the "Start of user memory" is at 0x90000.  I figured
  it was a typo in the HHL CDK manual. So, life was good.  Until
  I realized the bootloader relocates to 0x80000. Now I'm confused again.

DINK32_MAX >>go 90000
loaded at:     00090000 000A4E20
relocated to:  00800000 00814E20
zimage at:     0009B000 0011B486
relocated to:  00815000 00895486

avail ram:     00400000 00800000


Since "avail ram" is 400000-800000, should I run srec -s (something <
800000)?
I know I read that it should be higher than the relocated image ...

Do these numbers just depend on the amount of ram present??

  confused,

  Mark



  -----Original Message-----

  <newbie alert!>

  I've just undertaken trying to get a Sandpoint 8240 to boot ppc linux.
  I have the mvista CDK 1.2, as well as the code from
  ftp://ftp.mvista.com:/pub/Area51/sandpoint-8240/README

  My development platform is RH6.2 linux. I'm running version
  12.0 of DINK.

  Here come the questions :)

  1)  I tried compiling the code in spdemo-2.3.16-2000.02.10, but
  it insists on a ramdisk.image.gz file.  I tried removing the
  RAMDISK entry from .config, but them got compile errors.
  I see instructions on how to build a ramdisk, but - how do
  I put the right ppc files in the ram disk if I don't have a ppc
  system to get them from?

  2)  I resorted to compiling the linux-2.4.0-test2 kernel, and
  it compiled with the additional network card I needed (tulip).
  However, when I boot, I get

  DINK32_MAX >>go 900000
  loaded at:     00900000 00914E20
  relocated to:  00800000 00814E20
  zimage at:     0090B000 00988955
  avail ram:     00400000 00800000

  Linux/PPC load: root=nfs
  Uncompressing Linux...done.
  Now booting the kernel

  and that's it.  What should I see next?  Should it init the network
  card?  Will I see that?  I have dhcp, tftp, nfs set up but I don't see
  any network activity on the host from the sandpoint using tcpdump.

  thanks for any pointers!

  Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
