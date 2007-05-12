Return-Path: <tnt@246tNt.com>
Received: from mailgate103.isp.belgacom.be (mailgate103.isp.belgacom.be
	[195.238.6.84]) by ozlabs.org (Postfix) with ESMTP id 6ADC9DDEBF
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 06:32:23 +1000 (EST)
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/9] BestComm : better late than never heh ;)
Date: Sat, 12 May 2007 22:31:48 +0200
Message-Id: <11790019171838-git-send-email-tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone,

Here we go : This series adds support for the BestComm engine
found on the 5200 CPUs. This is _long_ overdue, I admit it ...
but better late than never ;)

For the little story, Freescale does provide an API that is
just ugly. A long time ago, Dale Farnsworth proposed a new API.
It was a lot better but some things were still not right, some
time after that Andrey Volkov & myself did some rework but still
not enough and with the switch to arch/powerpc there was new stuff
to be done ... Finally, I decided to give it a last go and here
we are ...

A few words about theses patches : The first 3 are just preliminary
stuff, then comes the core, followed by 3 tasks and finally two
drivers. The drivers are not ready for upstream, they are just
here so that people can test that it _does_ work.

About the API itself :

 The API divides the work in three layers, trying to keep them as
 separate as possible :

  1) Core : This is the grunt work, setting up tasks and global 
            config. It also provides useful helpers for the other
            layers and debug help.
            
     This is mainly bestcomm.c bestcomm.h bestcomm_priv.h sram.{c,h}

  2) Task support : Each task may have a different way to configure
     it's buffer ring or other details. We hide the details of it
     in theses. The code in this "layer" has knowelge of bestcomm
     internals and can include "bestcomm_priv.h". The microcode
     files are mostly automatically extracted from the dma_image.hex
     image provided by freescale.

     For the ata task: ata.h ata.c bcom_ata_task.c
     For the fec task: fec.h fec.c bcom_fec_rx_task.c bcom_fec_tx_task.c
     For the genbd task: gen_bd.h gen_bd.c bcom_gen_bd_rx_task.c bcom_gen_bd_tx_task.c

  3) Driver: Inside the driver, the knowelge of bestcomm internals
     is minimal. You just need to call the task support code to get
     your 'dma object' and then if the task is buffer descriptor based,
     you cal use the helper function to submit / retrieve bd.

I personnaly like this division because that hides microcode details
from the driver and keeps it separate. It also keeps a lot of code
common, independant of the _precise_ buffer descriptor format. They
all have a status word followed by some address (the exact number depends
of the task ...)

About some details of 'form':

  - 'bcom_' sounded like a good prefix. sdma_ was used else where for
     another dma engine.
  - arch/powerpc/sysdev/bestcomm sounded like a good place to put this.

Final note :

 Is the API perfect ? probably not, but I think it's pretty good.
 And I hope you'll like it because I don't really feel like starting
 from scratch again ... ;)

 The two things that I know I need to find a solution to are :
  - Initiator priority shouldn't be fixed. The user should be able
    to provide it's own in the DT. (if none is found, just fall back
    to the default one)
  - The link from device -> initiator number is ... not easy to make.
    Currently it's fixed (only one FEC so if someone wants the fec
    task that must be the FEC driver ...)


        Sylvain
