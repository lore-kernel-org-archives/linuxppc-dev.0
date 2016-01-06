Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39B881A11A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 20:27:28 +1100 (AEDT)
Date: Wed, 6 Jan 2016 12:27:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: leoli@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: re: [POWERPC] Add QUICC Engine (QE) infrastructure
Message-ID: <20160106092715.GA23148@mwanda>
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

Hello Li Yang,

The patch 986585385131: "[POWERPC] Add QUICC Engine (QE)
infrastructure" from Oct 3, 2006, leads to the following static
checker warning:

	drivers/soc/fsl/qe/qe_ic.c:412 qe_ic_set_priority()
	error: buffer overflow 'qe_ic_info' 44 <= 127

drivers/soc/fsl/qe/qe_ic.c
   401  /* Set Priority level within its group, from 1 to 8 */
   402  int qe_ic_set_priority(unsigned int virq, unsigned int priority)
   403  {
   404          struct qe_ic *qe_ic = qe_ic_from_irq(virq);
   405          unsigned int src = virq_to_hw(virq);
   406          u32 temp;
   407  
   408          if (priority > 8 || priority == 0)
   409                  return -EINVAL;
   410          if (src > 127)

The 127 isn't right here, I'm not sure where that value comes from.  It
should be >= ARRAY_SIZE(qe_ic_info).

   411                  return -EINVAL;
   412          if (qe_ic_info[src].pri_reg == 0)
   413                  return -EINVAL;
   414
   415          temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
   416
   417          if (priority < 4) {
   418                  temp &= ~(0x7 << (32 - priority * 3));
   419                  temp |= qe_ic_info[src].pri_code << (32 - priority * 3);
   420          } else {
   421                  temp &= ~(0x7 << (24 - priority * 3));
   422                  temp |= qe_ic_info[src].pri_code << (24 - priority * 3);
   423          }
   424
   425          qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
   426
   427          return 0;
   428  }

regards,
dan carpenter
