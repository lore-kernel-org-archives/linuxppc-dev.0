Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 7337DDDF14
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 10:04:06 +1000 (EST)
MIME-Version: 1.0
Date: Wed, 23 Apr 2008 09:04:04 +0900
Subject: Re: Xilinx PowerPC
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	Grant Likely <grant.likely@secretlab.ca>
Message-ID: <JM200804230904046.2598203@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <480BD66B.90001@dlasys.net>
References: <480BA36D.1080000@dlasys.net>
	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>
	<480BA821.2030109@dlasys.net>
	<fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
	<480BD66B.90001@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am writing the Non-Xilinx XPS_LL_TEMAC driver.
Checksum offloading is incomplete although NAPI and KGDBOE are supported.
Basic operation is working on EDK9.2 and EDK10.1.

Furthermore, although the simple Non-Interrupt version for u-boot is
also written, it is not known where I should post.

Best Regards,

Yoshio Kashiwagi - Nissin Systems

/*
 *
 * Xilinx Gigabit System Referece Design Ethenet driver
 *
 * Driver for Xilinx Virtex-4FX Based Platform
 *
 * Author: Yoshio Kashiwagi
 *
 * Copyright (c) 2008 Nissin Systems Co.,Ltd.
 *
 * March 2008 created
 *
 * This program is free software; you can redistribute  it and/or modify 
it
 * under  the terms of  the GNU General  Public License as published by 
the
 * Free Software Foundation;  either version 2 of the  License, or (at 
your
 * option) any later version.
 *
*/

#include <linux/autoconf.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/init.h>
#include <linux/in.h>
#include <linux/moduleparam.h>
#include <linux/spinlock.h>
#include <linux/pci.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <platforms/4xx/xparameters/xparameters.h>

#include <linux/inet.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/skbuff.h>
#include <linux/ethtool.h>
#include <net/sock.h>
#include <net/checksum.h>
#include <linux/if_ether.h>
#include <linux/if_arp.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <linux/percpu.h>

#define S_DMA_CTRL_BASEADDR XPAR_LLTEMAC_0_LLINK_CONNECTED_BASEADDR
#define XPS_LLTEMAC_BASEADDR    XPAR_LLTEMAC_0_BASEADDR

/* XPS_LL_TEMAC SDMA registers definition */

#define TX_NXTDESC_PTR      0x00
#define TX_CURBUF_ADDR      0x04
#define TX_CURBUF_LENGTH    0x08
#define TX_CURDESC_PTR      0x0c
#define TX_TAILDESC_PTR     0x10
#define TX_CHNL_CTRL        0x14
#define TX_IRQ_REG      0x18
#define TX_CHNL_STS     0x1c

#define RX_NXTDESC_PTR      0x20
#define RX_CURBUF_ADDR      0x24
#define RX_CURBUF_LENGTH    0x28
#define RX_CURDESC_PTR      0x2c
#define RX_TAILDESC_PTR     0x30
#define RX_CHNL_CTRL        0x34
#define RX_IRQ_REG      0x38
#define RX_CHNL_STS     0x3c

#define DMA_CONTROL_REG     0x40

/* XPS_LL_TEMAC direct registers definition */

#define TEMAC_RAF0      0x00
#define TEMAC_TPF0      0x04
#define TEMAC_IFGP0     0x08
#define TEMAC_IS0       0x0c
#define TEMAC_IP0       0x10
#define TEMAC_IE0       0x14

#define TEMAC_MSW0      0x20
#define TEMAC_LSW0      0x24
#define TEMAC_CTL0      0x28
#define TEMAC_RDY0      0x2c

#define XTE_RSE_MIIM_RR_MASK      0x0002
#define XTE_RSE_MIIM_WR_MASK      0x0004
#define XTE_RSE_CFG_RR_MASK       0x0020
#define XTE_RSE_CFG_WR_MASK       0x0040

/* XPS_LL_TEMAC indirect registers offset definition */

#define RCW0    0x200
#define RCW1    0x240
#define TC  0x280
#define FCC 0x2c0
#define EMMC    0x300
#define PHYC    0x320
#define MC  0x340
#define UAW0    0x380
#define UAW1    0x384
#define MAW0    0x388
#define MAW1    0x38c
#define AFM 0x390
#define TIS 0x3a0
#define TIE 0x3a4
#define MIIMWD  0x3b0
#define MIIMAI  0x3b4

#define CNTLREG_WRITE_ENABLE_MASK   0x8000
#define CNTLREG_EMAC1SEL_MASK       0x0400
#define CNTLREG_ADDRESSCODE_MASK    0x03ff

