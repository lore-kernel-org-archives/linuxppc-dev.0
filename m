Message-Id: <v04003a04b7950820448a@[24.70.162.12]>
In-Reply-To: <20010807024110.58504.qmail@web10407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 6 Aug 2001 21:59:47 -0500
To: kvsukesh@yahoo.com, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: IDE Driver on PPC Kernel 2.4.x  fails in DMA mode.
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:41 PM -0500 8/6/2001, kvsukesh@yahoo.com wrote:
>Hi,
>I am having some trouble getting the drivers
>for the IDE/ATA 100 ( iam using cmd 649 & and an IBM
>Deskstar )work in the DMA mode running kernel 2.4.2
>on a PPC405GP.
>If anybody has seen this problem, or has a fix for it
>please respond.
>I tried to enable the DMA using hdparam -d1 /dev/hda
>but it fails.
>
>thanks
>SUKESH
>
>
>
>Below is the boot up message log..
>-----------------------------------
> CMD649: IDE controller on PCI bus 00 dev 18
[...]

Be careful, hdparm can crash the kernel if used on a machine without a
proper ISA bus and an ISA IDE interface.

There's some common IDE code in the kernel that blindly assumes that some
structs contain valid ISA-ish IO addresses which will crash on pretty much
anything except x86, and is generally only triggered by hdparm calls.

I ran into it when playing with a Promise card in my PMac 9600/200mp.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
