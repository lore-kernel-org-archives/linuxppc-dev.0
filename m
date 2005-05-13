Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from pike.sandelman.ca (pike.sandelman.ca [205.150.200.164])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "pike.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3C40567B22
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 10:06:57 +1000 (EST)
Received: from sandelman.ottawa.on.ca (wlan232.sandelman.ca [205.150.200.232])
	by pike.sandelman.ca (Postfix) with ESMTP id 196566371A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 19:37:08 -0400 (EDT)
Received: from marajade.sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 30DF0BCAC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 19:37:02 -0400 (EDT)
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Fri, 13 May 2005 19:37:02 -0400
Message-ID: <3086.1116027422@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Subject: problems with ppc405 on 2.6.11.8.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


A customer of mine has a PPC405 system, which was based upon the
Embedded Planet design. It runs U-boot 0.4.0, and the system currently
ships with a kernel based upon Timesys 2.4.18. 

We are in the process of upgrading to 2.6.11. (linus, not timesys. We
see no value add from timesys)

The major stumbling block was using boot/simple/{head,relocate}.S,
and the inftrees.c. For reasons we do not understand, the system would
fail in huft_build() when (setting up for) decompressing.  We traced
through this using our bdi2000, after failing with puts() additions. 

My gut instinct was originally that we were blowing our stack, or
overwriting running code while decompressing. 

Kyle McMartin tried (I'm not sure why yet) replacing the head.S with
the one from 2.4.18-timesys. It seemed to solve the problem.

I'm posting this in two hopes:
    a) that someone else not hit the same problem.
    b) that someone else might have a suggestion on 
       what might be different between head.S+relocate.S and head.S(2.4.18).

- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQoU6E4qHRg3pndX9AQEtswP5AXD3+gxobRZWfZUGU7MqzoJSJFCLcrYc
0yqfGHBL79g3zbkJUONnE30qBBdEyYkH5ghmg6Xqxt4YjgPId3ZOWHBtrRrp+PCA
lBm8WzsgBBBT5SCKNDe6kOy2rSKUjunxv4GXJ0lSQpZMvuceAOmD73no4tWIM/I8
2iETSMLkr9Q=
=2Tlk
-----END PGP SIGNATURE-----