#define MDIO_ENABLE_MASK        0x40
#define MDIO_CLOCK_DIV_MASK 0x3F
#define MDIO_CLOCK_DIV_100MHz   0x28

#define ETHER_MTU       1500
#define EMAC_PHY_ID     7

/* CDMAC descriptor status bit definitions */

#define BDSTAT_ERROR_MASK       0x80000000
#define BDSTAT_INT_ON_END_MASK  0x40000000
#define BDSTAT_STOP_ON_END_MASK 0x20000000
#define BDSTAT_COMPLETED_MASK   0x10000000
#define BDSTAT_SOP_MASK         0x08000000
#define BDSTAT_EOP_MASK         0x04000000
#define BDSTAT_CHANBUSY_MASK    0x02000000
#define BDSTAT_CHANRESET_MASK   0x01000000

#define TEMAC_MAC_ADDR_SIZE 6
#define TEMAC_MTU       1500
#define TEMAC_JUMBO_MTU     9000
#define TEMAC_HDR_SIZE      14
#define TEMAC_HDR_VLAN_SIZE 18
#define TEMAC_TRL_SIZE      4
#define TEMAC_MAX_FRAME_SIZE        (TEMAC_MTU + TEMAC_HDR_SIZE + TEMAC_
TRL_SIZE)
#define TEMAC_MAX_VLAN_FRAME_SIZE   (TEMAC_MTU + TEMAC_HDR_VLAN_SIZE + 
TEMAC_TRL_SIZE)
#define TEMAC_MAX_JUMBO_FRAME_SIZE  (TEMAC_JUMBO_MTU + TEMAC_HDR_SIZE + 
TEMAC_TRL_SIZE)

#define TX_CONTROL_CALC_CSUM_MASK   1

#define SDMA_MASTER_IRQ     (1 << 7)
#define SDMA_COA_IRQ        (1)
#define SDMA_DLY_IRQ        (1 << 1)
#define SDMA_ERR_IRQ        (1 << 2)

#define ALIGNMENT       32
#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32) adr)) % ALIGNMENT)

#define MULTICAST_CAM_TABLE_NUM 4

#define TX_BD_NUM   64
#define RX_BD_NUM   128

#define XEM_MAX_FRAME_SIZE  TEMAC_MAX_JUMBO_FRAME_SIZE

#define XILINX_GSRD3_NAPI

#define sdma_reg_write(dev, offset, value)  (*(unsigned int *)(dev->
sdma_reg_base + offset) = value)
#define sdma_reg_read(dev, offset)  (*(volatile unsigned int *)(dev->
sdma_reg_base + offset))
#define temac_reg_write(dev, offset, value) (*(unsigned int *)(dev->
temac_reg_base + offset) = value)
#define temac_reg_read(dev, offset) (*(volatile unsigned int *)(dev->
temac_reg_base + offset))

struct net_local {
    struct net_device_stats stats;
    struct net_device *next_dev;
    int index;
    unsigned int sdma_reg_base;
    unsigned int temac_reg_base;
    int tx_irq;
    int rx_irq;
    struct timer_list phy_timer;
};

typedef struct cdmac_bd_t {
    struct cdmac_bd_t *next_p;
    unsigned char *phys_buf_p;
    unsigned long buf_len;
    unsigned long app0;
    unsigned long app1;
    unsigned long app2;
    unsigned long app3;
    unsigned long app4;
} cdmac_bd ;

typedef struct cdmac_tx_bd_t {
    cdmac_bd tx_bd[TX_BD_NUM];
} cdmac_tx_bd ;

typedef struct cdmac_rx_bd_t {
    cdmac_bd rx_bd[RX_BD_NUM];
} cdmac_rx_bd ;

static cdmac_tx_bd *cdmac_tx_bd_virt_p;
static cdmac_rx_bd *cdmac_rx_bd_virt_p;
static cdmac_tx_bd *cdmac_tx_bd_phys_p;
static cdmac_rx_bd *cdmac_rx_bd_phys_p;

static struct sk_buff *rx_skb[RX_BD_NUM];

static volatile int cur_tx_bd =  0;
static volatile int next_tx_bd = 0;
static volatile int tail_tx_bd = 0;
static int cur_rx_bd = 0;

static struct net_device *dev_list = NULL;
static spinlock_t dev_lock;
static spinlock_t rcv_lock;
static spinlock_t xmt_lock;

static int xps_ll_temac_xmit(struct sk_buff *skb, struct net_device *dev)
;
static struct net_device_stats *xps_ll_temac_get_stats(struct net_device 
*dev);

