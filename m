Message-ID: <C060DFCD9697A842B3189B458524FDC206BFB4@AIMAIL1.ai.aiinet.com>
From: "Dayton, Dean" <deand@aiinet.com>
To: "'Adisorn Ermongkonchai'" <aermongk@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Poor 8260 FCC Ethernet performance 
Date: Mon, 7 Jun 2004 08:14:07 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's been awhile, but I seem to remember that some of the PPC drivers did
not set up full duplex properly. Make sure that fcc_fpsmr is setting
FCC_PSMR_FDE and FCC_PSMR_LPB properly. Also check to make sure that the phy
is actually set up for full duplex.


Having said all that. There is a limit to how fast the processor can forward
packets. This chip was designed to give a lot of flexibility in
connectivity. It will not forward 100Mbps of small packets, especially not
while running Linux. You could spend a lot of time and really optimize the
data path and drivers for a very significant improvement in performance. But
then you wouldn't have the flexibility of Linux.

I run a 266MHz 8265 with Linux. With a very simple kernel configuration it
can forward about 29000 pps (in on interface and out another). If I enable
iptables,nat and a few other network options, the performance drops by about
50%. If I start configuring complex iptables rule, performance will continue
to drop.

Modifying the driver to NAPI would probably help.

Dean Dayton

> -----Original Message-----
> From: Adisorn Ermongkonchai [mailto:aermongk@yahoo.com]
> Sent: Sunday, June 06, 2004 2:01 PM
> To: acurtis@onz.com
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Poor 8260 FCC Ethernet performance
>
>
>
> Hi Allen and Linuxppc-embedded guru,
>
> Referring to your 31 May 2002 post to LinuxPPC about
> poor 8260 FCC Ether performance.  Did you figure
> out why is the FCC so slow?  We have encountered this
> problem as well. We use the newer MPC8270 with 400MHz
> clock and 200MHz CPM speed with BCM5222 PHY.  It
> ended up running at only ~5Mbps on 100Mbps Ethernet
> line.  We just tried 1 FCC.
>
> Does anyone on this post see the same problem? We use
> linux 2.4.18 with PPC pqii driver (somehow the other
> driver didn't seem to work for all 3 FCC's)  We
> also tried on Motorola 8260 eval board and the result
> is the same.  We also tried MEN Micro F6, it gave
> better result from 11MBps to 30Mbps.  We also tried
> just uboot to eliminate Linux out of the picture and
> the result was about the same.
>
> I was about to give up on this MPC8270 then I saw this
> post so I thought I try.  I cannot believe that
> Motorola would make a chip that support 3 FCC's
> but can only run at this ridiculous speed.  I am
> software engineer, this could be hardware.
>
> Can anyone help me on this?  I'm about to have to
> change the processor to PowerPC 4xx.
>
> Thanks in advance.
>
> Regards,
> Adisorn Ermongkonchai
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
