Return-Path: <enno.luebbers@upb.de>
Received: from mail.uni-paderborn.de (mail.uni-paderborn.de [131.234.142.9])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C833EDDE10
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jan 2008 19:37:24 +1100 (EST)
Received: from p4fc4cc0b.dip.t-dialin.net ([79.196.204.11] helo=[10.10.3.100])
	by mail.uni-paderborn.de with esmtpsa
	(TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63 chapek-ix.uni-paderborn.de) id 1JEKop-0006Ji-3G
	for linuxppc-embedded@ozlabs.org; Mon, 14 Jan 2008 09:37:19 +0100
Message-Id: <62D97388-4D65-4B40-A0D1-847963FF0A16@upb.de>
From: =?ISO-8859-1?Q?Enno_L=FCbbers?= <enno.luebbers@upb.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Problem booting Linux 2.6 on Virtex-4
Date: Mon, 14 Jan 2008 09:37:16 +0100
References: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello David,

Am 14.01.2008 um 06:12 schrieb David Baird:

> I'm having trouble with getting Linux to boot farther than early_init.
> [...]
> So, I experimented further and discovered that different memory
> regions seem to be aliased on to each other every 2*32*256 bytes.


This sounds either like a wrong programming of an BRx/ORx memory  
controller register pair (which, AFAIK, the PPC405 does not have), or  
like a messed up address map in EDK. My guess is that an optimized/ 
sloppy implementation of the address decoder for some peripheral in an  
EDK system could produce something like you described; or there's a  
block RAM that's attached to a controller in the wrong way; or the  
bank/address parameters of the DDR controller don't match the physical  
setup... there's a lot that can go wrong obviously on a configurable  
SoC.

Can you be more specific about your hardware platform? Is this a  
reference design? What board are you using?

Regards
- Enno

-- 
Dipl.-Ing. Enno Luebbers
Computer Engineering Group
University of Paderborn	

Warburger Str. 100		
33098 Paderborn			

http://wwwcs.upb.de/cs/ag-platzner
phone:  05251 / 60-5397
fax:    05251 / 60-5377
