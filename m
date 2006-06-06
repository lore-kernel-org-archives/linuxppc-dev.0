Return-Path: <lagrange@fr.oleane.com>
Received: from smtp4.clb.oleane.net (smtp4.clb.oleane.net [213.56.31.20])
	by ozlabs.org (Postfix) with ESMTP id 01EFF67A60
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 23:39:03 +1000 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp4.clb.oleane.net with ESMTP id k56DcuLV013112
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Jun 2006 15:38:59 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Linux kernel thread with Linux 2.6.x
Date: Tue, 6 Jun 2006 15:39:42 +0200
Message-ID: <001001c6896e$ac82f7f0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have tried many solutions, the two last solutions (work_queue and
kernel_thread)
seem to have the same poor performances.

Does anyone have another idea ?
Thanks in advance.
Laurent

PS : eth_init_rx_bd function can allocate a new skbuff (YES parameter) or
re-use
the previous skbuff allocated to a rx buffer descriptor(NO parameter).

1) tasklet : runs in interrupt context and
then doesn't support semaphore down function.

2) work_queue : doesn't run in interrupt context
and supports semaphore down function.

static irqreturn_t eth_interrupt (int irq, void * dev_id, struct pt_regs *
regs)
{
    DRV_ETH_INFO    *info       = (DRV_ETH_INFO *)dev_id;
    unsigned short  events;

    /* get pending events */
    events = info->eth_reg->fcc_fcce & info->eth_reg->fcc_fccm;

    /* ack pending events */
    info->eth_reg->fcc_fcce = events;

    /* mask interrupts */
    info->eth_reg->fcc_fccm = ~events;

    /* check events */
    if (BTST(FCC_ENET_RXF, events))
tasklet_schedule(&Info_low->recvTasklet);
    if (BTST(FCC_ENET_TXE|FCC_ENET_TXB, events))
tasklet_schedule(&Info_low->xmitEndTasklet);

    return(IRQ_HANDLED);
}

static void eth_rx_event (DRV_ETH_INFO *info)
{
    ETH_BD_MGT_TABLE    *bd_table   = &info->eth_bd_table;
    ETH_BD_MGT          *bd_mgt     = &bd_table->rx[bd_table->rx_out];
    struct sk_buff      *skb;

    /* check empty status */
    while(BTST(BD_ENET_RX_EMPTY, bd_mgt->bd->cbd_sc) == 0) {
        /* check error and upper layer status */
        if
(BTST((BD_ENET_RX_LG|BD_ENET_RX_SH|BD_ENET_RX_NO|BD_ENET_RX_CR|BD_ENET_RX_OV
|BD_ENET_RX_CL), bd_mgt->bd->cbd_sc))    {
            /* re-enable bd with current buffer */
            eth_init_rx_bd(info, bd_mgt, NO); /* always return without error
*/
        } else {
            /* save current segment */
            skb         = (struct sk_buff *)bd_mgt->segment;
            skb->len    = bd_mgt->bd->cbd_datlen;

            /* get a new buffer for this bd */
            if (eth_init_rx_bd(info, bd_mgt, YES) == BRG_NO_ERROR) {
                /* fill sk_buff parameters */
	          skb->dev      = info->dev;
		    skb->protocol = eth_type_trans(skb, info->dev);

		    /* send frame to upper layers that use semaphores */
		    netif_packet(skb);
		} else {
                /* re-enable bd with current buffer */
                eth_init_rx_bd(info, bd_mgt, NO); /* always return without
error */
            }
        }

        /* set next index */
        bd_table->rx_out = (bd_table->rx_out == (ETH_RX_BD_NUMBER -
1))?0:(bd_table->rx_out + 1);

        /* get next bd mgt pointer */
        bd_mgt = &bd_table->rx[bd_table->rx_out];
    }

    /* enable interruption*/
    info->eth_reg->fcc_fccm |= FCC_ENET_RXF;

    return;
}

3) kernel_thread : doesn't run in interrupt context
and supports semaphore down function. I have tried to
change many task parameters :
    task->policy		= SCHED_RR;
    task->static_prio	= 100;
    task->prio		= 100;
    task->rt_priority	= 1;

To synchronize the rx interrruption and the thread I have tried completion
and semaphore mecanism without any difference

static irqreturn_t eth_interrupt (int irq, void * dev_id, struct pt_regs *
regs)
{
    DRV_ETH_INFO    *info       = (DRV_ETH_INFO *)dev_id;
    USHORT          events;

    /* get pending events */
    events = info->eth_reg->fcc_fcce & info->eth_reg->fcc_fccm;

    /* ack pending events */
    info->eth_reg->fcc_fcce = events;

    /* mask interrupts */
    info->eth_reg->fcc_fccm = ~events;

    /* check events */
    if (BTST(FCC_ENET_RXF, events)) osSemSignal(Info_low->recvSem);
    if (BTST(FCC_ENET_TXE|FCC_ENET_TXB, events))
osSemSignal(Info_low->xmitEndSem);

    return(IRQ_HANDLED);
}

unsigned eth_recv_task (void* data)
{
    DRV_ETH_INFO        *info       = (DRV_ETH_INFO
*)Info_low->drv_eth_info;
    ETH_BD_MGT_TABLE    *bd_table   = &info->eth_bd_table;
    ETH_BD_MGT          *bd_mgt     = &bd_table->rx[bd_table->rx_out];

    while(1) {
        /* wait interrupt */
        osSemWait(Info_low->recvSem, 0);

        /* check empty status */
        while(BTST(BD_ENET_RX_EMPTY, bd_mgt->bd->cbd_sc) == 0) {
            /* check error and upper layer status */
            if
(BTST((BD_ENET_RX_LG|BD_ENET_RX_SH|BD_ENET_RX_NO|BD_ENET_RX_CR|BD_ENET_RX_OV
|BD_ENET_RX_CL), bd_mgt->bd->cbd_sc))    {
                /* re-enable bd with current buffer */
                eth_init_rx_bd(info, bd_mgt, NO); /* always return without
error */
            } else {
                /* save current segment */
                skb         = (struct sk_buff *)bd_mgt->segment;
                skb->len    = bd_mgt->bd->cbd_datlen - 4;

            /* get a new buffer for this bd */
            if (eth_init_rx_bd(info, bd_mgt, YES) == BRG_NO_ERROR) {
                /* fill sk_buff parameters */
	          skb->dev      = info->dev;
		    skb->protocol = eth_type_trans(skb, info->dev);

		    /* send frame to upper layers that use semaphores */
		    netif_packet(skb);
		} else {
                /* re-enable bd with current buffer */
                eth_init_rx_bd(info, bd_mgt, NO); /* always return without
error */
            }

            /* set next index */
            bd_table->rx_out = (bd_table->rx_out == (ETH_RX_BD_NUMBER -
1))?0:(bd_table->rx_out + 1);

            /* get next bd mgt pointer */
            bd_mgt = &bd_table->rx[bd_table->rx_out];
        }

        /* enable interrupt */
        info->eth_reg->fcc_fccm |= FCC_ENET_RXF;
    }
    return(0);
}
