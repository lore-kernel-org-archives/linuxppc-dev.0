Return-Path: <srs1=dmfv=kernel.org==e1is=iu=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yj0m4SSfzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:36:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40yj0m1XKmz8vll
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:36:56 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40yj0l3t5pz9s0x
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2018 23:36:55 +1000 (AEST)
Subject: Patch "powerpc/64s: Wire up cpu_show_spectre_v2()" has been added to
 the 4.9-stable tree
To: gregkh@linuxfoundation.org,linuxppc-dev@ozlabs.org,mpe@ellerman.id.au
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 02 Jun 2018 15:35:39 +0200
In-Reply-To: <20180602110908.29773-19-mpe@ellerman.id.au>
Message-ID: <152794653914023@kroah.com>
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

    powerpc/64s: Wire up cpu_show_spectre_v2()

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-64s-wire-up-cpu_show_spectre_v2.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sat Jun  2 15:29:05 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat,  2 Jun 2018 21:09:03 +1000
Subject: powerpc/64s: Wire up cpu_show_spectre_v2()
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-ID: <20180602110908.29773-19-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit d6fbe1c55c55c6937cbea3531af7da84ab7473c3 upstream.

Add a definition for cpu_show_spectre_v2() to override the generic
version. This has several permuations, though in practice some may not
occur we cater for any combination.

The most verbose is:

  Mitigation: Indirect branch serialisation (kernel only), Indirect
  branch cache disabled, ori31 speculation barrier enabled

We don't treat the ori31 speculation barrier as a mitigation on its
own, because it has to be *used* by code in order to be a mitigation
and we don't know if userspace is doing that. So if that's all we see
we say:

  Vulnerable, ori31 speculation barrier enabled

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -58,3 +58,36 @@ ssize_t cpu_show_spectre_v1(struct devic
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	bool bcs, ccd, ori;
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
+	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
+	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (bcs || ccd) {
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (bcs)
+			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+
+		if (bcs && ccd)
+			seq_buf_printf(&s, ", ");
+
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else
+		seq_buf_printf(&s, "Vulnerable");
+
+	if (ori)
+		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+
+	seq_buf_printf(&s, "\n");
+
+	return s.len;
+}


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.9/powerpc-64s-clear-pcr-on-boot.patch
queue-4.9/powerpc-rfi-flush-differentiate-enabled-and-patched-flush-types.patch
queue-4.9/powerpc-64s-fix-section-mismatch-warnings-from-setup_rfi_flush.patch
queue-4.9/powerpc-pseries-fix-clearing-of-security-feature-flags.patch
queue-4.9/powerpc-powernv-set-or-clear-security-feature-flags.patch
queue-4.9/powerpc-64s-move-cpu_show_meltdown.patch
queue-4.9/powerpc-rfi-flush-call-setup_rfi_flush-after-lpm-migration.patch
queue-4.9/powerpc-pseries-set-or-clear-security-feature-flags.patch
queue-4.9/powerpc-rfi-flush-make-it-possible-to-call-setup_rfi_flush-again.patch
queue-4.9/powerpc-move-default-security-feature-flags.patch
queue-4.9/powerpc-powernv-use-the-security-flags-in-pnv_setup_rfi_flush.patch
queue-4.9/powerpc-add-security-feature-flags-for-spectre-meltdown.patch
queue-4.9/powerpc-pseries-use-the-security-flags-in-pseries_setup_rfi_flush.patch
queue-4.9/powerpc-64s-enhance-the-information-in-cpu_show_meltdown.patch
queue-4.9/powerpc-rfi-flush-move-out-of-hardlockup_detector-ifdef.patch
queue-4.9/powerpc-rfi-flush-always-enable-fallback-flush-on-pseries.patch
queue-4.9/powerpc-rfi-flush-move-the-logic-to-avoid-a-redo-into-the-debugfs-code.patch
queue-4.9/powerpc-pseries-restore-default-security-feature-flags-on-setup.patch
queue-4.9/powerpc-pseries-add-new-h_get_cpu_characteristics-flags.patch
queue-4.9/powerpc-64s-add-support-for-a-store-forwarding-barrier-at-kernel-entry-exit.patch
queue-4.9/powerpc-64s-wire-up-cpu_show_spectre_v1.patch
queue-4.9/powerpc-powernv-support-firmware-disable-of-rfi-flush.patch
queue-4.9/powerpc-pseries-support-firmware-disable-of-rfi-flush.patch
queue-4.9/powerpc-64s-wire-up-cpu_show_spectre_v2.patch
