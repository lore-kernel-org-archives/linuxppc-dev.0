Return-Path: <listuser@epygi.de>
Received: from sally.epygi.de (gate.epygi.de [212.126.211.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B8B6681C1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 19:47:50 +1000 (EST)
Received: from localhost ([127.0.0.1]) by sally.epygi.de with esmtp (Exim 4.44)
	id 1ECw6Z-0001k8-Vb
	for linuxppc-embedded@ozlabs.org; Wed, 07 Sep 2005 11:20:32 +0200
Received: from sally.epygi.de ([127.0.0.1])
	by localhost (sally.epygi.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06290-08 for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 11:20:29 +0200 (CEST)
Received: from pc-markus.epygi.de ([10.20.0.33] helo=PCMARKUS)
	by sally.epygi.de with smtp (Exim 4.44) id 1ECw6X-0001k3-8q
	for linuxppc-embedded@ozlabs.org; Wed, 07 Sep 2005 11:20:29 +0200
From: "Markus" <listuser@epygi.de>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 7 Sep 2005 11:20:25 +0200
Message-ID: <BDEHJGPIKNLKJJBCCFPLCEOOCPAA.listuser@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ads8272 SEC problem on 2.4.18
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

HiHo!

I am trying to get the SEC engine running on a ads8272
but i am completely stuck now. (It feels like the problem
we saw on this list last month, but there is still no solution
to that issue yet.

Quick Problem description:
  initialize seems, ok, yet when i feed a single
  dpd (for DES EU) into channel 0, the engine
  seems to stuck during fetch. Nothing happens.

Questions:
- Can someone help me out? (Not sure if this is the right list for this?) 
- Do (open) sources for the SEC1 (motorola/freescale) engine exist for vanilla linux?
  (I know of Arabella, but they are neither open nor for vanilla linux) 

ciao
  Markus

P.S. some more details below
--------------------------------------------
more info:
 - i hopefully initialized it correctly
 - prepared a dpd
 - wrote it into fetch register
 - see that something happens: CurrentDescriptorPR changes
 - boing, that's it... no more

some dumps:
 Before writing the fetch register:
  CryptoChannelConfigRegister (f0042008), 0x00000000 0x0000071c
  CryptoChannelPointerStatusRegister (f0042010), 0x00000000 0x00000007
  CryptoChannelCurrentDescriptorPointerRegister (f0042040), 0x00000000 0x00000000
  CryptoChannelFetchDescriptorRegister (f0042048), 0x00000000 0x00000000
  CryptoChannelDescriptorBufferRegister 0 (f0042080), 0x00000000 
 
 after writing to fetch register
  CryptoChannelConfigRegister (f0042008), 0x00000000 0x0000071c
  CryptoChannelPointerStatusRegister (f0042010), 0x00000002 0x00000007
  CryptoChannelCurrentDescriptorPointerRegister (f0042040), 0x00000000 0x002e9a98
  CryptoChannelFetchDescriptorRegister (f0042048), 0x00000000 0x00000000
  CryptoChannelDescriptorBufferRegister 0 (f0042080), 0x00000000 

CCPSR changes to 2 (error), but i don't know why?
Nothing else (at least nothing i can see) happens.
------------------------------------------------------
markus schaefer  ---  software engineer
epygi labs de gmbh
herrenstrasse 23  
d-76133 karlsruhe, germany
tel: +49 (721) 205 96 30  -- fax: +49 (721) 205 96 59
sip: 20444@sip.epygi.com
*email removed, but it is easy to guess*
http://www.epygi.de  
