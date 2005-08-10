Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2A2E567E98
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 05:16:53 +1000 (EST)
In-Reply-To: <42FA4108.9090808@ru.mvista.com>
References: <42FA3636.7010804@ru.mvista.com> <42FA3D7B.8040200@ru.mvista.com>
	<42FA4108.9090808@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4BA092C9-1517-416E-9C98-90F9D8F41857@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 10 Aug 2005 14:16:57 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
	final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

+static int __init find_chip_by_name_and_id(char *name, u32 id)
+{
+    int ret = -1;
+    unsigned int i = 0;
+    unsigned int j = 0;
+    unsigned int dups = 0;
+
+    unsigned int matched[count_sys_specs()];

Is is legit in the kernel to use dynamically sized array?

+
+    while (strcmp(ppc_sys_specs[i].ppc_sys_name, "")) {
+        if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
+            matched[j++] = i;
+        i++;
+    }
+    if (j != 0) {
+        for (i = 0; i < j; i++) {
+            if ((ppc_sys_specs[matched[i]].mask & id) ==
+                ppc_sys_specs[matched[i]].value) {
+                ret = matched[i];
+                dups++;
+            }
+        }
+        ret = (dups == 1) ? ret : (-1 * dups);
+    }
+    return ret;
+}

On Aug 10, 2005, at 1:01 PM, Vitaly Bordug wrote:

> Finally correct indentation style.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>
> -- 
> Sincerely,
> Vitaly
>
> <ppc_sys_add.patch>
> <ATT87954.txt>
>