static void xps_ll_temac_hostif_set(struct net_device *dev, int emac, 
int phy_addr, int reg_addr, int phy_data)
{
    struct net_local *lp = (struct net_local *)dev->priv;

    temac_reg_write(lp, TEMAC_LSW0, phy_data);
    temac_reg_write(lp, TEMAC_CTL0, CNTLREG_WRITE_ENABLE_MASK | MIIMWD);
    temac_reg_write(lp, TEMAC_LSW0, ((phy_addr << 5) | (reg_addr)));
    temac_reg_write(lp, TEMAC_CTL0, CNTLREG_WRITE_ENABLE_MASK | MIIMAI | 
(emac << 10));
    while(!(temac_reg_read(lp, TEMAC_RDY0) & XTE_RSE_MIIM_WR_MASK));
}

static unsigned int xps_ll_temac_hostif_get(struct net_device *dev, int 
emac, int phy_addr, int reg_addr)
{
    struct net_local *lp = (struct net_local *)dev->priv;

    temac_reg_write(lp, TEMAC_LSW0, ((phy_addr << 5) | (reg_addr)));
    temac_reg_write(lp, TEMAC_CTL0, MIIMAI | (emac << 10));

    while(!(temac_reg_read(lp, TEMAC_RDY0) & XTE_RSE_MIIM_RR_MASK));
    return temac_reg_read(lp, TEMAC_LSW0);
}

static void xps_ll_temac_indirect_set(struct net_device *dev, int emac, 
int reg_offset, int reg_data)
{
    struct net_local *lp = (struct net_local *)dev->priv;

    temac_reg_write(lp, TEMAC_LSW0, reg_data);
    temac_reg_write(lp, TEMAC_CTL0, (CNTLREG_WRITE_ENABLE_MASK | (emac <
< 10) | reg_offset));

    while(!(temac_reg_read(lp, TEMAC_RDY0) & XTE_RSE_CFG_WR_MASK));
}

static void xps_ll_temac_phy_ctrl(struct net_device *dev)
{
    unsigned int result;

    result = xps_ll_temac_hostif_get(dev, 0, EMAC_PHY_ID, 10);
    if((result & 0x0800) == 0x0800) {
        xps_ll_temac_indirect_set(dev, 0, EMMC, 0x80000000);
        printk("1000BASE-T/FD\n");
        return;
    }
    result = xps_ll_temac_hostif_get(dev, 0, EMAC_PHY_ID, 5);
    if((result & 0x0100) == 0x0100) {
        xps_ll_temac_indirect_set(dev, 0, EMMC, 0x40000000);
        printk("100BASE-T/FD\n");
    } else if((result & 0x0040) == 0x0040) {
        xps_ll_temac_indirect_set(dev, 0, EMMC, 0x00000000);
        printk("10BASE-T/FD\n");
    } else {
        printk("Half Duplex not supported\n");
    }
}

static int xps_ll_temac_set_address(struct net_device *dev, void *p)
{
    struct sockaddr *sa = p;

    memcpy(dev->dev_addr, sa->sa_data, ETH_ALEN);

    xps_ll_temac_indirect_set(dev, 0, UAW0, (dev->dev_addr[0] & 
0x000000ff) |
        ((dev->dev_addr[1] << 8) & 0x0000ff00) |
        ((dev->dev_addr[2] << 16)& 0x00ff0000) |
        ((dev->dev_addr[3] << 24) & 0xff000000));
    xps_ll_temac_indirect_set(dev, 0, UAW1, (dev->dev_addr[4] & 
0x000000ff) |
        ((dev->dev_addr[5] << 8) & 0x0000ff00));

    return 0;
}

static void __set_rx_mode (struct net_device *dev)
{
    unsigned long waddr_msw, waddr_lsw;
    int i;

    if(dev->flags & IFF_PROMISC) {
        printk(KERN_NOTICE "%s: Promiscuos mode enabled.\n", dev->name);

        xps_ll_temac_indirect_set(dev, 0, AFM, 0x80000000);
    }  else {
        struct dev_mc_list *mclist;
        for(i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
            i++, mclist = mclist->next) {

            if(i >= MULTICAST_CAM_TABLE_NUM) break;
            waddr_msw = ((mclist->dmi_addr[3] << 24) | (mclist->dmi_
addr[2] << 16) |
                (mclist->dmi_addr[1] << 8) | mclist->dmi_addr[0]);
            xps_ll_temac_indirect_set(dev, 0, MAW0, waddr_msw);
            waddr_lsw = ((mclist->dmi_addr[5] << 8) | mclist->dmi_addr[4]
);
            waddr_lsw |= (i << 16);
            xps_ll_temac_indirect_set(dev, 0, MAW1, waddr_lsw);
        }
    }
}

static void xps_ll_temac_set_rx_mode (struct net_device *dev)
{
    spin_lock(&dev_lock);
    __set_rx_mode(dev);
    spin_unlock(&dev_lock);
}

