Return-Path: <prvs=06262a8b8d=bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BvPK5gDMzF1YV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 06:06:42 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2TJ15pF074695
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 15:06:39 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h15tnggtq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 15:06:39 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 13:06:38 -0600
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: kexec_file: Fix error code when trying to load kdump
 kernel
Date: Thu, 29 Mar 2018 16:05:43 -0300
Message-Id: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
returns -ENOTSUPP in that case.

I've recently learned that this errno is internal to the kernel and isn't
supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
is defined in an uapi header.

This does indeed make kexec-tools happier. Before the patch, on ppc64le:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Unknown error 524

After the patch:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Operation not supported

Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is a minor issue, but since it's a simple patch it might be worth
applying it to stable branches.

This is the kexec-tools thread where this problem was brought up:

https://lists.infradead.org/pipermail/kexec/2018-March/020346.html

And this is an instance of a similar fix being applied elsewhere in the
kernel, for the same reasons:

https://patchwork.kernel.org/patch/8490791/

The test shown in the commit log was made using Hari Bathini's patch
adding kexec_file_load() support to kexec-tools in ppc64.

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index e4395f937d63..45e0b7d5f200 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 
 	/* We don't support crash kernels yet. */
 	if (image->type == KEXEC_TYPE_CRASH)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
 		fops = kexec_file_loaders[i];
