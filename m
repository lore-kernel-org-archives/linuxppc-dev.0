Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FA0267B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 06:20:38 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AKKZxR020722
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 16:20:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AKKZEZ470114
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 14:20:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AKKZ9W019222
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 14:20:35 -0600
Date: Tue, 10 Oct 2006 15:20:34 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: BUG() in copy_fdtable() with 64K pages (2.6.19-rc1-mm1)
Message-ID: <20061010202034.GV4381@austin.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<20061010121519.447d62f8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010121519.447d62f8@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Vadim Lobanov <vlobanov@speakeasy.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2006 at 12:15:19PM -0500, Olof Johansson wrote:
> I keep hitting this on -rc1-mm1. The system comes up but I can't login
> since login hits it.
> 
> Bisect says that fdtable-implement-new-pagesize-based-fdtable-allocator.patch is at fault.
> 
> CONFIG_PPC_64K_PAGES=y is required for it to fail, with 4K pages it's fine.
> 
> (Hardware is a Quad G5, 1GB RAM, g5_defconfig + CONFIG_PPC_64K_PAGES, defaults 
> on all new options)
> 
> 
> 
> kernel BUG in copy_fdtable at fs/file.c:138!

FWIW, I too was hitting this bug, during init:

[   41.659823] Freeing unused kernel memory: 320k freed
INIT: version 2.86 bootin[   42.509322] kernel BUG in copy_fdtable at fs/file.c:138!

and of course systm does not come up.

--linas