static int xps_ll_temac_xmit_done(struct net_device *dev)
{
    struct net_local *lp = (struct net_local *)dev->priv;
    cdmac_bd *cur_p;
    unsigned int stat = 0;
    unsigned int flags;

    spin_lock_irqsave(&xmt_lock, flags);

    cur_p = &cdmac_tx_bd_virt_p->tx_bd[cur_tx_bd];
    stat = cur_p->app0;

    while(stat & BDSTAT_COMPLETED_MASK) {
        pci_unmap_single(NULL, (unsigned long)cur_p->phys_buf_p,
            cur_p->buf_len, PCI_DMA_TODEVICE);
        if (cur_p->app4)
            dev_kfree_skb_irq((struct sk_buff *)cur_p->app4);
        cur_p->app0 = 0;

        lp->stats.tx_packets++;
        lp->stats.tx_bytes += cur_p->buf_len;

        cur_tx_bd++;
        if (cur_tx_bd >= TX_BD_NUM) cur_tx_bd = 0;

        cur_p = &cdmac_tx_bd_virt_p->tx_bd[cur_tx_bd];
        stat = cur_p->app0;
    }

    spin_unlock_irqrestore(&xmt_lock, flags);

    if(netif_queue_stopped(dev)) {
        netif_wake_queue(dev);
    }
}

static int xps_ll_temac_xmit(struct sk_buff *skb, struct net_device *dev)
{
    struct net_local *lp = (struct net_local *)dev->priv;
    cdmac_bd *cur_p, *start_p, *tail_p;
    int i;
    unsigned long num_frag;
    skb_frag_t *frag;

    spin_lock(&xmt_lock);

    num_frag = skb_shinfo(skb)->nr_frags;
    frag = &skb_shinfo(skb)->frags[0];
    start_p = &cdmac_tx_bd_phys_p->tx_bd[tail_tx_bd];
    cur_p = &cdmac_tx_bd_virt_p->tx_bd[tail_tx_bd];

    if(cur_p->app0 & BDSTAT_COMPLETED_MASK) {
        if(!netif_queue_stopped(dev)) {
            netif_stop_queue(dev);
            spin_unlock(&xmt_lock);
            return NETDEV_TX_BUSY;
        }
        return NETDEV_TX_BUSY;
    }

    cur_p->app0 = 0;
    if(skb->ip_summed == CHECKSUM_PARTIAL) {
        const struct iphdr *ip = skb->nh.iph;
        int length, start, insert, headlen;

        switch(ip->protocol) {
        case IPPROTO_TCP:
            start = sizeof(struct iphdr) + ETH_HLEN;
            insert = sizeof(struct iphdr) + ETH_HLEN + 16;
            length = ip->tot_len - sizeof(struct iphdr);
            headlen = ETH_HLEN + sizeof(struct iphdr) + sizeof(struct 
tcphdr);
            break;
        case IPPROTO_UDP:
            start = sizeof(struct iphdr) + ETH_HLEN;
            insert = sizeof(struct iphdr) + ETH_HLEN + 6;
            length = ip->tot_len - sizeof(struct iphdr);
            headlen = ETH_HLEN + sizeof(struct iphdr) + sizeof(struct 
udphdr);
            break;
        default:
            break;
        }
        cur_p->app1 = ((start << 16) | insert);
        cur_p->app2 = csum_tcpudp_magic(ip->saddr, ip->daddr, 
            length, ip->protocol, 0);
        skb->data[insert] = 0;
        skb->data[insert + 1] = 0;
    }
    cur_p->app0 |= BDSTAT_SOP_MASK;
    cur_p->buf_len = skb_headlen(skb);
    cur_p->phys_buf_p = (unsigned char *)pci_map_single(NULL, skb->data, 
skb->len, PCI_DMA_TODEVICE);
    cur_p->app4 = (unsigned long)skb;

    for(i = 0;i < num_frag;i++) {
        tail_tx_bd++;
        if (tail_tx_bd >= TX_BD_NUM) tail_tx_bd = 0;

        cur_p = &cdmac_tx_bd_virt_p->tx_bd[tail_tx_bd];
        cur_p->phys_buf_p = (unsigned char *)pci_map_single(NULL,
            (void *)page_address(frag->page) + frag->page_offset, frag->
size, PCI_DMA_TODEVICE);
        cur_p->buf_len = frag->size;
        cur_p->app0 = 0;
        frag++;
    }
    cur_p->app0 |= BDSTAT_EOP_MASK;

    tail_p = &cdmac_tx_bd_phys_p->tx_bd[tail_tx_bd];
    tail_tx_bd++;
    if (tail_tx_bd >= TX_BD_NUM) tail_tx_bd = 0;

    if(!(sdma_reg_read(lp, TX_CHNL_STS) & 2)) {
        sdma_reg_write(lp, TX_CURDESC_PTR, start_p);
        sdma_reg_write(lp, TX_TAILDESC_PTR, tail_p);    // DMA start 
    } else {
    }

    spin_unlock(&xmt_lock);

    return 0;
}

