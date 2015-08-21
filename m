Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FBA61A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 19:00:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 21 Aug 2015 19:00:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 255C72CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 19:00:27 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7L90GWW8716412
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 19:00:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7L8xr2o018813
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 18:59:54 +1000
Message-ID: <55D6E86E.105@linux.vnet.ibm.com>
Date: Fri, 21 Aug 2015 14:29:26 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
CC: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: linux-next: build failure after merge of the powerpc tree
References: <20150821182535.4423868e@canb.auug.org.au>
In-Reply-To: <20150821182535.4423868e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2015 01:55 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the nvdimm tree, today's linux-next build (powerpc
> allyesconfig) failed like this:

Stephen,

Thanks for reporting! I checked powerpc tree.. This is because of commit
8a8d9181 in powerpc tree.. Basically Michael missed one hunk (below hunk in
opal-api.h)

+/* LED Mode */
+#define POWERNV_LED_MODE_LIGHT_PATH    "lightpath"
+#define POWERNV_LED_MODE_GUIDING_LIGHT "guidinglight"
+
+/* LED type */
+#define POWERNV_LED_TYPE_IDENTIFY      "identify"
+#define POWERNV_LED_TYPE_FAULT         "fault"
+#define POWERNV_LED_TYPE_ATTENTION     "attention"
+
+enum OpalSlotLedType {
+       OPAL_SLOT_LED_TYPE_ID = 0,      /* IDENTIFY LED */
+       OPAL_SLOT_LED_TYPE_FAULT = 1,   /* FAULT LED */
+       OPAL_SLOT_LED_TYPE_ATTN = 2,    /* System Attention LED */
+       OPAL_SLOT_LED_TYPE_MAX = 3
+};
+
+enum OpalSlotLedState {
+       OPAL_SLOT_LED_STATE_OFF = 0,    /* LED is OFF */
+       OPAL_SLOT_LED_STATE_ON = 1      /* LED is ON */
+};
+


@Michael,
  Will you be fixing it or you want me to send separate patch for this one ?

-Vasant




> 
> drivers/leds/leds-powernv.c:30:3: error: 'OPAL_SLOT_LED_TYPE_ID' undeclared here (not in a function)
>   {OPAL_SLOT_LED_TYPE_ID,  POWERNV_LED_TYPE_IDENTIFY},
>    ^
> drivers/leds/leds-powernv.c:30:27: error: 'POWERNV_LED_TYPE_IDENTIFY' undeclared here (not in a function)
>   {OPAL_SLOT_LED_TYPE_ID,  POWERNV_LED_TYPE_IDENTIFY},
>                            ^
> drivers/leds/leds-powernv.c:31:3: error: 'OPAL_SLOT_LED_TYPE_FAULT' undeclared here (not in a function)
>   {OPAL_SLOT_LED_TYPE_FAULT, POWERNV_LED_TYPE_FAULT},
>    ^
> drivers/leds/leds-powernv.c:31:29: error: 'POWERNV_LED_TYPE_FAULT' undeclared here (not in a function)
>   {OPAL_SLOT_LED_TYPE_FAULT, POWERNV_LED_TYPE_FAULT},
>                              ^
> drivers/leds/leds-powernv.c:32:3: error: 'OPAL_SLOT_LED_TYPE_ATTN' undeclared here (not in a function)
>   {OPAL_SLOT_LED_TYPE_ATTN, POWERNV_LED_TYPE_ATTENTION},
>    ^
> drivers/leds/leds-powernv.c:32:28: error: 'POWERNV_LED_TYPE_ATTENTION' undeclared here (not in a function)
>   {OPAL_SLOT_LED_TYPE_ATTN, POWERNV_LED_TYPE_ATTENTION},
>                             ^
> drivers/leds/leds-powernv.c: In function 'powernv_led_set':
> drivers/leds/leds-powernv.c:92:13: error: 'OPAL_SLOT_LED_STATE_ON' undeclared (first use in this function)
>   led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
>              ^
> drivers/leds/leds-powernv.c:92:13: note: each undeclared identifier is reported only once for each function it appears in
> drivers/leds/leds-powernv.c:92:36: error: invalid operands to binary << (have 'const struct led_type_map *' and 'int')
>   led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
>                                     ^
> drivers/leds/leds-powernv.c:92:11: warning: assignment makes integer from pointer without a cast
>   led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
>            ^
> drivers/leds/leds-powernv.c: In function 'powernv_led_get':
> drivers/leds/leds-powernv.c:159:46: error: 'OPAL_SLOT_LED_STATE_ON' undeclared (first use in this function)
>   if (!((led_mask >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)) {
>                                               ^
> drivers/leds/leds-powernv.c:159:44: error: invalid operands to binary & (have 'u64' and 'const struct led_type_map *')
>   if (!((led_mask >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)) {
>                                             ^
> drivers/leds/leds-powernv.c:166:43: error: invalid operands to binary & (have 'u64' and 'const struct led_type_map *')
>   if ((led_value >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)
>                                            ^
> In file included from include/linux/byteorder/big_endian.h:4:0,
>                  from arch/powerpc/include/uapi/asm/byteorder.h:13,
>                  from include/asm-generic/bitops/le.h:5,
>                  from arch/powerpc/include/asm/bitops.h:279,
>                  from include/linux/bitops.h:36,
>                  from include/linux/kernel.h:10,
>                  from include/linux/list.h:8,
>                  from include/linux/kobject.h:20,
>                  from include/linux/device.h:17,
>                  from include/linux/leds.h:15,
>                  from drivers/leds/leds-powernv.c:15:
> drivers/leds/leds-powernv.c: In function 'powernv_led_probe':
> drivers/leds/leds-powernv.c:300:49: error: 'OPAL_SLOT_LED_TYPE_MAX' undeclared (first use in this function)
>   powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>                                                  ^
> include/uapi/linux/byteorder/big_endian.h:36:51: note: in definition of macro '__cpu_to_be64'
>  #define __cpu_to_be64(x) ((__force __be64)(__u64)(x))
>                                                    ^
> drivers/leds/leds-powernv.c:300:37: note: in expansion of macro 'cpu_to_be64'
>   powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>                                      ^
> 
> Caused by commit
> 
>   84ad6e5cd3e8 ("leds/powernv: Add driver for PowerNV platform")
> 
> I suspect that the updates to a file were missed in the commit?
> 
> I have reverted that commit for today.
> 
