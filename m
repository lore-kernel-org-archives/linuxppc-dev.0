Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail5.oerlikon.com (mail5.oerlikon.com [193.158.88.212])
	by ozlabs.org (Postfix) with ESMTP id 39A14DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 02:35:33 +1100 (EST)
Received: from anetcsgv210.dom03.net (localhost.localdomain [127.0.0.1])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 6E67D2E97BC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 16:35:27 +0100 (CET)
Received: from anetcsgv202.dom03.net (anetcsgv202.dom03.net [193.158.88.254])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 446832E97B2
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 16:35:27 +0100 (CET)
Received: from SRVWWP01.sts.saurer.vpn (unknown [10.33.20.167])
	by anetcsgv202.dom03.net (postfix-1) with ESMTP id 24DE514EFB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 16:35:27 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: [PATCH]: [MPC5200] Add ATA DMA support
Date: Tue, 25 Nov 2008 16:35:26 +0100
Message-ID: <633A55242A59C7488FAAF5A6850929984B814C@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <b5e2fc790811250719h21b2b0e5uc0a249a73458148f@mail.gmail.com>
References: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
	<b5e2fc790811250719h21b2b0e5uc0a249a73458148f@mail.gmail.com>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: "Matt Sealey" <matt@genesi-usa.com>, "Tim Yamin" <plasm@roo.me.uk>,
	"Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tim, Grant=20
=20
here are some more information.=20
I think there is a also a problem with memory after FEC crasched.
=20
root@EL392:~ free
              total         used         free       shared      buffers
   Mem:       127100        26424       100676            0          432
  Swap:            0            0            0
Total:       127100        26424       100676
root@EL392:~
root@EL392:~
root@EL392:~ ifdown eth0
net eth0: queues didn't drain
net eth0:   tx: index: 10, outdex: 6
net eth0:   rx: index: 117, outdex: 118
root@EL392:~ ifup eth0
net eth0: attached phy 0 to driver Generic PHY
root@EL392:~ freePHY: f0003000:00 - Link is Up - 100/Full
root@EL392:~ free
              total         used         free       shared      buffers
  Mem:       127100        35028        92072            0          760
 Swap:            0            0            0
Total:       127100        35028        92072
=20
Cheers


Mit freundlichen Gr=FC=DFen

Hans Lehmann

Softwareentwicklung

Telefon +49 (0)2191-67-2520

Fax     +49 (0)2191-67-703408

e-mail  hans.lehmann@ritter-elektronik.de =
<mailto:hans.lehmann@ritter-elektronik.de>=20

Ritter Elektronik GmbH

Leverkuser Stra=DFe 65

D-42897 Remscheid

www.ritter-elektronik.de <http://www.ritter-elektronik.de/start.html>=20

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader

Sitz der Gesellschaft: Oberhausen

HRB 17168 Duisburg  /  USt-ID DE 814009849

=20

________________________________

Von: Matt Sealey [mailto:matt@genesi-usa.com]=20
Gesendet: Dienstag, 25. November 2008 16:19
An: Lehmann, Hans (Ritter Elektronik)
Cc: Tim Yamin; Grant Likely; linuxppc-dev@ozlabs.org
Betreff: Re: [PATCH]: [MPC5200] Add ATA DMA support




On Tue, Nov 25, 2008 at 8:45 AM, Lehmann, Hans (Ritter Elektronik) =
<hans.lehmann@ritter-elektronik.de> wrote:


	Tim, Grant,
=09
	just an info.
=09
	Very often the Bestcomm-FEC crashed without any error logs if I =
initiate a transaction over FEC and save the file to disk (I rememeber I =
have read something like that). A restart of FEC don't work.
	But no I figured out, if I connect to the other ethernet port of our =
board (natsemi) the FEC will awake to life again, if I initiate a new =
transaction over natsemi. This seems a little oddly to me.
=09


Hi guys,

We tried to get the SUSE guys to push the patch into openSUSE 11.1 =
release and the tests came back negative here too with regards to FEC =
support; for some odd reason, it does this;

https://bugzilla.novell.com/show_bug.cgi?id=3D445856#c10=20


There is some weird interaction here, but I can't imagine what it might =
be. Tim, did you ever see any ethernet problems like this?

--=20
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
