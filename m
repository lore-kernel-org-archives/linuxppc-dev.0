From: Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>
To: VALETTE Eric <valette@crf.canon.fr>
Cc: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org,
        mmporter@home.com, alois_fertl@TalkNet.de
Subject: Re: PREP Hardware goes IDE again
In-Reply-To: <m0zo2tX-0000WVC@tri-yann.crf.canon.fr>
Message-ID: <SIMEON.9812111011.A@g-mun-af.muenchen.europe.mcd.mot.com>
Date: Fri, 11 Dec 1998 10:57:11 +0100 (W. Europe Standard Time)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Thu, 10 Dec 1998 11:00:27 +0100 (CET) VALETTE Eric 
<valette@crf.canon.fr> wrote:

> 
> >>>>> "Alois" == Alois Fertl <alois_fertl@TalkNet.de> writes:
> 
> Alois> Here are some small patches (ralative to 2.1.129) which make IDE
> Alois> working on PREP Hardware especially the RiscPC (probably also needed
> Alois> for MPC750).
> 
> Unfortunately, nearly all the change you have proposed are either
> irrelevant for MCP750 or worse will cause it to not function.
OK may be it helps others which have to fiddle around with older 
systems.

> 
> Alois> The first problem I had was related to interrups on the RiscPC.
> Alois> It always assigned IRQ13 to the IDE port. However actually the
> Alois> port is connected to IRQ14. The next problem was that prep_pci.c
> Alois> assigned IRQ14 to PCI. The Patch now assigns 14 to IDE and uses
> Alois> 9,11 and 15 for PCI. In addition to this it sets the edge/level
> Alois> control according to PCI preconfiguration. In addition it adds
> Alois> 3 more entries to the Blackhawk table.
> 
> This is true only if you do not try to use the "full native PCI mode".
> In that case you should not look at IDE assigned value in the PCB
> but at the PCI interrupt line. This is what happens on MCP750 as
> the code automatically switch the driver to "full native PCI mode".
I agree. The same is true for the WINBOND chip which is handled as
sl82c105 by linux.
> 
> Alois> The second problem was that the partition table of a DOS IDE drive
> Alois> was not recognized unless I specified hda=swapdata at the boot prompt.
> Alois> IDE CD-Rom drives were not recognized at all. All the required coding
> Alois> to operate IDE devices correctly is already there but it is not used
> Alois> for PREP hardware. I changed ide.h so that PREP is handled the same
> Alois> way as CHRP. This makes IDE disks and CD-roms work without the need
> Alois> to specify boot options.
> 
> This breaks the MCP750. I tried the patch below, and was not detecting the disk
> correctly : everything was incorrectly swapped (including the name of the disk).
> My mcp750 system will run correctly *only* if this patch is not included...
> 
> Alois>  static __inline__ void ide_fix_driveid (struct hd_driveid *id) {
> Alois> -	if (( _machine == _MACH_Pmac ) || (_machine == _MACH_chrp)|| (_machine == _MACH_mbx) ) {
> Alois> +	if (( _machine == _MACH_Pmac ) || (_machine == _MACH_chrp)|| (_machine == _MACH_mbx) || (_machine == _MACH_prep) ) {
Sorry for that. But at least good to know. The seems to be something
different between the VIA chip or driver and the NS PC87303 resp. the 
SL82C105 which work fine for me.
>  
> Since you and mark are motorola felow I will ask you a favor as I did not find
> anything on the public docs. In the MCP750A/PG1 manual, page 4-5, I would like
> to know how to program PCB and more specifically the PIRQ control route. 
> I do not find anything in the doc.
This is typically done via the PCI to ISA bridge. I guess you find the 
answer in the data sheet for the VIA chip. You can find it on 
   http://www.via.com.tw/support/datasheets.htm



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