static int xps_ll_temac_poll(struct net_device *dev, int *budget)
{
    struct net_local *lp = (struct net_local *)dev->priv;
    struct sk_buff *skb, *new_skb;
    unsigned int bdstat;
    unsigned long align;
    cdmac_bd *cur_p, *tail_p;
    int length;
    unsigned long skb_vaddr;
    unsigned int flags;

    tail_p = &cdmac_rx_bd_phys_p->rx_bd[cur_rx_bd];
    cur_p = &cdmac_rx_bd_virt_p->rx_bd[cur_rx_bd];

    bdstat = cur_p->app0;
    while((bdstat & BDSTAT_COMPLETED_MASK) && *budget > 0) {

        skb = rx_skb[cur_rx_bd];
        length = cur_p->app4;

        skb_vaddr = virt_to_bus(skb->data);
        pci_unmap_single(NULL, skb_vaddr, length, PCI_DMA_FROMDEVICE);

        skb_put(skb, length);
        skb->dev = dev;
        skb->protocol = eth_type_trans(skb, dev);
        skb->ip_summed = CHECKSUM_NONE;

        netif_receive_skb(skb);
        dev->last_rx = jiffies;

        lp->stats.rx_packets++;
        lp->stats.rx_bytes += length;

        new_skb = alloc_skb(XEM_MAX_FRAME_SIZE + ALIGNMENT, GFP_ATOMIC);
        if(new_skb == 0) {
            printk("no memory for new sk_buff\n");
            spin_unlock_irqrestore(&rcv_lock, flags);
            return -ENOMEM;
        }

        align = BUFFER_ALIGN(new_skb->data);
        if(align) skb_reserve(new_skb, align);

        cur_p->app0 = BDSTAT_INT_ON_END_MASK;
        cur_p->phys_buf_p = (unsigned char *)
                pci_map_single(NULL, new_skb->data,
                           XEM_MAX_FRAME_SIZE,
                           PCI_DMA_FROMDEVICE);
        cur_p->buf_len    = XEM_MAX_FRAME_SIZE;
        rx_skb[cur_rx_bd] = new_skb;

        cur_rx_bd++;
        if(cur_rx_bd >= RX_BD_NUM) cur_rx_bd = 0;

        cur_p = &cdmac_rx_bd_virt_p->rx_bd[cur_rx_bd];
        bdstat = cur_p->app0 ;
        (*budget)--;
    }

    netif_rx_complete(dev);
    sdma_reg_write(lp, RX_CHNL_CTRL,
        sdma_reg_read(lp, RX_CHNL_CTRL) | SDMA_MASTER_IRQ);
    sdma_reg_write(lp, RX_TAILDESC_PTR, tail_p);

    return 0;
}

static void xps_ll_temac_recv(struct net_device *dev)
{
    struct net_local *lp = (struct net_local *)dev->priv;
    struct sk_buff *skb, *new_skb;
    unsigned int bdstat;
    unsigned long align;
    cdmac_bd *cur_p, *tail_p;
    int length;
    unsigned long skb_vaddr;
    unsigned int flags;

    spin_lock_irqsave(&rcv_lock, flags);

    tail_p = &cdmac_rx_bd_phys_p->rx_bd[cur_rx_bd];
    cur_p = &cdmac_rx_bd_virt_p->rx_bd[cur_rx_bd];

    bdstat = cur_p->app0;
    while((bdstat & BDSTAT_COMPLETED_MASK)) {

        skb = rx_skb[cur_rx_bd];
        length = cur_p->app4;

        skb_vaddr = virt_to_bus(skb->data);
        pci_unmap_single(NULL, skb_vaddr, length, PCI_DMA_FROMDEVICE);

        skb_put(skb, length);
        skb->dev = dev;
        skb->protocol = eth_type_trans(skb, dev);
        skb->ip_summed = CHECKSUM_NONE;

        netif_rx(skb);

        lp->stats.rx_packets++;
        lp->stats.rx_bytes += length;

        new_skb = alloc_skb(XEM_MAX_FRAME_SIZE + ALIGNMENT, GFP_ATOMIC);
        if(new_skb == 0) {
            printk("no memory for new sk_buff\n");
            spin_unlock_irqrestore(&rcv_lock, flags);
            return;
        }

        align = BUFFER_ALIGN(new_skb->data);
        if(align) skb_reserve(new_skb, align);

        cur_p->app0 = BDSTAT_INT_ON_END_MASK;
        cur_p->phys_buf_p = (unsigned char *)
                    pci_map_single(NULL, new_skb->data,
                               XEM_MAX_FRAME_SIZE,
                               PCI_DMA_FROMDEVICE);
        cur_p->buf_len    = XEM_MAX_FRAME_SIZE;
        rx_skb[cur_rx_bd] = new_skb;

        cur_rx_bd++;
        if(cur_rx_bd >= RX_BD_NUM) cur_rx_bd = 0;

        cur_p = &cdmac_rx_bd_virt_p->rx_bd[cur_rx_bd];
        bdstat = cur_p->app0;
    }
    sdma_reg_write(lp, RX_TAILDESC_PTR, tail_p);

    spin_unlock_irqrestore(&rcv_lock, flags);
}

