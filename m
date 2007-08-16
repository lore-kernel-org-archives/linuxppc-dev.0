Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69584DDEFC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 01:27:42 +1000 (EST)
Message-ID: <46C46CE3.5030807@freescale.com>
Date: Thu, 16 Aug 2007 10:27:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
References: <11872134502476-git-send-email-timur@freescale.com>
	<1187236548.8375.13.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1187236548.8375.13.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:

> And if you're going to the trouble of making a macro, why not make it a
> bit more useful and have it check that the value and the mask match, ie:
> 
> (v & ~m == 0)

What should I do if it fails this check?

> Final random thought, you could make the size/endian an argument:
> 
> #define setmaskedbits(a, v, m, s)  out_##s((a), (in_##s(a) & ~(m) | (v))

Hmmm.... the only thing wrong with that is that it would allow be64 on a 
32-bit platform (i.e. no __power64__ protection).  But that's minor.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
