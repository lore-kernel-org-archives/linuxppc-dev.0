Message-ID: <37848F6D.5E2437EE@mpifr-bonn.mpg.de>
Date: Thu, 08 Jul 1999 13:45:49 +0200
From: Albrecht Dreﬂ <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Linux/Powermac <linux-pmac@samba.anu.edu.au>
Subject: Re: linux-pmac 2.2.10: media bay panics on PBG3
References: <19990707145627.029796@mail.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Wed, Jul 7, 1999, Albrecht Dreﬂ <ad@MPIfR-Bonn.MPG.de> wrote:
> 
> >Hi!
> >
> >       At last, I managed to upgrade my PB G3 to linux-pmac 2.2.10.  Sound works
> >definitely better, and my 3-button Contour mouse is recognised.  However,
> >removing the floppy drive from the right media bay and inserting the cd-rom
> >results in a kernel panic:
> >
> >[media bay contains the floppy drive, which is now replaced by the cd drive]
> >media bay 0 is empty
> >media bay 0 contains a CD-ROM drive
> >NIP: C00E7D9C XER: 20000000 LR: C00E7C9C REGS: c01dde70 TRAP: 0300
> >MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> >TASK = c01dc000[2] 'media-bay' mm->pgd c0123000 Last syscall: -1
> >last math cb062000
> >GPR00: 000003E7 C01DDF20 C01DC000 00000000 00000003 6000381C 0000003C
> C0125F58
> >GPR08: C0193540 F5021000 00000000 00000000 44800424 018498B4 FFFFFFFF
> 0B96FB70
> >GPR16: 4A000484 FFD603B0 C0193548 C019356C C019354C C019355C C0193540
> C0140000
> >GPR24: 00000000 C0193544 C0193560 C0193540 00000001 00000000 00000000
> C0193540
> >Call backtrace:
> >C00E7C9C C00090CC
> >Kernel panic: kernel access of bad area pc c00e7d9c lr c00e7c9c address
> >F5021070
> >tsk media-bay/2
> >syslogd 1.3-3: restart.
> >
> >Any idea how I could fix this?  Because of the mouse support, I would prefer
> >to
> >stay wit 2.2.10.
> 
> Could you check in the System.map file the location of the crash ?

I added lots of printk's to mediabay.c, and apparently the panic occurs at (or
near) line 276 in media_bay_task:

if (bay->cd_timer && (--bay->cd_timer == 0 || MB_IDE_READY(i))
    && bay->cd_index < 0) {

Any idea?

In the meantime, I was able to get a 2.2.10 vmlinux configuration which does
_not_ panic upon changes of the media bay device.  I'll try to track down which
option makes the problem.

Yours, Albrecht.
 
-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
