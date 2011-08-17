Return-Path: <bjoern.slotkowski@imc-berlin.de>
Received: from mx1.imc-berlin.de (mx1.imc-berlin.de [82.144.33.98])
	by ozlabs.org (Postfix) with ESMTP id 5E084B6F62
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 21:41:15 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mx1.imc-berlin.de (Postfix) with ESMTP id 36ADB3B76C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 13:32:03 +0200 (CEST)
Received: from mx1.imc-berlin.de ([127.0.0.1])
	by localhost (mx1.imc-berlin.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dE775fq26kA for <linuxppc-dev@ozlabs.org>;
	Wed, 17 Aug 2011 13:31:51 +0200 (CEST)
Received: from mailserver.berlin.imc-berlin.de
	(mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mx1.imc-berlin.de (Postfix) with ESMTP id 0F3F7FC77
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 13:31:51 +0200 (CEST)
Received: from bjoerns (bjoerns.berlin.imc-berlin.de [10.0.1.12])
	by mailserver.berlin.imc-berlin.de (Postfix) with SMTP id 0D76DA14D
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 13:31:51 +0200 (CEST)
From: "Bjoern Slotkowski" <bjoern.slotkowski@imc-berlin.de>
To: <linuxppc-dev@ozlabs.org>
Subject: Networkinterface on MPC5200b
Date: Wed, 17 Aug 2011 13:31:49 +0200
Message-ID: <FPEIIEKCABPOOBGGCOCHEEKMFEAA.bjoern.slotkowski@imc-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

We have two problems when using the fec of the MPC5200b.
The occurence of both problems is very seldom.

1.
Sometimes the first two octets of the MAC-Adress are wrong.
Removing/inserting the driver does not help.

2.
Sometimes the communication stops.
When Removing the driver following message occurs:

net eth0: queues didn't drain
net eth0: tx: index: 9, outdex: 23
net eth0: rx: index: 81, outdex: 82

Is there any known issue about this ?


For the second point I was able to create a situation to reproduce the
behavior:
For this only a wrong checksum has to be appended to the ethernet-frame
transmitted to the fec.
When sending normal frames afterward nothing happens, the comunication is
dead.
It seems as if the part of the bestcom dma which handles the fec stops.

So we modified the driver code:
Normallly when a checksum error occurs, an error interrupt is generated for
the fec-driver and nothing will be done
beside error counting.
We modified the interrupt routine: The bestcom dma for the fec is setup
again.
This modification helps sometimes but not always.
Sometimes receiving frames does not work.
Sometimes sending frames does not work after the handling of the error.

So we tried to modify the microcode of the dma to find out what wents wrong.
But here we run into trouble:
Every modifiaction especially inserting a NOP at the end leads to a non
working dma
(We also modified the size in the setup-header).

Does anyone has experience with the microcode of the bestcom dma ?
We found some documentation of the dma and how it could be possible to do
something like a debugging
and we were roughly able to read what is happening in the mirocode.
But probably we do not understand all.

Thanks a million,

Björn Slotkowski


--
imc Messsysteme GmbH
Bereich Entwicklung / Dept. Development
Voltastraße 5
D-13355 Berlin
Germany
Tel:   +49 30 46 70 90 23
Fax:   +49 30 46 31 57 6
mailto:Bjoern.Slotkowski@imc-berlin.de
Homepage: http://www.imc-berlin.de

Sitz der Gesellschaft : Berlin
Handelsregister       : Berlin-Charlottenburg HRB 28778
Geschäftsführer       : Dr.-Ing. Dietmar Sprenger
