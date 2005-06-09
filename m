Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 4805A67B25
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 20:04:17 +1000 (EST)
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Message-ID: <OFEC58341E.E377A0F3-ONC125701B.00354E89@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 9 Jun 2005 12:05:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Read in /dev/port with Segmentation  Fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear St=E9phane,

Yes i remember your mail about /dev/mem access. But, I never succeed to=

read or write physical memory with reliability so i wrote a driver and =
use
ioremap inside  intead of mmap (before i put all the needed memory on I=
O
memory with the boot command "mem=3DxM" and then it works. So, i think =
i have
some problems with "mmap"  :-).
I think my .../char/mem.c is OK for mmap support.
Why is it necessary to use size+ofs_addr for size and page_addr instead=
 of
physaddr, i thought mmap( ) do it itself ?

Thank you for your help.

Kenavo.

Sophie.




                                                                       =
                                                                       =
     =20
                    "Fillod Stephane"                                  =
                                                                       =
     =20
                    <stephane.fillod@th        Pour :  <scarayol@assyst=
embrime.com>                                                           =
     =20
                    omson.net>                 cc :    <linuxppc-embedd=
ed@ozlabs.org>                                                         =
     =20
                                               Objet :      RE: R=E9f. =
: Re: Read in /dev/port with Segmentation  Fault                       =
       =20
                    09/06/05 11:35                                     =
                                                                       =
     =20
                                                                       =
                                                                       =
     =20
                                                                       =
                                                                       =
     =20



Sophie CARAYOL wrote:
>Another question, if i use mmap to map physical addresses of I/O
registers,
>could i dereference the pointer on virtual adresse to access data or
should
>i use read/write on the file descriptor ?

Yes, you can dereference the pointer.
Don't you remember my past mail?

>From the Denx's FAQ (TFQ hits the list monthly) for accessing memory bu=
s:

http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acc=
essingPeripheralsFromUserSpace

or shorter: http://tinyurl.com/6c7th

See linux/drivers/char/mem.c to check if mmap support is ok on your arc=
h.

Kenavo
--
St=E9phane



=
