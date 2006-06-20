Return-Path: <kimmo.surakka@oxinst.fi>
Received: from imap.oxinst.fi (unknown [62.236.216.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E16967B2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 22:23:07 +1000 (EST)
From: Kimmo Surakka <kimmo.surakka@oxinst.fi>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 NFS mount issue
Date: Tue, 20 Jun 2006 15:03:27 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606201503.27928.kimmo.surakka@oxinst.fi>
Cc: Bjorn.Ostby@combitech.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bjorn.Ostby@combitech.se wrote:

> Hi all,
> I'm using u-boot 1.1.4 (CVS downloaded 2006-05-04) and ELDK 4.0. I've 
encountered 
> problems when trying to mount a NFS root filesystem when using the Lite 
MPC5200
> development board. The system mounts ok when the board is connected to 
office wide 
> network switches but if the board is connected directly through a small 
100/10Mbit switch
> to the NFS server, the mount halts as shown in the log below (The 100/10Mbit 
switch
> do work as other boards can mount their filesystem through these). Does 
anyone
> recognize this problem and know a suitable work-around/solution?

Try adding the ",tcp" to the kernel's "nfsroot=..." parameter, i.e. use 
commandline "root=/dev/nfs rw nfsroot=10.3.67.98:/opt/eldk_4_0/ppc_6xx,tcp 
ip=10.3.67.99:10.3.67.98:10.3.67.1:::eth0:off panic=1".

I recall having similar problems when connecting through an 100/10Mbit switch 
and in our case, the ",tcp" switch did the trick.

Cheers,

Kimmo Surakka

This message has been scanned by F-Secure Anti-Virus

###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ###

Unless stated above to be non-confidential, this E-mail and any
attachments are private and confidential and are for the addressee
only and may not be used, copied or disclosed save to the addressee.
If you have received this E-mail in error please notify us upon receipt
and delete it from your records. Internet communications are not secure
and Oxford Instruments is not responsible for their abuse by third
parties nor for any alteration or corruption in transmission.
