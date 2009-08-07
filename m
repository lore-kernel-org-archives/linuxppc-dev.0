Return-Path: <David.Vrabel@csr.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 35924B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 03:48:39 +1000 (EST)
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
	[85.115.60.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C37FDDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 03:47:01 +1000 (EST)
Received: from rly44d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly44d.srv.mailcontrol.com (MailControl) with ESMTP id
	n77HBwrc007291
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 18:12:00 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly44d.srv.mailcontrol.com (MailControl) id n77HAcaM024550
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 18:10:38 +0100
Message-ID: <4A7C5FAB.2020304@csr.com>
Date: Fri, 07 Aug 2009 18:08:59 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] sdhci-of: Fix high-speed cards recognition
References: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
	<20090807165015.GB524@oksana.dev.rtsoft.ru>
In-Reply-To: <20090807165015.GB524@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: Ben Dooks <ben@fluff.org>, sdhci-devel@lists.ossman.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> eSDHC fails to recognize some SDHS cards, throwing timeout errors:
> 
>   mmc0: error -110 whilst initialising SD card
> 
> That's because we calculate timeout value in a wrong way: on eSDHC
> hosts the timeout clock is derivied from the SD clock, which is set
> dynamically.

I've seen an reference design for an SDHC controller do this also.

> +/* Controller has dynamic timeout clock management */
> +#define SDHCI_QUIRK_DYNAMIC_TIMEOUT_CLOCK		(1<<24)

This comment and define would be better if it matched terms used in the
spec.  Suggest:

/* Controller uses SDCLK instead of TMCLK for data timeouts. */
#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK  (1 << 24)

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


'member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom'