static irqreturn_t
xps_ll_temac_tx_int(int irq, void * dev_id, struct pt_regs *regs)
{
    unsigned int status;
    struct net_device *dev = (struct net_device *)dev_id;
    struct net_local *lp = (struct net_local *)dev->priv;

    status = sdma_reg_read(lp, TX_IRQ_REG);
    sdma_reg_write(lp, TX_IRQ_REG, status);

    if(status & 3) xps_ll_temac_xmit_done(dev);
    if(status & 0x080) printk("DMA error 0x%x\n", status);

    return IRQ_HANDLED;
}

static irqreturn_t
xps_ll_temac_rx_int(int irq, void * dev_id, struct pt_regs *regs)
{
    unsigned int status;
    struct net_device *dev = (struct net_device *)dev_id;
    struct net_local *lp = (struct net_local *)dev->priv;

    status = sdma_reg_read(lp, RX_IRQ_REG);
    sdma_reg_write(lp, RX_IRQ_REG, status);

#ifdef XPS_LL_TEMAC_NAPI
    if(status & 1) {
        if(likely(netif_rx_schedule_prep(dev))) {
            sdma_reg_write(lp, RX_CHNL_CTRL,
                sdma_reg_read(lp, RX_CHNL_CTRL) & ~SDMA_MASTER_IRQ);
            __netif_rx_schedule(dev);
        }
    }
#else
    if(status & 3) xps_ll_temac_recv(dev);
#endif

    return IRQ_HANDLED;
}

static void xps_ll_temac_netpoll(struct net_device *dev)
{
    //struct net_local *lp = (struct net_local *)dev->priv;

    disable_irq(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_TX_INTOUT_INTR);
    disable_irq(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_RX_INTOUT_INTR);

    xps_ll_temac_rx_int(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_RX_INTOUT_INTR, 
dev, 0);
    xps_ll_temac_tx_int(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_TX_INTOUT_INTR, 
dev, 0);

    enable_irq(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_TX_INTOUT_INTR);
    enable_irq(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_RX_INTOUT_INTR);
}

static struct net_device_stats *xps_ll_temac_get_stats(struct net_device 
*dev)
{
    return netdev_priv(dev);
}

static int xps_ll_temac_init_descriptor(void)
{
    struct sk_buff *skb;
    unsigned long align;
    int i;

    cdmac_tx_bd_virt_p = dma_alloc_coherent(NULL, sizeof(struct cdmac_
tx_bd_t),
        (dma_addr_t *)&cdmac_tx_bd_phys_p, GFP_KERNEL);
    cdmac_rx_bd_virt_p = dma_alloc_coherent(NULL, sizeof(struct cdmac_
rx_bd_t),
        (dma_addr_t *)&cdmac_rx_bd_phys_p, GFP_KERNEL);

    for(i = 0;i < TX_BD_NUM;i++) {
        memset((char *)&cdmac_tx_bd_virt_p->tx_bd[i], 0, sizeof(struct 
cdmac_bd_t));
        if(i == (TX_BD_NUM - 1)) {
            cdmac_tx_bd_virt_p->tx_bd[i].next_p =
                &cdmac_tx_bd_phys_p->tx_bd[0];
        } else {
            cdmac_tx_bd_virt_p->tx_bd[i].next_p =
                &cdmac_tx_bd_phys_p->tx_bd[i + 1];
        }
    }
    for(i = 0;i < RX_BD_NUM;i++) {
        memset((char *)&cdmac_rx_bd_virt_p->rx_bd[i], 0, sizeof(struct 
cdmac_bd_t));
        if(i == (RX_BD_NUM - 1)) {
            cdmac_rx_bd_virt_p->rx_bd[i].next_p =
                &cdmac_rx_bd_phys_p->rx_bd[0];
        } else {
            cdmac_rx_bd_virt_p->rx_bd[i].next_p =
                &cdmac_rx_bd_phys_p->rx_bd[i + 1];
        }
        skb = alloc_skb(XEM_MAX_FRAME_SIZE + ALIGNMENT, GFP_ATOMIC);
        if(skb == 0) {
            printk("alloc_skb error %d\n", i);
            return -1;
        }
        rx_skb[i] = skb;
        align = BUFFER_ALIGN(skb->data);
        if(align) skb_reserve(skb, align);

        cdmac_rx_bd_virt_p->rx_bd[i].phys_buf_p =
            (unsigned char *)pci_map_single(NULL,
                skb->data, XEM_MAX_FRAME_SIZE,
                PCI_DMA_FROMDEVICE);
        cdmac_rx_bd_virt_p->rx_bd[i].buf_len = XEM_MAX_FRAME_SIZE;
        cdmac_rx_bd_virt_p->rx_bd[i].app0 = BDSTAT_INT_ON_END_MASK;
    }

    return 0;
}

