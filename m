Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F31DDDEB8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 05:46:21 +1000 (EST)
Date: Tue, 25 Sep 2007 12:45:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 5/7] Use extended crashkernel command line on ppc64
Message-Id: <20070925124534.b9da41a2.akpm@linux-foundation.org>
In-Reply-To: <20070925182259.398924232@strauss.suse.de>
References: <20070925182257.900701776@strauss.suse.de>
	<20070925182259.398924232@strauss.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Sep 2007 20:23:02 +0200 Bernhard Walle <bwalle@suse.de> wrote:

> This patch adapts the ppc64 code to use the generic parse_crashkernel()
> function introduced in the generic patch of that series.
> 
> 

I really don't like to see patches get a wholesale replacement, especially
when they've been looked at by a few people and have had some testing, etc.
It's not possible to see what changed and people need to re-review stuff
they've already reviewed, etc.

So I almost always undo this mess, turn the patches back into incremental
ones, see what pops out.

This patch is actually:


diff -puN arch/powerpc/kernel/machine_kexec.c~use-extended-crashkernel-command-line-on-ppc64-update arch/powerpc/kernel/machine_kexec.c
--- a/arch/powerpc/kernel/machine_kexec.c~use-extended-crashkernel-command-line-on-ppc64-update
+++ a/arch/powerpc/kernel/machine_kexec.c
@@ -63,7 +63,7 @@ NORET_TYPE void machine_kexec(struct kim
 
 void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size = 0, crash_base;
+	unsigned long long crash_size, crash_base;
 	int ret;
 
 	/* this is necessary because of lmb_phys_mem_size() */
_


which I suspect will now create a compiler warning.


	unsigned long long crash_size, crash_base;
	int ret;

	/* this is necessary because of lmb_phys_mem_size() */
	lmb_analyze();

	/* use common parsing */
	ret = parse_crashkernel(boot_command_line, lmb_phys_mem_size(),
			&crash_size, &crash_base);
	if (ret == 0 && crash_size > 0) {
		if (crash_base == 0)
			crash_base = KDUMP_KERNELBASE;
		crashk_res.start = crash_base;
	} else {
		/* handle the device tree */
		crash_size = crashk_res.end - crashk_res.start + 1;
	}

	if (crash_size == 0)
		return;

If so, the use of uninitialized_var() would be better than the unneeded
initialization-to-zero.
