Message-ID: <3A1C3A39.BB7C45EF@mvista.com>
Date: Wed, 22 Nov 2000 13:27:21 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: "Ruhland, Paul" <pruhland@microwavedata.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded] PCMCIA on MBX860
References: <DF2142DFD5ECD311BA1900104B943A97932356@roche-exg1.rochester.adaptivebroadband.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


strange, I haven't seen that before. check the BCSRs.  Perhaps a
difference between the MBX and EP boards was missed, and it is turning
off the ethernet transmit? That is my guess.

"Ruhland, Paul" wrote:
>
> > you need to change a config file.
> >
> > in /etc/sysconfig/pcmcia
> >
> > change the i82365 to m8xx_pcmica
> >
> Ahhh...that was it.  Now, when the pcmcia stuff is starting up I lose my
> eth0 nfs connection...
>
> ---------------------------------------
> sh-2.03# /t etc/init.d/pcmcia start
> Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.19
>   kernel build: 2.2.14 #10 Tue Nov 21 11:37:36 GMT-5 2000
>   options:  none
> m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
> m8xx_pcmcia: MBX860 using SLOT_A with IRQ 13.
> nfs: server 10.2.129.62 not responding, still trying
> eth0: transmit timed out.
>  Ring data dump: cur_tx fa202958 (full) cur_rx fa202930.
> 9c00 0096 00153c82
> 9c00 0096 001535c2
> 9c00 0096 001536e2
> 9c00 0096 001534a2
> 9c00 0096 00153802
> 9c00 0096 00153922
> 9c00 0096 00153a42
> bc00 0096 00153b62
> 9c00 05ee 001ee000
> 9c00 0362 001ee800
> 9c00 05ee 001ed000
> 9c00 05ee 001ed800
> 9c00 00ae 001ec000
> 9c00 00ae 001ec800
> 9c00 0502 001eb000
> bc00 05ee 001eb800
> eth0: tx queue full!.
> ----------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
