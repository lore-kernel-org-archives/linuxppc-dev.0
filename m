Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqF8v4bDVzDvkc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 20:15:59 +1000 (AEST)
Date: Wed, 13 Jul 2016 13:15:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] [PATCH] powerpc: Thermal control for dual core G5s
Message-ID: <20160713101546.GK29468@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Benjamin Herrenschmidt,

The patch ac171c46667c: "[PATCH] powerpc: Thermal control for dual
core G5s" from Feb 8, 2006, leads to the following static checker
warning:

	drivers/macintosh/windfarm_smu_controls.c:83 smu_set_fan()
	warn: buffer overflow 'buffer' 16 <= 16

drivers/macintosh/windfarm_smu_controls.c
    54  static int smu_set_fan(int pwm, u8 id, u16 value)
    55  {
    56          struct smu_cmd cmd;
    57          u8 buffer[16];
                   ^^^^^^^^^^
16 bytes.

    58          DECLARE_COMPLETION_ONSTACK(comp);
    59          int rc;
    60  
    61          /* Fill SMU command structure */
    62          cmd.cmd = SMU_CMD_FAN_COMMAND;
    63  
    64          /* The SMU has an "old" and a "new" way of setting the fan speed
    65           * Unfortunately, I found no reliable way to know which one works
    66           * on a given machine model. After some investigations it appears
    67           * that MacOS X just tries the new one, and if it fails fallbacks
    68           * to the old ones ... Ugh.
    69           */
    70   retry:
    71          if (smu_supports_new_fans_ops) {
    72                  buffer[0] = 0x30;
    73                  buffer[1] = id;
    74                  *((u16 *)(&buffer[2])) = value;
    75                  cmd.data_len = 4;
    76          } else {
    77                  if (id > 7)
                            ^^^^^^
Assume id is 7.

    78                          return -EINVAL;
    79                  /* Fill argument buffer */
    80                  memset(buffer, 0, 16);
    81                  buffer[0] = pwm ? 0x10 : 0x00;
    82                  buffer[1] = 0x01 << id;
    83                  *((u16 *)&buffer[2 + id * 2]) = value;
                                  ^^^^^^^^^^^^^^^^^^
2 + 7 * 2 = 16.  We're write two bytes beyond the end of the array.

    84                  cmd.data_len = 14;
    85          }
    86  


regards,
dan carpenter