static int xps_ll_temac_changemtu(struct net_device *dev, int newmtu)
{
        printk("[xilinx_enet]new MTU %d\n", newmtu);
        dev->mtu = newmtu;

        return 0;
}

static int xps_ll_temac_open(struct net_device *dev)
{

    return 0;
}

static int xps_ll_temac_close(struct net_device *dev)
{

    return 0;
}

static struct net_device **xps_ll_temacs;

static int __init xps_ll_temac_init_one(int index)
{
    struct net_device *dev = alloc_etherdev(sizeof(struct net_local));
    struct net_local *lp;
    int err = 0;

    if (!dev) return -ENOMEM;

    sprintf(dev->name, "eth%d", index);

    /* Initialize the device structure. */
    dev->get_stats = xps_ll_temac_get_stats;
    dev->hard_start_xmit = xps_ll_temac_xmit;
    dev->open = xps_ll_temac_open;
    dev->stop = xps_ll_temac_close;
#ifdef XPS_LL_TEMAC_NAPI
    dev->poll = &xps_ll_temac_poll;
#endif
    dev->weight = 64;
    dev->set_multicast_list = &xps_ll_temac_set_rx_mode;
    dev->set_mac_address = xps_ll_temac_set_address;
    dev->poll_controller = xps_ll_temac_netpoll;

    SET_MODULE_OWNER(dev);
#if 1
//  dev->features = NETIF_F_SG | NETIF_F_FRAGLIST
//      | NETIF_F_IP_CSUM;
    dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
#else
    dev->features = NETIF_F_SG | NETIF_F_FRAGLIST
        | NETIF_F_TSO | NETIF_F_IP_CSUM;
#endif

    ether_setup(dev);

    lp = (struct net_local *)dev->priv;
    memset(lp, 0, sizeof(struct net_local));
    lp->index = index;

    lp->next_dev = dev_list;
    lp->sdma_reg_base = ioremap(S_DMA_CTRL_BASEADDR, 128);
    lp->temac_reg_base = ioremap(XPS_LLTEMAC_BASEADDR, 128);

    dev_list = dev;

    dev->tx_queue_len = 0;
    dev->change_mtu = xps_ll_temac_changemtu;

    sdma_reg_write(lp, DMA_CONTROL_REG, 1);

    printk(KERN_INFO "%s: Xilinx Embedded Tri-Mode Ethernet MAC\n", dev-
>name);
    xps_ll_temac_init_descriptor();

    dev->dev_addr[0] = 0x00;
    dev->dev_addr[1] = 0x80;
    dev->dev_addr[2] = 0x49;
    dev->dev_addr[3] = 0x00;
    dev->dev_addr[4] = 0x00;
    dev->dev_addr[5] = 0x00;

    request_irq(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_TX_INTOUT_INTR,
        &xps_ll_temac_tx_int, 0, dev->name, dev);
    request_irq(XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_RX_INTOUT_INTR,
        &xps_ll_temac_rx_int, 0, dev->name, dev);

    xps_ll_temac_indirect_set(dev, 0, MC, MDIO_ENABLE_MASK | MDIO_CLOCK_
DIV_100MHz);

    xps_ll_temac_indirect_set(dev, 0, RCW1, 0x10000000);    // Enable 
Receiver
    xps_ll_temac_indirect_set(dev, 0, TC, 0x10000000);  // Enable 
Transmitter
    xps_ll_temac_indirect_set(dev, 0, EMMC, 0x84000000);

    xps_ll_temac_indirect_set(dev, 0, UAW0, (dev->dev_addr[0] & 
0x000000ff) |
        ((dev->dev_addr[1] << 8) & 0x0000ff00) |
        ((dev->dev_addr[2] << 16)& 0x00ff0000) |
        ((dev->dev_addr[3] << 24) & 0xff000000));
    xps_ll_temac_indirect_set(dev, 0, UAW1, (dev->dev_addr[4] & 
0x000000ff) |
        ((dev->dev_addr[5] << 8) & 0x0000ff00));

    xps_ll_temac_indirect_set(dev, 0, AFM, 0x00000000);

    xps_ll_temac_phy_ctrl(dev);

    sdma_reg_write(lp, TX_CHNL_CTRL, 0x10220483);
    //sdma_reg_write(lp, TX_CHNL_CTRL, 0x00100483);
    sdma_reg_write(lp, RX_CHNL_CTRL, 0xff010283);

    sdma_reg_write(lp, RX_CURDESC_PTR, (unsigned int)&cdmac_rx_bd_phys_
p->rx_bd[0]);
    sdma_reg_write(lp, RX_TAILDESC_PTR, (unsigned int)&cdmac_rx_bd_phys_
p->rx_bd[RX_BD_NUM - 1]);

    if ((err = register_netdev(dev))) {
        free_netdev(dev);
        dev = NULL;
    } else {
        xps_ll_temacs[index] = dev;
    }

    return 0;
}

