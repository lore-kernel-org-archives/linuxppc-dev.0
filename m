Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EDA1076.8010701@mvista.com>
Date: Sun, 01 Jun 2003 09:40:54 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: =?ISO-8859-1?Q?=B6=A1=BA=F1=D3=C0?= <nari_dhy@nari-china.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: file system over CF flash
References: <012e01c327e7$fc8921c0$4c44900a@hydingnb> <20030601112826.76f9978a.damm@opensource.se>
In-Reply-To: <20030601112826.76f9978a.damm@opensource.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:
> There is no need for any special Flash file system, the Compact Flash itself keeps
> track of things like wear levelling, sector size and command set of the flash devices.

Just want to point out a common misconception on CF here.  While the unit will
do wear leveling, you MUST power cycle it for that to happen.  Each power cycle
pretty much locks down the sectors it is using.  Bizarre I agree, but you will
burn out a CF disk very quickly if you do not constantly power cycle it.  (We
had a customer experience that exact problem with the CF vendor's response being
"ohh you didn't know that?".)

CF disks are great for read-only, occasional writes, and "consumer devices"..
but are terrible for anything that you would expect long uptimes and moderate
writing.  (In this situation, the little IBM CF hard drive seems to work pretty
good, but I don't have any long term experience with failure/success on one of
those.)

> The exported interface for a Compact Flash is just like any ATA Flash and under
> Linux the standard IDE driver is normally used. The CF needs to be mapped into
> some address space however, and this setup is usually taken care of by the PCMCIA
> layer or the firmware/bootloader of your specific board.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
