Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9BADFDDE44
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 07:27:45 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l63LRdBp015100
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 14:27:39 -0700 (MST)
Received: from [10.82.19.112] (ld0162-tx32.am.freescale.net [10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l63LRcGp008867
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 16:27:38 -0500 (CDT)
Message-ID: <468ABF4A.60001@freescale.com>
Date: Tue, 03 Jul 2007 16:27:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there any particular reason that of_device_is_compatible uses 
strncasecmp()?  Besides the OF spec saying that names (and thus 
compatibles) are case sensitive, the "n" part screws up matching when a 
subset of a string is not a more generic version thereof.  For example, 
ucc_geth v. ucc_geth_phy, or fsl,cpm v. fsl,cpm-enet.

Does anything actually rely on this behavior?

-Scott
