Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDC99B7BEA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 00:46:35 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n92EkWOB016463
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Oct 2009 07:46:32 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n92EkWnk000056
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Oct 2009 09:46:32 -0500 (CDT)
Message-ID: <4AC61247.1030507@freescale.com>
Date: Fri, 02 Oct 2009 09:46:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: Is volatile always verboten for FSL QE structures?
References: <4AC60AD8.8030509@ruggedcom.com>
In-Reply-To: <4AC60AD8.8030509@ruggedcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Barkowski wrote:
> Just wondering - is there a case where using volatile for UCC parameter RAM for example will not work, or is the use of I/O accessors everywhere an attempt to be portable to other architectures?

'volatile' just doesn't really do what you think it should do.  The PowerPC architecture is too complicated w.r.t. ordering of reads and writes.  In other words, you can't trust it.

No one should be using 'volatile' to access I/O registers.

-- 
Timur Tabi
Linux kernel developer at Freescale
