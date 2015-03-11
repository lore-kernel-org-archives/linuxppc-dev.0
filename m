Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CCA11A0A16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 03:00:40 +1100 (AEDT)
Received: by wesw62 with SMTP id w62so10259273wes.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 09:00:37 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux@arm.linux.org.uk, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: Documentation: clarify Image placement in
 physical RAM
Date: Wed, 11 Mar 2015 17:00:18 +0100
Message-Id: <1426089620-9459-4-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The early init code maps the kernel image using statically
allocated page tables. This means that we can only allow
Image to be placed such that we can map its entire static
footprint using a single table entry at all but the lowest
level. So update the documentation to reflect that the Image
should not cross a 512 MB boundary, which ensures the above
on both 4k and 64k pages kernels.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index ab5a90adece3..5949bdbe7aac 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -115,8 +115,9 @@ The Image must be placed text_offset bytes from a 2MB aligned base
 address near the start of usable system RAM and called there. Memory
 below that base address is currently unusable by Linux, and therefore it
 is strongly recommended that this location is the start of system RAM.
-At least image_size bytes from the start of the image must be free for
-use by the kernel.
+The physical memory region consisting of image_size bytes counting from
+the start of the image must be free for use by the kernel, and must not
+cross a 512 MB physical alignment boundary.
 
 Any memory described to the kernel (even that below the 2MB aligned base
 address) which is not marked as reserved from the kernel e.g. with a
-- 
1.8.3.2
