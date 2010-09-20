Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E0F5B70D0
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 05:30:44 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8KJFpde027726
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 15:15:51 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8KJUfhH107492
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 15:30:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8KJUem0012970
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 15:30:41 -0400
Date: Mon, 20 Sep 2010 15:30:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] [v2] powerpc: export ppc_proc_freq and ppc_tb_freq
	as GPL symbols
Message-ID: <20100920193035.GB3845@zod.rchland.ibm.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284999822-24753-1-git-send-email-timur@freescale.com>
Cc: kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 20, 2010 at 11:23:41AM -0500, Timur Tabi wrote:
>Export the global variable 'ppc_tb_freq', so that modules (like the Book-E
>watchdog driver) can use it.  To maintain consistency, ppc_proc_freq is changed
>to a GPL-only export.  This is okay, because any module that needs this symbol
>should be an actual Linux driver, which must be GPL-licensed.
>
>Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
>
>This export is necessary for the Book-E watchdog driver to be compiled as a
>module.
>
> arch/powerpc/kernel/time.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>
>diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>index 8533b3b..0c0c241 100644
>--- a/arch/powerpc/kernel/time.c
>+++ b/arch/powerpc/kernel/time.c
>@@ -161,8 +161,9 @@ extern struct timezone sys_tz;
> static long timezone_offset;
>
> unsigned long ppc_proc_freq;
>-EXPORT_SYMBOL(ppc_proc_freq);
>+EXPORT_SYMBOL_GPL(ppc_proc_freq);
> unsigned long ppc_tb_freq;
>+EXPORT_SYMBOL_GPL(ppc_tb_freq);
>
> static DEFINE_PER_CPU(u64, last_jiffy);
>
>-- 
>1.7.2.3
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
