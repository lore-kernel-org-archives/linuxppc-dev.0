Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F8D6DE870
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 06:02:25 +1000 (EST)
Message-ID: <4803B846.4010009@freescale.com>
Date: Mon, 14 Apr 2008 15:02:14 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Make rheap safe for spinlocks
References: <12081878182664-git-send-email-timur@freescale.com>
	<30C5925E-31F7-4E52-95C9-43DB0DE68A9F@kernel.crashing.org>
In-Reply-To: <30C5925E-31F7-4E52-95C9-43DB0DE68A9F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Is this need to fix a bug with an existing driver of for a new driver?

Both.  The ucc_geth driver calls qe_muram_alloc() with spinlocks held.  The 8610
DIU driver does something similar, but it's targeted for 2.6.26.

I'm hesitant to recommend inclusion in 2.6.25 because I haven't tested the fix
throughly enough to know that it doesn't break something else.  Technically, it
could result in qe_muram_alloc() failing.

-- 
Timur Tabi
Linux kernel developer at Freescale
