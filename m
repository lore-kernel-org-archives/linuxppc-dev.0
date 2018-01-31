Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWr4W1qQjzDqq1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 04:35:38 +1100 (AEDT)
Date: Wed, 31 Jan 2018 18:29:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: qiang.zhao@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] fsl/qe: setup clock source for TDM mode
Message-ID: <20180131152933.GA20827@mwanda>
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

Hello Zhao Qiang,

The patch bb8b2062aff3: "fsl/qe: setup clock source for TDM mode"
from Jun 6, 2016, leads to the following static checker warning:

	drivers/soc/fsl/qe/ucc.c:629 ucc_get_tdm_sync_shift()
	warn: both sides of ternary the same: '30' RX_SYNC_SHIFT_BASE RX_SYNC_SHIFT_BASE

drivers/soc/fsl/qe/ucc.c
   625  static u32 ucc_get_tdm_sync_shift(enum comm_dir mode, u32 tdm_num)
   626  {
   627          u32 shift;
   628  
   629          shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : RX_SYNC_SHIFT_BASE;
                                                                     ^^^^^^^^^^^^^^^^^^

Maybe this one should have been TX_?

   630          shift -= tdm_num * 2;
   631  
   632          return shift;
   633  }

regards,
dan carpenter
