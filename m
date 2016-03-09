Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD6651A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 16:55:33 +1100 (AEDT)
In-Reply-To: <1457090804-9719-13-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v6,12/20] cxl: Add guest-specific code
Message-Id: <20160309055533.92479140BB4@ozlabs.org>
Date: Wed,  9 Mar 2016 16:55:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-03 at 11:26:36 UTC, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> The new of.c file contains code to parse the device tree to find out
> about cxl adapters and AFUs.
>
> guest.c implements the guest-specific callbacks for the backend API.

...

> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> new file mode 100644
> index 0000000..03eb83d
> --- /dev/null
> +++ b/drivers/misc/cxl/guest.c
> @@ -0,0 +1,950 @@
...
> +static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
> +{
...
> +	disable_afu_irqs(ctx);
> +
> +	rc = cxl_h_attach_process(ctx->afu->guest->handle, elem,
> +				&ctx->process_token, &mmio_addr, &mmio_size);
> +	if (rc == H_SUCCESS) {

This breaks the SMP=n build:

  drivers/misc/cxl/guest.c: In function 'attach_afu_directed':
  drivers/misc/cxl/guest.c:572:12: error: 'H_SUCCESS' undeclared (first use in this function)
  drivers/misc/cxl/guest.c:572:12: note: each undeclared identifier is reported only once for each function it appears in


I've fixed it up with:

diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index f01d4c012620..d6d11f4056d7 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -11,7 +11,6 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#include <asm/hvcall.h>
 #include <asm/byteorder.h>
 #include "hcalls.h"
 #include "trace.h"
diff --git a/drivers/misc/cxl/hcalls.h b/drivers/misc/cxl/hcalls.h
index 6bfab323578d..3e25522a5df6 100644
--- a/drivers/misc/cxl/hcalls.h
+++ b/drivers/misc/cxl/hcalls.h
@@ -12,6 +12,7 @@

 #include <linux/types.h>
 #include <asm/byteorder.h>
+#include <asm/hvcall.h>
 #include "cxl.h"

 #define SG_BUFFER_SIZE 4096


cheers
