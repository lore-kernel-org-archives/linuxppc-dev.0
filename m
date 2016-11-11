Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFbDT0pv5zDvnT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 21:06:46 +1100 (AEDT)
Date: Fri, 11 Nov 2016 21:06:02 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 13/38] powerpc: Put exception configuration in a common
 place
Message-ID: <20161111210602.6128fc3f@kryten>
In-Reply-To: <1467026976-7974-14-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-14-git-send-email-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> The various calls to establish exception endianness and AIL are
> now done from a single point using already established CPU and FW
> feature bits to decide what to do.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

...

+static void configure_exceptions(void)
+{
+	/* Setup the trampolines from the lowmem exception vectors
+	 * to the kdump kernel when not using a relocatable kernel.
+	 */
+	setup_kdump_trampoline();
+
+	/* Under a PAPR hypervisor, we need hypercalls */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		long rc;
+
+		/* Enable AIL */
+		rc = pSeries_enable_reloc_on_exc();
+		if (rc == H_P2) {
+			pr_info("Relocation on exceptions not supported\n");
+		} else if (rc != H_SUCCESS) {
+			pr_warn("Unable to enable relocation on exceptions: "
+				"%ld\n", rc);
+		}
+
+		/*
+		 * Tell the hypervisor that we want our exceptions to
+		 * be taken in little endian mode. If this fails we don't
+		 * want to use BUG() because it will trigger an exception.
+		 *
+		 * We don't call this for big endian as our calling convention
+		 * makes us always enter in BE, and the call may fail under
+		 * some circumstances with kdump.
+		 */
+#ifdef __LITTLE_ENDIAN__
+		rc = pseries_little_endian_exceptions();
+		if (rc) {
+			ppc_md.progress("H_SET_MODE LE exception fail", 0);
+			panic("Could not enable little endian exceptions");
+		}
+#endif
+	} else {
+		/* Set endian mode using OPAL */
+		if (firmware_has_feature(FW_FEATURE_OPAL))
+			opal_configure_cores();
+
+		/* Enable AIL if supported, and we are in hypervisor mode */
+		if (cpu_has_feature(CPU_FTR_HVMODE) &&
+		    cpu_has_feature(CPU_FTR_ARCH_207S)) {
+			unsigned long lpcr = mfspr(SPRN_LPCR);
+			mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
+		}
+	}
+}

It looks like we only set LPCR_AIL_3 on the boot CPU after this change,
is that expected? Before that we did it in cpu_ready_for_interrupts()
which is called for the primary and all secondary CPUs.

Anton
