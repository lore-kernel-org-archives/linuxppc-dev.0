Return-Path: <srs1=ml38=kernel.org==wfse=ik=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rfWC4frrzDr2J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:23:51 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40rfWC202jz8tLb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:23:51 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40rfWB5BGRz9s15
 for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2018 03:23:50 +1000 (AEST)
Subject: Patch "powerpc/64s: Wire up cpu_show_spectre_v1()" has been added to
 the 4.16-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 May 2018 19:23:12 +0200
In-Reply-To: <20180522144125.10345-11-mpe@ellerman.id.au>
Message-ID: <15270961929234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    powerpc/64s: Wire up cpu_show_spectre_v1()

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-64s-wire-up-cpu_show_spectre_v1.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed May 23 19:18:22 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 23 May 2018 00:41:21 +1000
Subject: powerpc/64s: Wire up cpu_show_spectre_v1()
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180522144125.10345-11-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit 56986016cb8cd9050e601831fe89f332b4e3c46e upstream.

Add a definition for cpu_show_spectre_v1() to override the generic
version. Currently this just prints "Not affected" or "Vulnerable"
based on the firmware flag.

Although the kernel does have array_index_nospec() in a few places, we
haven't yet audited all the powerpc code to see where it's necessary,
so for now we don't list that as a mitigation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -50,3 +50,11 @@ ssize_t cpu_show_meltdown(struct device
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.16/powerpc-pseries-fix-clearing-of-security-feature-flags.patch
queue-4.16/powerpc-powernv-set-or-clear-security-feature-flags.patch
queue-4.16/powerpc-64s-move-cpu_show_meltdown.patch
queue-4.16/powerpc-pseries-set-or-clear-security-feature-flags.patch
queue-4.16/powerpc-move-default-security-feature-flags.patch
queue-4.16/powerpc-powernv-use-the-security-flags-in-pnv_setup_rfi_flush.patch
queue-4.16/powerpc-add-security-feature-flags-for-spectre-meltdown.patch
queue-4.16/powerpc-pseries-use-the-security-flags-in-pseries_setup_rfi_flush.patch
queue-4.16/powerpc-64s-enhance-the-information-in-cpu_show_meltdown.patch
queue-4.16/powerpc-rfi-flush-always-enable-fallback-flush-on-pseries.patch
queue-4.16/powerpc-pseries-add-new-h_get_cpu_characteristics-flags.patch
queue-4.16/powerpc-64s-add-support-for-a-store-forwarding-barrier-at-kernel-entry-exit.patch
queue-4.16/powerpc-64s-wire-up-cpu_show_spectre_v1.patch
queue-4.16/powerpc-64s-wire-up-cpu_show_spectre_v2.patch
