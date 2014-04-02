Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E168C140102
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 03:48:29 +1100 (EST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s32GmRiE021277
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 16:48:27 GMT
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s32GmN0p025820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 16:48:23 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
 by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s32GmMDs023691
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 16:48:22 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s32GmLCL010426
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 16:48:21 GMT
Date: Wed, 2 Apr 2014 19:48:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] bad error path in fsl_open_inb_mbox()
Message-ID: <20140402164814.GA8126@mwanda>
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

Hello PPC devs,

Smatch has the following warning:

	arch/powerpc/sysdev/fsl_rmu.c:884 fsl_open_inb_mbox()
	error: buffer overflow 'rmu->msg_tx_ring.virt_buffer' 2048 <= 2048

arch/powerpc/sysdev/fsl_rmu.c
   861          for (i = 0; i < rmu->msg_rx_ring.size; i++)
   862                  rmu->msg_rx_ring.virt_buffer[i] = NULL;

Here we set i one past the end of the ->virt_buffer[] array.

   863  
   864          /* Initialize inbound message ring */
   865          rmu->msg_rx_ring.virt = dma_alloc_coherent(priv->dev,
   866                                  rmu->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
   867                                  &rmu->msg_rx_ring.phys, GFP_KERNEL);
   868          if (!rmu->msg_rx_ring.virt) {
   869                  rc = -ENOMEM;
   870                  goto out;
   871          }
   872  
   873          /* Point dequeue/enqueue pointers at first entry in ring */
   874          out_be32(&rmu->msg_regs->ifqdpar, (u32) rmu->msg_rx_ring.phys);
   875          out_be32(&rmu->msg_regs->ifqepar, (u32) rmu->msg_rx_ring.phys);
   876  
   877          /* Clear interrupt status */
   878          out_be32(&rmu->msg_regs->isr, 0x00000091);
   879  
   880          /* Hook up inbound message handler */
   881          rc = request_irq(IRQ_RIO_RX(mport), fsl_rio_rx_handler, 0,
   882                           "msg_rx", (void *)mport);
   883          if (rc < 0) {
   884                  dma_free_coherent(priv->dev, RIO_MSG_BUFFER_SIZE,
   885                          rmu->msg_tx_ring.virt_buffer[i],
                                                 ^^^^^^^^^^^^^^
Wrong variable.

   886                          rmu->msg_tx_ring.phys_buffer[i]);
                                                 ^^^^^^^^^^^^^^

This should probably be something like:

			dma_free_coherent(priv->dev,
				rmu->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
				rmu->msg_rx_ring.virt, rmu->msg_rx_ring.phys);

But dma_free_coherent() is poorly documented (it's not documented at
all) and I can't even compile this code so I don't feel comfortable
patching this myself.

Please give me a Reported-by tag if you fix this.

   887                  goto out;
   888          }

regards,
dan carpenter
