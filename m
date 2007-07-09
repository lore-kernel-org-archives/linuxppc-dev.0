Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC70EDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:16:47 +1000 (EST)
Message-ID: <4692A5B8.9010702@freescale.com>
Date: Mon, 09 Jul 2007 16:16:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages, with
	a warning.
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de>
In-Reply-To: <200707092225.25287.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 09 July 2007, Scott Wood wrote:
> 
>>In older versions of glibc (through 2.3), the dynamic linker executes a
>>small amount of code from the data segment, which is not marked as
>>executable.  A recent change (commit 9ba4ace39fdfe22268daca9f28c5df384ae462cf)
>>stops this from working; there should be a deprecation period before
>>older glibc versions stop working.
>>
>>The problem has been observed on glibc 2.2.  While glibc 2.3 has the same
>>code, I did not see the problem; it may be that it accesses the page in
>>question as data before executing from it, and thus it is already mapped.
> 
> 
> I may be missing the obvious, but doesn't that defeat the purpose of
> non-executable mappings?

The hardware in question doesn't support non-executable mappings; 
otherwise, it'd never have worked in the first place.  Note that this is 
only allowed on 32-bit, non-book-E.

There isn't much value in enforcing non-exec mappings only if it happens 
to be the first fault on a given page.

-Scott
