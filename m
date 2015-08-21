Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD1BF1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 18:25:35 +1000 (AEST)
Date: Fri, 21 Aug 2015 18:25:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20150821182535.4423868e@canb.auug.org.au>
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

Hi all,

After merging the nvdimm tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/leds/leds-powernv.c:30:3: error: 'OPAL_SLOT_LED_TYPE_ID' undeclared here (not in a function)
  {OPAL_SLOT_LED_TYPE_ID,  POWERNV_LED_TYPE_IDENTIFY},
   ^
drivers/leds/leds-powernv.c:30:27: error: 'POWERNV_LED_TYPE_IDENTIFY' undeclared here (not in a function)
  {OPAL_SLOT_LED_TYPE_ID,  POWERNV_LED_TYPE_IDENTIFY},
                           ^
drivers/leds/leds-powernv.c:31:3: error: 'OPAL_SLOT_LED_TYPE_FAULT' undeclared here (not in a function)
  {OPAL_SLOT_LED_TYPE_FAULT, POWERNV_LED_TYPE_FAULT},
   ^
drivers/leds/leds-powernv.c:31:29: error: 'POWERNV_LED_TYPE_FAULT' undeclared here (not in a function)
  {OPAL_SLOT_LED_TYPE_FAULT, POWERNV_LED_TYPE_FAULT},
                             ^
drivers/leds/leds-powernv.c:32:3: error: 'OPAL_SLOT_LED_TYPE_ATTN' undeclared here (not in a function)
  {OPAL_SLOT_LED_TYPE_ATTN, POWERNV_LED_TYPE_ATTENTION},
   ^
drivers/leds/leds-powernv.c:32:28: error: 'POWERNV_LED_TYPE_ATTENTION' undeclared here (not in a function)
  {OPAL_SLOT_LED_TYPE_ATTN, POWERNV_LED_TYPE_ATTENTION},
                            ^
drivers/leds/leds-powernv.c: In function 'powernv_led_set':
drivers/leds/leds-powernv.c:92:13: error: 'OPAL_SLOT_LED_STATE_ON' undeclared (first use in this function)
  led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
             ^
drivers/leds/leds-powernv.c:92:13: note: each undeclared identifier is reported only once for each function it appears in
drivers/leds/leds-powernv.c:92:36: error: invalid operands to binary << (have 'const struct led_type_map *' and 'int')
  led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
                                    ^
drivers/leds/leds-powernv.c:92:11: warning: assignment makes integer from pointer without a cast
  led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
           ^
drivers/leds/leds-powernv.c: In function 'powernv_led_get':
drivers/leds/leds-powernv.c:159:46: error: 'OPAL_SLOT_LED_STATE_ON' undeclared (first use in this function)
  if (!((led_mask >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)) {
                                              ^
drivers/leds/leds-powernv.c:159:44: error: invalid operands to binary & (have 'u64' and 'const struct led_type_map *')
  if (!((led_mask >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)) {
                                            ^
drivers/leds/leds-powernv.c:166:43: error: invalid operands to binary & (have 'u64' and 'const struct led_type_map *')
  if ((led_value >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)
                                           ^
In file included from include/linux/byteorder/big_endian.h:4:0,
                 from arch/powerpc/include/uapi/asm/byteorder.h:13,
                 from include/asm-generic/bitops/le.h:5,
                 from arch/powerpc/include/asm/bitops.h:279,
                 from include/linux/bitops.h:36,
                 from include/linux/kernel.h:10,
                 from include/linux/list.h:8,
                 from include/linux/kobject.h:20,
                 from include/linux/device.h:17,
                 from include/linux/leds.h:15,
                 from drivers/leds/leds-powernv.c:15:
drivers/leds/leds-powernv.c: In function 'powernv_led_probe':
drivers/leds/leds-powernv.c:300:49: error: 'OPAL_SLOT_LED_TYPE_MAX' undeclared (first use in this function)
  powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
                                                 ^
include/uapi/linux/byteorder/big_endian.h:36:51: note: in definition of macro '__cpu_to_be64'
 #define __cpu_to_be64(x) ((__force __be64)(__u64)(x))
                                                   ^
drivers/leds/leds-powernv.c:300:37: note: in expansion of macro 'cpu_to_be64'
  powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
                                     ^

Caused by commit

  84ad6e5cd3e8 ("leds/powernv: Add driver for PowerNV platform")

I suspect that the updates to a file were missed in the commit?

I have reverted that commit for today.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
