Return-Path: <pierre.kestener@cea.fr>
Received: from cirse.extra.cea.fr (cirse.extra.cea.fr [132.166.172.102])
	by ozlabs.org (Postfix) with ESMTP id E07C267A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 20:07:13 +1000 (EST)
Received: from argiope.saclay.cea.fr (argiope.saclay.cea.fr [132.166.192.108])
	by cirse.extra.cea.fr (8.12.10/8.12.10/CEAnet-Internet.4.0) with
	ESMTP id j3K9iqAN027513 for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 11:44:52 +0200 (MEST)
Received: from pisaure.intra.cea.fr (unverified) by argiope.saclay.cea.fr
	(Content Technologies SMTPRS 4.3.17) with ESMTP id
	<T706bd5854684a6c06c4d0@argiope.saclay.cea.fr> for
	<linuxppc-embedded@ozlabs.org>; Wed, 20 Apr 2005 11:44:52 +0200
Received: from muguet.saclay.cea.fr (muguet.saclay.cea.fr [132.166.192.6])
	by pisaure.intra.cea.fr (8.12.11/8.12.11) with ESMTP id j3K9hj89002052
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Apr 2005 11:43:46 +0200
	(envelope-from pierre.kestener@cea.fr)
Message-ID: <42662502.5060108@cea.fr>
Date: Wed, 20 Apr 2005 11:46:42 +0200
From: Pierre Kestener <pierre.kestener@cea.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org,
	Pierre Kestener <pierre.kestener@cea.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Virtex2pro OPB frequency 10/100Mbs ethernet link related problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have noticed a strange behavior regarding NFS on my target (Virtex2pro 
ff1152 from Memec) when increasing OPB/PLB bus frequency from 50 MHz to 
66.666667MHz to be able to use a 100 Mbs ethernet link (it is mentionned 
in the OPB/EMAC IP doc
that Bus clock should be more than 65 MHz to have 100Mbs).

I use U-boot (ML300 port with small modifications) for the bootloader 
step (download linux kernel via tftp) and kernel 2.4.20. The root 
filesytem is mounted via NFS.

At 50MHz, everything works fine. Ethernet link speed is 10 Mbs. I can 
check that on my Ethernet switch.

When using 66.666667MHz OPB frequency, ethernet Link speed is indeed 
100Mbs. U-boot works perfectly but linux boot fails trying to get nfs 
server port !!!

Using "tcpdump" on my linux host, i can see that target sends ARP 
packets and the server replies but nothing happends...
 
    09:04:28.848228 arp who-has myHost.extra.cea.fr tell 132.166.xxx.yyy
    09:04:28.848265 arp reply myHost.extra.cea.fr is-at 00:06:5b:xx:yy:zz

Has anyone seen such a behavior, using a 100Mbs ethernet link with a 
Virtex2pro target ?
Any idea regarding this problem (hardware or software) ?

Thanks a lost.
Best Regards.

Pierre Kestener.