static void xps_ll_temac_free_one(int index)
{
    unregister_netdev(xps_ll_temacs[index]);
    free_netdev(xps_ll_temacs[index]);
}

static int __init xps_ll_temac_init_module(void)
{
    int err = 0;

    xps_ll_temacs = kmalloc(sizeof(void *), GFP_KERNEL);

    if (!xps_ll_temacs) return -ENOMEM;

    spin_lock_init(&dev_lock);
    spin_lock_init(&rcv_lock);
    spin_lock_init(&xmt_lock);

    if((err = xps_ll_temac_init_one(0))) xps_ll_temac_free_one(0);

    return err;
}

static void __exit xps_ll_temac_cleanup_module(void)
{
    xps_ll_temac_free_one(0);
    kfree(xps_ll_temacs);
}

module_init(xps_ll_temac_init_module);
module_exit(xps_ll_temac_cleanup_module);
MODULE_LICENSE("GPL");


> Thanks,
> 
>     I have alot of work to do on our stuff, I might as well see if I 
can
> move to the powerpc tree at the same time.
> 
>     BTW is there even the beginings of a non-xilinx lltemac driver out
> there ? There were hints on the list, but I have not seen anything.
> 
>     I would be happy to help advance the ball on anything anyone has
> started.
> 
>    
> 
> Grant Likely wrote:
> > On Sun, Apr 20, 2008 at 2:31 PM, David H. Lynch Jr. <dhlii@dlasys.net
> wrote:
> >   
> >> Thanks.
> >>
> >>     I am running linus's 2.6.25-rc9, but I can pull the Xilinx tree 
or
> >>  yours - when your server is up.
> >>
> >>     I can not find any Xilinx powerpc configs in arch/powerpc/
config
> >>     Do I just need to do a
> >>     make ARCH=powerpc menuconfig and create one from scratch ?
> >>     
> >
> > That's right; I haven't merged any defconfigs.  Roll your own.
> >
> >   
> >>     Is simpleboot in your tree or the xilinx tree, if  can not find 
it
> >>  in Linus's ?
> >>     
> >
> > If you want to use the "simpleboot" wrapper; then you'll need to 
pull
> > paulus' tree (Linus hasn't yet pulled his tree; but he probably will
> > any moment now).
> >
> > Cheers,
> > g.
> >
> >   
> 
> 
> -- 
> Dave Lynch                            DLA Systems
> Software Development:                          Embedded Linux
> 717.627.3770         dhlii@dlasys.net       http://www.dlasys.net
> fax: 1.253.369.9244                      Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies 
too numerous to list.
> 
> "Any intelligent fool can make things bigger and more complex... It 
takes a touch of genius - and a lot of courage to move in the opposite 
direction."
> Albert Einstein
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
※ ４月から所属・部署が変更になりました
------------------------------------------------------------------
柏木良夫
株式会社日新システムズ 東日本営業部

本      社 〒600-8482 京都市下京区堀川通四条下ル東側 堀川四条ビル
TEL 075-344-7977 FAX 075-344-7887
東京事務所 〒101-0024 東京都千代田区神田和泉町1番地 神田和泉町ビル
TEL 03-5825-2081 FAX 03-5821-1259
E-Mail kashiwagi@co-nss.co.jp HTTP http://www.co-nss.co.jp/
------------------------------------------------------------------
