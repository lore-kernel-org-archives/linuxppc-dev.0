Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.32335.641560.254806@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 16:29:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [RFC v3 PATCH 1/4] Extract list of relocation offsets
In-Reply-To: <4884E0AF.2070809@in.ibm.com>
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop> <48802AE0.30105@in.ibm.com>
	<d8d07a180aaf59d25936ad03c7287f5a@bga.com>
	<4884E0AF.2070809@in.ibm.com>
Cc: naren@linux.vnet.ibm.com, Milton Miller <miltonm@bga.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> diff --git a/arch/powerpc/boot/relocs.c b/arch/powerpc/boot/relocs.c
> new file mode 100644
> index 0000000..31ca903

Where did this file come from?  Did you write it all yourself?  If
not, then you need to credit the original author in the patch
description at least.  Also it needs a copyright notice.

There is some evidence that this has been copied from a similar
program for x86.  For instance, this:

+/*
+ * Following symbols have been audited. There values are constant and do
+ * not change if bzImage is loaded at a different physical address than
+ * the address for which it has been compiled. Don't warn user about
+ * absolute relocations present w.r.t these symbols.
+ */
+static const char* safe_abs_relocs[] = {
+		"__kernel_vsyscall",
+		"__kernel_rt_sigreturn",
+		"__kernel_sigreturn",
+		"SYSENTER_RETURN",
+};

refers to symbols that don't exist on powerpc but (presumably) do on
x86.

Also, this:

+		if (shdr[i].sh_type == SHT_REL) {
+			reltab[i] = malloc(shdr[i].sh_size);
+			if (!reltab[i]) {
+				die("malloc of %d bytes for relocs failed\n",
+					shdr[i].sh_size);
+			}
+			relp = reltab[i];

is, I think, unnecessary, since as far as I know we never get SHT_REL
sections on powerpc.

Paul.
