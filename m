Return-Path: <SRS0+5fc3bb61b5ebc1b11e7f+512+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4B7A67A5D
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jan 2005 21:16:48 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050109151353.GA9508@suse.de>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	<20050109151353.GA9508@suse.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 10:16:32 +0000
Message-Id: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	hpa@zytor.com
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-01-09 at 16:13 +0100, Olaf Hering wrote:
> 
> > ChangeSet 1.2347, 2005/01/08 14:02:27-08:00, hpa@zytor.com
> > 
> >       [PATCH] raid6: altivec support
> >       
> >       This patch adds Altivec support for RAID-6, if appropriately configured on
> >       the ppc or ppc64 architectures.  Note that it changes the compile flags for
> >       ppc64 in order to handle -maltivec correctly; this change was vetted on the
> >       ppc64 mailing list and OK'd by paulus.
> 
> This fails to compile on ppc, enable_kernel_altivec() is an exported but
> undeclared function. cpu_features is also missing.
> 
> drivers/md/raid6altivec1.c: In function `raid6_altivec1_gen_syndrome':
> drivers/md/raid6altivec1.c:99: warning: implicit declaration of function `enable_kernel_altivec'
> drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
> drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' in something not a structure or union
> drivers/md/raid6altivec2.c: In function `raid6_altivec2_gen_syndrome':
> drivers/md/raid6altivec2.c:110: warning: implicit declaration of function `enable_kernel_altivec'

This makes it compile on PPC, but highlights the difference between
'cur_cpu_spec' on ppc32 and ppc64. Why is 'cur_cpu_spec' an array on
ppc32? Isn't 'cur' supposed to imply 'current'?

===== drivers/md/raid6altivec.uc 1.1 vs edited =====
--- 1.1/drivers/md/raid6altivec.uc	Sat Jan  8 05:44:07 2005
+++ edited/drivers/md/raid6altivec.uc	Mon Jan 17 09:45:20 2005
@@ -108,7 +108,11 @@
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
+#ifdef CONFIG_PPC64
 	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+#else
+	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
+#endif
 }
 #endif
 


-- 
dwmw2
