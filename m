Message-ID: <002501c441fa$579fb3d0$e100a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: "HoJin" <jhfami@yahoo.co.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <40B295BD.9040500@yahoo.co.kr>
Subject: Re: HDLC driver for MPC8xx SCC
Date: Tue, 25 May 2004 09:48:13 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0022_01C4423D.65804580"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0022_01C4423D.65804580
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

http://qslinux.org/docs/snmc/hdlc/

check this


----- Original Message -----
From: "HoJin" <jhfami@yahoo.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, May 25, 2004 8:39 AM
Subject: HDLC driver for MPC8xx SCC


>
> Hi,
> I'm working on my custom mpc860 board, and kernel 2.4. I want to
> implement sync. HDLC driver. I have found old HDLC driver for mpc860 but
> it is not sync and doesn't works well.
>
> Are there any nice driver for mpc860 HDLC driver?
> Any helps and advices are welcome. :)
>
> --
> HoJin, Yu
>
> jhfami@yahoo.co.kr
>
>
>

------=_NextPart_000_0022_01C4423D.65804580
Content-Type: application/octet-stream;
	name="hdlcppp.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hdlcppp.c"

// $Header: /projects/cvsroot/snmc/qslinux/drivers/net/hdlcppp.c,v 1.2 =
2000/08/10 15:56:07 dnevil Exp $=0A=
=0A=
// Copyright 2000 SNMC=0A=
// Simple Network Magic Corporation=0A=
		=0A=
=0A=
// Synchronous (HDLC) PPP Driver=0A=
// Author: Daris A Nevil=0A=
=0A=
// This driver provides RX/TX functionality for HDLC frames=0A=
// on the QS850 SCC controller.  Each SCC is configured=0A=
// appropriately for PPP packet transport according to RFC 1662.=0A=
=0A=
// $Log: hdlcppp.c,v $=0A=
// Revision 1.2  2000/08/10 15:56:07  dnevil=0A=
// Removed compiler warnings.=0A=
//=0A=
// Revision 1.1.1.1  2000/08/10 14:34:25  dnevil=0A=
// New files.=0A=
//=0A=
=0A=
// Standard includes=0A=
=0A=
// Local includes=0A=
=0A=
#define HAVE_CHANGE_MTU=0A=
=0A=
#include <linux/types.h>=0A=
#include <linux/module.h>=0A=
#include <linux/ioctl.h>=0A=
#include <linux/netdevice.h>=0A=
#include <linux/kerneld.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/ioport.h>=0A=
#include <asm/uaccess.h>=0A=
#include <asm/processor.h>=0A=
#include <asm/system.h>=0A=
#include <asm/semaphore.h>=0A=
#include <asm/8xx_immap.h>=0A=
#include <asm/mpc8xx.h>=0A=
#include <asm/commproc.h>=0A=
#include <asm/qspin.h>=0A=
#include <linux/syncppp.h>=0A=
#include <asm/cpm.h>=0A=
#include <asm/hdlcppp.h>=0A=
=0A=
=0A=
//#define HDLC_PPP_DEBUG=0A=
=0A=
#ifdef HDLC_PPP_DEBUG=0A=
#define DEBUG(args...) printk(args)=0A=
#else=0A=
#define DEBUG(args...)=0A=
#endif=0A=
=0A=
#define RX_RING_SIZE 8=0A=
#define TX_RING_SIZE 8=0A=
=0A=
// Maximum size for RX Buffers=0A=
// Must be a multiple of 4=0A=
#define MAX_RX_BUFF_SIZE 1560 // 390*4=0A=
=0A=
// This value must be <=3D MAX_RX_BUFF_SIZE=0A=
#define HDLC_PPP_MTU (1550+8)=0A=
=0A=
#define NUM_SCCS	4	// Number of SCC Channels=0A=
#define SCC_PARAM_SIZE	0x100	// SCC Parameter RAM size=0A=
=0A=
#define SYNC_PPP_MODULE	"syncppp"=0A=
=0A=
// Defines number of RX Frames before an interrupt is generated=0A=
#define RX_FRAME_THRESHOLD 1=0A=
=0A=
// HDLC Addresses and Masks=0A=
#define HDLC_C_MASK	0xF0B8	// CRC Constant=0A=
#define HDLC_C_PRES	0xFFFF	// CRC Preset=0A=
#define HDLC_ADDR_MASK	0x00FF	// Address Mask (8-bit)=0A=
#define HDLC_AS_ADDR	0x00FF	// All-Stations Address=0A=
#define HDLC_CM_ADDR	0x008F	// Cisco Multicast Address=0A=
#define HDLC_CU_ADDR	0x000F	// Cisco Unicast Address=0A=
=0A=
#define TX_TIMEOUT	200	// Ticks=0A=
=0A=
//-------------------------------------------------------------------=0A=
// Local structures=0A=
=0A=
typedef struct {=0A=
=0A=
	// SCC device number (1-4)=0A=
	int			scc_num;=0A=
	int			scc_param_index;=0A=
=0A=
	// Device structure for SYNC PPP=0A=
	struct ppp_device	pppdev;=0A=
=0A=
	// Device Statistics=0A=
	struct net_device_stats	stats;=0A=
=0A=
	// Buffer descriptors=0A=
	// TX Buffers and descriptors=0A=
	volatile cbd_t*	tx_bd_base; // Start of TX Buffer Descriptors=0A=
	volatile cbd_t*	tx_bd[TX_RING_SIZE];=0A=
	int		tx_head;=0A=
	struct sk_buff*	tx_skbuff[TX_RING_SIZE];=0A=
=0A=
	// RX Buffers and descriptors=0A=
	volatile cbd_t*	rx_bd_base; // Start of RX Buffer Descriptors=0A=
	volatile cbd_t*	rx_bd[RX_RING_SIZE];=0A=
	int		rx_tail;=0A=
	struct sk_buff*	rx_skbuff[RX_RING_SIZE];=0A=
=0A=
	// Bottom Half task queue=0A=
	struct tq_struct	rx_bh_tq;=0A=
	struct tq_struct	tx_bh_tq;=0A=
=0A=
	} hdlc_channel_t;=0A=
=0A=
typedef struct=0A=
	{=0A=
	char*		name;=0A=
	uint		pram_index;=0A=
	ushort		chan_cmd;=0A=
	ushort		irq_vector;=0A=
	} SCC_Params_t;=0A=
=0A=
//-------------------------------------------------------------------=0A=
// Function Prototypes=0A=
void sync_ppp_init(void);=0A=
#ifdef MODULE=0A=
int init_module(void);=0A=
#else=0A=
int hdlc_ppp_init(void);=0A=
#endif=0A=
#ifdef MODULE=0A=
void cleanup_module(void);=0A=
#else=0A=
void hdlc_ppp_cleanup_module(void);=0A=
#endif=0A=
static void hdlc_ppp_interrupt(void *dev_id);=0A=
static int hdlc_ppp_hard_start_xmit(struct sk_buff* skb, struct device* =
dev);=0A=
static struct net_device_stats* hdlc_ppp_get_stats(struct device* dev);=0A=
static int hdlc_ppp_ioctl(struct device* dev, struct ifreq* ifr, int =
cmd);=0A=
static int hdlc_ppp_change_mtu(struct device* dev, int new_mtu);=0A=
static int hdlc_ppp_stop(struct device* dev);=0A=
static int hdlc_ppp_alloc_rx_ring(struct device* dev);=0A=
static struct sk_buff* hdlc_ppp_alloc_skb(int mtu);=0A=
static void hdlc_ppp_restart_rx(struct device* dev);=0A=
static void hdlc_ppp_restart_tx(struct device* dev);=0A=
static int hdlc_ppp_init_local(struct device* dev);=0A=
static int hdlc_ppp_open(struct device* dev);=0A=
static void hdlc_ppp_tx_bh(void* dev_id);=0A=
static void hdlc_ppp_rx_bh(void* dev_id);=0A=
=0A=
//-------------------------------------------------------------------=0A=
// Global initializers=0A=
=0A=
#define PPP_HDLC_CHANNELS	4=0A=
=0A=
static hdlc_channel_t MyChan[PPP_HDLC_CHANNELS];=0A=
=0A=
static SCC_Params_t SCC_Params[PPP_HDLC_CHANNELS] =3D {=0A=
	{"hdlcppp1", PROFF_SCC1, CPM_CR_CH_SCC1, CPMVEC_SCC1},=0A=
	{"hdlcppp2", PROFF_SCC2, CPM_CR_CH_SCC2, CPMVEC_SCC2},=0A=
	{"hdlcppp3", PROFF_SCC3, CPM_CR_CH_SCC3, CPMVEC_SCC3},=0A=
	{"hdlcppp4", PROFF_SCC4, CPM_CR_CH_SCC4, CPMVEC_SCC4},=0A=
};=0A=
=0A=
// Module Configuration Parameters=0A=
MODULE_AUTHOR("dnevil@snmc.com");=0A=
MODULE_DESCRIPTION("SCC HDLC Driver for PPP");=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// init_module()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	None.=0A=
//=0A=
// Initialize the SCC port for operation in HDLC mode suitable=0A=
// for transport of PPP according to RFC 1662.=0A=
=0A=
#ifdef MODULE=0A=
int init_module(void)=0A=
#else=0A=
int hdlc_ppp_init(void)=0A=
#endif=0A=
{=0A=
	int i;=0A=
	int result;=0A=
	struct device* dev;=0A=
	volatile cpm8xx_t* cp =3D cpmp;=0A=
=0A=
	DEBUG("hdlc_ppp: init_module()\n");=0A=
	printk(KERN_INFO "SCC HDLC Driver for PPP v1.0\n");=0A=
	printk(KERN_INFO "(c) Copyright 2000, Simple Network Magic =
Corporation\n");=0A=
=0A=
#if 0=0A=
	// Request the SYNC PPP Module=0A=
	result =3D request_module(SYNC_PPP_MODULE);=0A=
	if (result)=0A=
		return(result);=0A=
#endif=0A=
=0A=
	for (i =3D 0; i < PPP_HDLC_CHANNELS; ++i)=0A=
		{=0A=
		__clear_user(&MyChan[i], sizeof MyChan[0]);=0A=
=0A=
		// Save the SCC Channel number=0A=
		MyChan[i].scc_num =3D i+1;=0A=
		MyChan[i].scc_param_index =3D i;=0A=
=0A=
		// Attach the SYNC PPP driver to this device=0A=
		sppp_attach(&MyChan[i].pppdev);=0A=
		dev =3D &MyChan[i].pppdev.dev;=0A=
=0A=
		// Get pointer to base of SCC control registers=0A=
		// (index, not number)=0A=
		dev->base_addr =3D (unsigned long)&cp->cp_scc[i];=0A=
=0A=
		// Get beginning of my SCC's Parameter Ram=0A=
		dev->mem_start =3D (unsigned long)&=0A=
			cp->cp_dparam[SCC_Params[i].pram_index];=0A=
=0A=
		// Get end of my SCC's Parameter Ram=0A=
		dev->mem_end =3D dev->mem_start + SCC_PARAM_SIZE - 1;=0A=
=0A=
		// Fill out the function pointers=0A=
		dev->name =3D SCC_Params[i].name;=0A=
		dev->init =3D hdlc_ppp_init_local;=0A=
		dev->open =3D hdlc_ppp_open;=0A=
		dev->stop =3D hdlc_ppp_stop;=0A=
//		dev->set_config =3D hdlc_ppp_set_config;=0A=
		dev->set_config =3D NULL;=0A=
		dev->hard_start_xmit =3D hdlc_ppp_hard_start_xmit;=0A=
		dev->get_stats =3D hdlc_ppp_get_stats;=0A=
		dev->set_multicast_list =3D NULL;=0A=
		dev->do_ioctl =3D hdlc_ppp_ioctl;=0A=
//		dev->neigh_setup =3D hdlc_ppp_neigh_setup;=0A=
		dev->set_mac_address =3D NULL;=0A=
		dev->change_mtu =3D hdlc_ppp_change_mtu;=0A=
		dev->rebuild_header =3D NULL;=0A=
		dev->priv =3D (void*)&MyChan[i];=0A=
=0A=
		// Register my device=0A=
		result =3D register_netdev(dev);=0A=
		if (result)=0A=
			{=0A=
			printk(KERN_WARNING "%s: register_netdev failed.\n",=0A=
				dev->name);=0A=
=0A=
			sppp_detach(&MyChan[i].pppdev.dev);=0A=
			return(result);=0A=
			}=0A=
		}=0A=
=0A=
	// Initialize the sync ppp layer=0A=
	sync_ppp_init();=0A=
=0A=
	// Success=0A=
	return(0);=0A=
}=0A=
=0A=
//--------------------------------------------------------------=0A=
// cleanup_module()=0A=
//=0A=
// Return:=0A=
//	None.=0A=
//=0A=
// Input Parameters:=0A=
//	None.=0A=
//=0A=
// Remove the device from the list of network devices.=0A=
// Return allocated resources back to the system pool.=0A=
=0A=
#ifdef MODULE=0A=
void cleanup_module(void)=0A=
#else=0A=
void hdlc_ppp_cleanup_module(void)=0A=
#endif=0A=
{=0A=
	int i;=0A=
=0A=
	DEBUG("hdlc_ppp: cleanup_module()\n");=0A=
=0A=
	for (i =3D 0; i < PPP_HDLC_CHANNELS; ++i)=0A=
		{=0A=
		// Detach the PPP Layer=0A=
		sppp_detach(&MyChan[i].pppdev.dev);=0A=
=0A=
		// Unregister the device=0A=
		// sys_delete_module() will check MOD_IN_USE=0A=
		unregister_netdev(&MyChan[i].pppdev.dev);=0A=
		}=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_init()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Initialize the SCC port for operation in HDLC mode suitable=0A=
// for transport of PPP according to RFC 1662.=0A=
=0A=
static int hdlc_ppp_init_local(struct device* dev)=0A=
{=0A=
	DEBUG("hdlc_ppp_init()\n");=0A=
=0A=
	// Initialize device driver buffers=0A=
	dev_init_buffers(dev);=0A=
=0A=
	// Success=0A=
	return(0);=0A=
}=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_open()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Open the device=0A=
=0A=
static int hdlc_ppp_open(struct device* dev)=0A=
{=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile cpm8xx_t* cp =3D cpmp;=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
	volatile scc_hdlc_t* hp =3D (scc_hdlc_t*)dev->mem_start;=0A=
	int i;=0A=
	int result;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_open()\n", dev->name);=0A=
=0A=
	// Disable rx & tx=0A=
	sccp->scc_gsmrl &=3D ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);=0A=
=0A=
	// Make sure the parameter RAM area is not already allocated=0A=
	result =3D check_region(dev->mem_start, SCC_PARAM_SIZE);=0A=
	if (result)=0A=
		return(result);=0A=
=0A=
	// Allocate the parameter RAM=0A=
	request_region(dev->mem_start, SCC_PARAM_SIZE, dev->name);=0A=
=0A=
	// Configure I/O Pins=0A=
	// This will be left to user code=0A=
=0A=
#if 0=0A=
	// Init the SI Clock Route Register (SICR) for SCC3=0A=
	// Connect SCC3 to NMSI=0A=
	// Transmit Clock (CLK3) =3D BRGO2=0A=
	// Receive Clock (CLK1) =3D QS850_PIN_A20=0A=
	cp->cp_sicr &=3D 0x0000FFFF;=0A=
	cp->cp_sicr |=3D 0x00210000;=0A=
#else=0A=
	// Init the SI Clock Route Register (SICR) for SCC3=0A=
	// Connect SCC3 to NMSI=0A=
	// Transmit Clock (CLK3) =3D QS850_PIN_A19=0A=
	// Receive Clock (CLK3) =3D QS850_PIN_A19=0A=
	cp->cp_sicr &=3D 0x0000FFFF;=0A=
	cp->cp_sicr |=3D 0x00360000;=0A=
#endif=0A=
=0A=
	// Allocate RX Buffer descriptors=0A=
	i =3D m8xx_cpm_dpalloc(sizeof(cbd_t) * RX_RING_SIZE);=0A=
	if (i =3D=3D CPM_DP_NOSPACE)=0A=
		{=0A=
		printk("hdlc_ppp: No more CPM DPRAM\n");=0A=
		result =3D -ENOMEM;=0A=
		goto fail_rx_dpram;=0A=
		}=0A=
=0A=
	hp->genscc.scc_rbase =3D i;=0A=
	chan->rx_bd_base =3D (cbd_t*)&cp->cp_dpmem[i];=0A=
=0A=
	// Allocate TX Buffer descriptors=0A=
	i =3D m8xx_cpm_dpalloc(sizeof(cbd_t) * TX_RING_SIZE);=0A=
	if (i =3D=3D CPM_DP_NOSPACE)=0A=
		{=0A=
		printk("hdlc_ppp: No more CPM DPRAM\n");=0A=
		result =3D -ENOMEM;=0A=
		goto fail_tx_dpram;=0A=
		}=0A=
=0A=
	hp->genscc.scc_tbase =3D i;=0A=
	chan->tx_bd_base =3D (cbd_t*)&cp->cp_dpmem[i];=0A=
=0A=
	// Init Function Code registers (Big Endian)=0A=
	hp->genscc.scc_rfcr =3D SCC_EB;=0A=
	hp->genscc.scc_tfcr =3D SCC_EB;=0A=
=0A=
	// Set the RX Buffer maximum size=0A=
	hp->genscc.scc_mrblr =3D MAX_RX_BUFF_SIZE;=0A=
=0A=
	// Set the MTU=0A=
	hp->mflr =3D HDLC_PPP_MTU;=0A=
=0A=
	// Set the CRC Constant and Preset registers=0A=
	hp->c_mask =3D HDLC_C_MASK;=0A=
	hp->c_pres =3D HDLC_C_PRES;=0A=
=0A=
	// Set the All-Stations Address (used for PPP)=0A=
	// Also set Cisco Multicast and Cisco Unicast addresses=0A=
	hp->hmask =3D HDLC_ADDR_MASK;=0A=
	hp->haddr1 =3D HDLC_AS_ADDR;=0A=
	hp->haddr2 =3D HDLC_CM_ADDR;=0A=
	hp->haddr3 =3D HDLC_CU_ADDR;=0A=
	hp->haddr4 =3D HDLC_AS_ADDR;=0A=
=0A=
	// Clear the pm counters=0A=
	hp->disfc =3D 0;=0A=
	hp->crcec =3D 0;=0A=
	hp->abtsc =3D 0;=0A=
	hp->nmarc =3D 0;=0A=
	hp->retrc =3D 0;=0A=
=0A=
	// Set the RX Frame Threshold=0A=
	hp->rfthr =3D RX_FRAME_THRESHOLD;=0A=
=0A=
	// Set the Protocol Specific Mode Register=0A=
	// NOF =3D 0 (1 flag between adjacent frames)=0A=
	// CRC =3D 16-bit=0A=
	// No Retransmission=0A=
	// FSE =3D Normal=0A=
	// DRT =3D Normal=0A=
	// No HDLC Bus mode=0A=
	// BRM =3D Ignored=0A=
	// MFF =3D Normal=0A=
	sccp->scc_psmr =3D 0x0000;=0A=
=0A=
	// Disable All Interrupts for this SCC=0A=
	sccp->scc_sccm =3D 0x0000;=0A=
=0A=
	// Clear pending events=0A=
	sccp->scc_scce =3D 0xFFFF;=0A=
=0A=
	// Install my interrupt handler=0A=
	cpm_install_handler(SCC_Params[chan->scc_param_index].irq_vector,=0A=
		hdlc_ppp_interrupt, dev);=0A=
=0A=
	// Enable Interrupts for Transmit Error, Rx Received, and TXB=0A=
	sccp->scc_sccm =3D (SCCM_TXE | SCCM_RX | SCCM_RXF | SCCM_TX);=0A=
=0A=
	// Set the GSMR_H and GSMR_L registers=0A=
	sccp->scc_gsmrh =3D 0;=0A=
	sccp->scc_gsmrl =3D SCC_GSMRL_MODE_HDLC;=0A=
=0A=
	// Set the DSR register, just it case it has been modified=0A=
	// by another driver since reset=0A=
	sccp->scc_dsr =3D 0x7E7E;=0A=
=0A=
	// Allocate buffers for all RX Buf Descr=0A=
	if ((result =3D hdlc_ppp_alloc_rx_ring(dev)))=0A=
		goto fail_buffer;=0A=
=0A=
	// Initialize and start the Receiver and Transmitter=0A=
	hdlc_ppp_restart_rx(dev);=0A=
	hdlc_ppp_restart_tx(dev);=0A=
=0A=
	// Complete driver-required state info=0A=
	dev->start =3D 1;=0A=
	dev->tbusy =3D 0;=0A=
	dev->interrupt =3D 0;=0A=
=0A=
	// Adjust module count=0A=
	MOD_INC_USE_COUNT;=0A=
=0A=
	// Open the PPP driver=0A=
	result =3D sppp_open(dev);=0A=
	if (result)=0A=
		{=0A=
		printk(KERN_WARNING "%s: could not open Sync PPP device.\n",=0A=
			dev->name);=0A=
		MOD_DEC_USE_COUNT;=0A=
		goto fail_buffer;=0A=
		}=0A=
=0A=
	goto done;=0A=
=0A=
fail_buffer:=0A=
printk("fail_buffer\n");=0A=
=0A=
fail_rx_dpram:=0A=
printk("fail_rx_dpram\n");=0A=
	//m8xx_cpm_dpfree();=0A=
=0A=
fail_tx_dpram:=0A=
printk("fail_tx_dpram\n");=0A=
	//m8xx_cpm_dpfree();=0A=
=0A=
	release_region(dev->mem_start, SCC_PARAM_SIZE);=0A=
=0A=
done:=0A=
	// Done=0A=
	return(result);=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_stop()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Close the device and free all resources=0A=
=0A=
static int hdlc_ppp_stop(struct device* dev)=0A=
{=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
	volatile cpm8xx_t* cp =3D cpmp;=0A=
	int i;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_stop()\n", dev->name);=0A=
=0A=
	// Close the Sync PPP driver=0A=
	sppp_close(dev);=0A=
=0A=
	// Set the driver flags=0A=
	dev->tbusy =3D 1;=0A=
	dev->start =3D 0;=0A=
=0A=
	// Send a Stop Transmit command to the CPM=0A=
	cp->cp_cpcr =3D mk_cr_cmd(SCC_Params[chan->scc_param_index].chan_cmd,=0A=
		CPM_CR_STOP_TX) | CPM_CR_FLG;=0A=
	while (cp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
	// Disable rx & tx=0A=
	sccp->scc_gsmrl &=3D ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);=0A=
=0A=
	// Free the socket buffers associated with the RX buffer rings=0A=
	for (i =3D 0; i < RX_RING_SIZE; ++i)=0A=
		{=0A=
		// Free any allocated socket buffers=0A=
		if (chan->rx_skbuff[i])=0A=
			dev_kfree_skb(chan->rx_skbuff[i]);=0A=
=0A=
		chan->rx_skbuff[i] =3D 0;=0A=
		}=0A=
=0A=
	// Free the socket buffers associated with the TX buffer rings=0A=
	for (i =3D 0; i < TX_RING_SIZE; ++i)=0A=
		{=0A=
		// Free any allocated socket buffers=0A=
		if (chan->tx_skbuff[i])=0A=
			dev_kfree_skb(chan->tx_skbuff[i]);=0A=
=0A=
		chan->tx_skbuff[i] =3D 0;=0A=
		}=0A=
=0A=
	// Release the Parameter Ram associated with this channel=0A=
	release_region(dev->mem_start, SCC_PARAM_SIZE);=0A=
=0A=
	// Release RX & TX Buffer descriptors=0A=
	// m8xx_cpm_dpfree(hp->genscc.scc_rbase);=0A=
	// m8xx_cpm_dpfree(hp->genscc.scc_tbase);=0A=
=0A=
	// Disable All Interrupts for this SCC=0A=
	sccp->scc_sccm =3D 0x0000;=0A=
=0A=
	// Clear pending events=0A=
	sccp->scc_scce =3D 0xFFFF;=0A=
=0A=
=0A=
	// Uninstall the interrupt handler=0A=
//?=0A=
=0A=
	// Update statistics=0A=
//?=0A=
=0A=
	// Adjust module count=0A=
	MOD_DEC_USE_COUNT;=0A=
=0A=
	// Done=0A=
	return(0);=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_ioctl()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//	(IO) ifr - pointer to a structure for passing arguments=0A=
//	(I) cmd - ioctl() function specifier=0A=
//=0A=
// Perform special device control functions=0A=
=0A=
static int hdlc_ppp_ioctl(struct device* dev,=0A=
	struct ifreq* ifr, int cmd)=0A=
{=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_ioctl()\n", dev->name);=0A=
=0A=
	switch (cmd)=0A=
	{=0A=
	case HDLCPPPIOCNOLOOPECHO:=0A=
		sccp->scc_gsmrl &=3D ~(SCC_GSMRL_DIAG_LOOP | SCC_GSMRL_DIAG_ECHO);=0A=
		break;=0A=
=0A=
	case HDLCPPPIOCLOOP:=0A=
		sccp->scc_gsmrl &=3D ~SCC_GSMRL_DIAG_ECHO;=0A=
		sccp->scc_gsmrl |=3D SCC_GSMRL_DIAG_LOOP;=0A=
		break;=0A=
=0A=
	case HDLCPPPIOCECHO:=0A=
		sccp->scc_gsmrl &=3D ~SCC_GSMRL_DIAG_LOOP;=0A=
		sccp->scc_gsmrl |=3D SCC_GSMRL_DIAG_ECHO;=0A=
		break;=0A=
=0A=
	case HDLCPPPIOCLOOPECHO:=0A=
		sccp->scc_gsmrl |=3D SCC_GSMRL_DIAG_LOOP | SCC_GSMRL_DIAG_ECHO;=0A=
		break;=0A=
=0A=
	case HDLCPPPIOCTXCLKFALL:=0A=
		sccp->scc_gsmrl &=3D ~SCC_GSMRL_TCI;=0A=
		break;=0A=
=0A=
	case HDLCPPPIOCTXCLKRISE:=0A=
		sccp->scc_gsmrl |=3D SCC_GSMRL_TCI;=0A=
		break;=0A=
=0A=
	default:=0A=
		// Perform the Sync PPP ioctl() functions=0A=
		return(sppp_do_ioctl(dev, ifr, cmd));=0A=
	}=0A=
=0A=
	// Success=0A=
	return(0);=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_change_mtu()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//	(I) new_mtu - new size of the mtu=0A=
//=0A=
// Sets a new value for Maximum Transmission Unit (MTU).=0A=
=0A=
static int hdlc_ppp_change_mtu(struct device* dev, int new_mtu)=0A=
{=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile scc_hdlc_t* hp =3D (scc_hdlc_t*)dev->mem_start;=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
	int result;=0A=
	int i;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_change_mtu: new mtu=3D%d, old mtu=3D%d\n",=0A=
		dev->name, new_mtu, hp->mflr);=0A=
=0A=
	// Stop invalid changes=0A=
	if ((new_mtu < 32) || (new_mtu > 65534))=0A=
		return(-EINVAL);=0A=
=0A=
	// Disable the Receiver=0A=
	sccp->scc_gsmrl &=3D ~SCC_GSMRL_ENR;=0A=
=0A=
	// Set the MTU=0A=
	hp->mflr =3D new_mtu;=0A=
=0A=
	// Set the RX Buffer maximum size=0A=
	// Must be a multiple of 4 for the SCC in HDLC mode=0A=
	new_mtu /=3D 4;=0A=
	new_mtu +=3D 2; // Add a little cushion=0A=
	new_mtu *=3D 4;=0A=
	hp->genscc.scc_mrblr =3D new_mtu;=0A=
=0A=
	// Free the socket buffers associated with the RX buffer rings=0A=
	for (i =3D 0; i < RX_RING_SIZE; ++i)=0A=
		{=0A=
		// Free any allocated socket buffers=0A=
		if (chan->rx_skbuff[i])=0A=
			dev_kfree_skb(chan->rx_skbuff[i]);=0A=
=0A=
		chan->rx_skbuff[i] =3D 0;=0A=
		}=0A=
=0A=
	// Allocate new buffers=0A=
	if ((result =3D hdlc_ppp_alloc_rx_ring(dev)))=0A=
		return(result);=0A=
=0A=
	// Restart Receiver=0A=
	hdlc_ppp_restart_rx(dev);=0A=
=0A=
	// Success=0A=
	return(0);=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_alloc_rx_ring()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Allocate buffers for each buffer descriptor in the RX ring.=0A=
// The receiver must be restarted after calling this function.=0A=
=0A=
static int hdlc_ppp_alloc_rx_ring(struct device* dev)=0A=
{=0A=
	int i;=0A=
	volatile cbd_t* bdp;=0A=
	struct sk_buff*	newskb;=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile scc_hdlc_t* hp =3D (scc_hdlc_t*)dev->mem_start;=0A=
=0A=
	// Initialize the RX Buffer Descriptor Ring=0A=
	bdp =3D chan->rx_bd_base;=0A=
	for (i =3D 0; i < RX_RING_SIZE; ++i, ++bdp)=0A=
		{=0A=
		newskb =3D hdlc_ppp_alloc_skb(hp->genscc.scc_mrblr);=0A=
		if (!newskb)=0A=
			{=0A=
			printk("cannot alloc socket buffer\n");=0A=
			goto fail_rx_buffer;=0A=
			}=0A=
=0A=
		// Assign physical memory to each RX Buffer Descriptor=0A=
		bdp->cbd_bufaddr =3D __pa(newskb->data);=0A=
		chan->rx_skbuff[i] =3D newskb;=0A=
		}=0A=
=0A=
	// Success=0A=
	return(0);=0A=
=0A=
fail_rx_buffer:=0A=
=0A=
	for (i =3D 0; i < RX_RING_SIZE; ++i)=0A=
		{=0A=
		// Free any allocated socket buffers=0A=
		if (chan->rx_skbuff[i])=0A=
			dev_kfree_skb(chan->rx_skbuff[i]);=0A=
=0A=
		chan->rx_skbuff[i] =3D 0;=0A=
		}=0A=
=0A=
	return(-ENOMEM);=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_alloc_skb()=0A=
//=0A=
// Return:=0A=
//	Pointer to a new socket buffer.=0A=
//=0A=
// Input Parameters:=0A=
//	(I) mtu - specifies the size in bytes of the current MTU=0A=
//=0A=
// Allocates a new socket buffer large enough to receive a complete=0A=
// frame of the current MTU size.  The buffer is pre-flush from=0A=
// the cache so that data received from the SCC is not corrupted=0A=
// later.=0A=
=0A=
static struct sk_buff* hdlc_ppp_alloc_skb(int mtu)=0A=
{=0A=
	struct sk_buff*	newskb;=0A=
=0A=
	// Allocate a socket buffer=0A=
	newskb =3D dev_alloc_skb(mtu);=0A=
=0A=
	if (newskb)=0A=
		{=0A=
		// Push the data cache so updates are made now from cache=0A=
		// (we don't want data clobbered later)=0A=
		flush_dcache_range((ulong)newskb->data,=0A=
			(ulong)(newskb->data + mtu));=0A=
		}=0A=
=0A=
	return(newskb);=0A=
}=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_restart_rx()=0A=
//=0A=
// Return:=0A=
//	None.=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Restarts (or starts for the first time) the Receiver of the=0A=
// specified SCC.=0A=
=0A=
static void hdlc_ppp_restart_rx(struct device* dev)=0A=
{=0A=
	volatile cpm8xx_t* cp =3D cpmp;=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile cbd_t* bdp;=0A=
	int i;=0A=
=0A=
	// Disable the receiver=0A=
	sccp->scc_gsmrl &=3D ~SCC_GSMRL_ENR;=0A=
=0A=
	// Re-INIT RX=0A=
	// This command lets the CPM know it must reinitialize the SCC=0A=
	// with the new parameter RAM values.=0A=
	// This intializes the rbptr register=0A=
	cp->cp_cpcr =3D mk_cr_cmd(SCC_Params[chan->scc_param_index].chan_cmd,=0A=
		CPM_CR_INIT_RX) | CPM_CR_FLG;=0A=
	while (cp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
	// Synchronize the local state machine with the CPM=0A=
	chan->rx_tail =3D 0;=0A=
=0A=
	// Initialize the RX Buffer Descriptor Ring=0A=
	bdp =3D chan->rx_bd_base;=0A=
	for (i =3D 0; i < RX_RING_SIZE; ++i, ++bdp)=0A=
		{=0A=
		// Save the indexed pointer to the bd=0A=
		chan->rx_bd[i] =3D bdp;=0A=
=0A=
		if (i =3D=3D (RX_RING_SIZE - 1))=0A=
			bdp->cbd_sc =3D BD_HDLC_RX_EMPTY | BD_HDLC_RX_INTRPT |=0A=
				BD_HDLC_RX_WRAP;=0A=
		else=0A=
			bdp->cbd_sc =3D BD_HDLC_RX_EMPTY | BD_HDLC_RX_INTRPT;=0A=
		}=0A=
=0A=
	// Enable Receive processing=0A=
	// Hunt Mode is automatically enetered=0A=
	sccp->scc_gsmrl |=3D SCC_GSMRL_ENR;=0A=
}=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_restart_tx()=0A=
//=0A=
// Return:=0A=
//	None.=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Restarts (or starts for the first time) the Transmitter of the=0A=
// specified SCC.=0A=
=0A=
static void hdlc_ppp_restart_tx(struct device* dev)=0A=
{=0A=
	volatile cpm8xx_t* cp =3D cpmp;=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile cbd_t* bdp;=0A=
	int i;=0A=
=0A=
	// Send the Stop Transmission command to the CPM for this SCC=0A=
	cp->cp_cpcr =3D mk_cr_cmd(SCC_Params[chan->scc_param_index].chan_cmd,=0A=
		CPM_CR_STOP_TX) | CPM_CR_FLG;=0A=
	while (cp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
	// Disable transmission=0A=
	sccp->scc_gsmrl &=3D ~SCC_GSMRL_ENT;=0A=
=0A=
	// Re-INIT TX command=0A=
	// This command lets the CPM know it must reinitialize the SCC=0A=
	// with the new parameter RAM values.=0A=
	// This intializes the tbptr register=0A=
	cp->cp_cpcr =3D mk_cr_cmd(SCC_Params[chan->scc_param_index].chan_cmd,=0A=
		CPM_CR_INIT_TX) | CPM_CR_FLG;=0A=
	while (cp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
	// Synchronize the local state machine with the CPM=0A=
	chan->tx_head =3D 0;=0A=
=0A=
	// Initialize the TX Buffer Descriptor Ring=0A=
	bdp =3D chan->tx_bd_base;=0A=
	for (i =3D 0; i < TX_RING_SIZE; ++i, ++bdp)=0A=
		{=0A=
		// Save the indexed pointer to the bd=0A=
		chan->tx_bd[i] =3D bdp;=0A=
#if 0=0A=
		if (i =3D=3D (TX_RING_SIZE - 1))=0A=
			{=0A=
			bdp->cbd_sc =3D BD_HDLC_TX_WRAP;=0A=
			}=0A=
		else=0A=
			{=0A=
			bdp->cbd_sc =3D 0;=0A=
			}=0A=
#else=0A=
		bdp->cbd_sc =3D 0;=0A=
#endif=0A=
		// No pointers yet=0A=
		bdp->cbd_bufaddr =3D 0;=0A=
=0A=
		// Free any allocated socket buffers=0A=
		if (chan->tx_skbuff[i])=0A=
			{=0A=
			dev_kfree_skb(chan->tx_skbuff[i]);=0A=
			chan->stats.tx_dropped++;=0A=
			}=0A=
=0A=
		chan->tx_skbuff[i] =3D 0;=0A=
		}=0A=
=0A=
	// Enable Transmit processing=0A=
	sccp->scc_gsmrl |=3D SCC_GSMRL_ENT;=0A=
=0A=
	// TX no longer busy=0A=
	dev->tbusy =3D 0;=0A=
}=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_get_stats()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Return the device statistics=0A=
=0A=
static struct net_device_stats* hdlc_ppp_get_stats(struct device* dev)=0A=
{=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_get_stats()\n", dev->name);=0A=
=0A=
	return(&chan->stats);=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_hard_start_xmit()=0A=
//=0A=
// Return:=0A=
//	0 on success, negative integer on failure=0A=
//=0A=
// Input Parameters:=0A=
//	(I) skb - pointer to a buffer to transmit=0A=
//	(I) dev - pointer to this driver's device structure=0A=
//=0A=
// Close the device and free all resources=0A=
=0A=
static int hdlc_ppp_hard_start_xmit(struct sk_buff* skb, struct device* =
dev)=0A=
{=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile cbd_t* bdp;=0A=
	int i;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_hard_start_xmit()\n", dev->name);=0A=
=0A=
	if (dev->tbusy)=0A=
		{=0A=
		int tickssofar =3D jiffies - dev->trans_start;=0A=
		if (tickssofar < TX_TIMEOUT)=0A=
			{=0A=
			dev_kfree_skb(skb);=0A=
			return(-EBUSY);=0A=
			}=0A=
=0A=
		printk("%s: transmit timed out, restarting\n", dev->name);=0A=
		chan->stats.tx_errors++;=0A=
=0A=
		// Restart the transmitter=0A=
		hdlc_ppp_restart_tx(dev);=0A=
		}=0A=
=0A=
	// Not exactly sure what this code does.  It is illustrated=0A=
	// on p321 of "Linux Device Drivers".=0A=
	if (skb =3D=3D NULL)=0A=
		return(0);=0A=
=0A=
	// Get the head of the queue=0A=
	i =3D chan->tx_head;=0A=
	bdp =3D chan->tx_bd[i];=0A=
=0A=
	if (bdp->cbd_sc & BD_HDLC_TX_READY)=0A=
		{=0A=
		printk("%s: no tx bd's available\n", dev->name);=0A=
=0A=
		// The transmitter is now busy=0A=
		dev->tbusy =3D 1;=0A=
=0A=
		// We loose this packet=0A=
		dev_kfree_skb(skb);=0A=
		chan->stats.tx_dropped++;=0A=
=0A=
		return(-EBUSY);=0A=
		}=0A=
=0A=
	// We found a bd we can use, bump the head index=0A=
	++chan->tx_head;=0A=
	if (chan->tx_head >=3D TX_RING_SIZE)=0A=
		chan->tx_head =3D 0;=0A=
=0A=
	// Set buffer length and pointer=0A=
	chan->tx_skbuff[i] =3D skb;=0A=
	bdp->cbd_datlen =3D skb->len;=0A=
=0A=
	bdp->cbd_bufaddr =3D __pa(skb->data); // Use the physical address=0A=
=0A=
	// Push the data cache so the CPM does not get stale data=0A=
	flush_dcache_range((ulong)skb->data, (ulong)(skb->data + skb->len));=0A=
=0A=
	// Clear status flags=0A=
	bdp->cbd_sc &=3D ~BD_HDLC_TX_STATS;=0A=
=0A=
	// Record start time of transmission=0A=
	dev->trans_start =3D jiffies;=0A=
=0A=
	// Send the packet=0A=
	if (i =3D=3D (TX_RING_SIZE - 1))=0A=
		{=0A=
		bdp->cbd_sc |=3D BD_HDLC_TX_READY | BD_HDLC_TX_INTRPT |=0A=
			BD_HDLC_TX_LAST | BD_HDLC_TX_CRC | BD_HDLC_TX_WRAP;=0A=
		}=0A=
	else=0A=
		{=0A=
		bdp->cbd_sc |=3D BD_HDLC_TX_READY | BD_HDLC_TX_INTRPT |=0A=
			BD_HDLC_TX_LAST | BD_HDLC_TX_CRC;=0A=
		}=0A=
=0A=
=0A=
	// Update statistics=0A=
	chan->stats.tx_bytes +=3D skb->len;=0A=
	chan->stats.tx_packets++;=0A=
=0A=
	// Done=0A=
	return(0);=0A=
}=0A=
=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_interrupt()=0A=
//=0A=
// Return:=0A=
//	None.=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev_id - pointer to this driver's device structure=0A=
//=0A=
// Close the device and free all resources=0A=
=0A=
static void hdlc_ppp_interrupt(void *dev_id)=0A=
{=0A=
	struct device* dev =3D (struct device*)dev_id;=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile scc_t* sccp =3D (scc_t*)dev->base_addr;=0A=
	ushort int_events;=0A=
=0A=
	DEBUG("%s: Entering ISR\n", dev->name);=0A=
=0A=
	// Print message if we are re-entering=0A=
	if (dev->interrupt)=0A=
		{=0A=
		printk("%s: re-entering the interrupt handler\n",=0A=
			dev->name);=0A=
		}=0A=
=0A=
	// Indicate we are in our ISR=0A=
	dev->interrupt =3D 1;=0A=
=0A=
	// Get the interrupt events=0A=
	int_events =3D sccp->scc_scce;=0A=
=0A=
	//DEBUG("%s: sccp->scc_scce=3D0x%x\n", dev->name, int_events);=0A=
=0A=
	// Clear off these event=0A=
	sccp->scc_scce =3D int_events;=0A=
=0A=
	if (int_events & SCCM_BSY)=0A=
		{=0A=
		chan->stats.rx_errors++;=0A=
		chan->stats.rx_dropped++;=0A=
		DEBUG("%s: SCCM_BSY=3D%ld\n", dev->name, chan->stats.rx_errors);=0A=
		}=0A=
=0A=
	if (int_events & (SCCM_RX|SCCM_RXF))=0A=
		{=0A=
		// Queue the task into the immediate bottom half queue=0A=
		chan->rx_bh_tq.routine =3D hdlc_ppp_rx_bh;=0A=
		chan->rx_bh_tq.data =3D (void*)dev;=0A=
		queue_task(&chan->rx_bh_tq, &tq_immediate);=0A=
		mark_bh(IMMEDIATE_BH);=0A=
		}=0A=
=0A=
	if (int_events & SCCM_TXE)=0A=
		{=0A=
		chan->stats.tx_errors++;=0A=
		DEBUG("%s: SCCM_TXE=3D%ld\n", dev->name, chan->stats.tx_errors);=0A=
		}=0A=
=0A=
	if (int_events & (SCCM_TX | SCCM_TXE))=0A=
		{=0A=
		// Queue the task into the immediate bottom half queue=0A=
		chan->tx_bh_tq.routine =3D hdlc_ppp_tx_bh;=0A=
		chan->tx_bh_tq.data =3D (void*)dev;=0A=
		queue_task(&chan->tx_bh_tq, &tq_immediate);=0A=
		mark_bh(IMMEDIATE_BH);=0A=
		}=0A=
=0A=
	// Finished with the ISR=0A=
	dev->interrupt =3D 0;=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_tx_bh()=0A=
//=0A=
// Return:=0A=
//	None.=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev_id - pointer to this driver's device structure=0A=
//=0A=
// This is one of the bottom half handlers for hdlc_ppp_interrupt().=0A=
// It completes the service of TX buffers that have completed.=0A=
=0A=
static void hdlc_ppp_tx_bh(void* dev_id)=0A=
{=0A=
	struct device* dev =3D (struct device*)dev_id;=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile cbd_t* bdp;=0A=
	int i;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_tx_bh()\n", dev->name);=0A=
=0A=
	// Adjust module count=0A=
=0A=
	// Scan TX bd's and cleanup=0A=
	for (i =3D 0; i < TX_RING_SIZE; ++i)=0A=
		{=0A=
		bdp =3D chan->tx_bd[i];=0A=
=0A=
		// Don't touch buffers waiting to be transmitted=0A=
		if (bdp->cbd_sc & BD_HDLC_TX_READY)=0A=
			continue;=0A=
=0A=
		// Unused bd if its pointer is null=0A=
		if (!chan->tx_skbuff[i])=0A=
			continue;=0A=
=0A=
		// Free the socket buffer=0A=
		dev_kfree_skb(chan->tx_skbuff[i]);=0A=
		chan->tx_skbuff[i] =3D 0;=0A=
=0A=
		// We have at least one TX Buff Descr available now=0A=
		dev->tbusy =3D 0;=0A=
=0A=
		// Accumulate TX statistics=0A=
		if (bdp->cbd_sc & BD_HDLC_TX_UN)=0A=
			{=0A=
			DEBUG("%s: BD_HDLC_TX_UN\n", dev->name);=0A=
			chan->stats.tx_fifo_errors++;=0A=
			}=0A=
=0A=
		if (bdp->cbd_sc & BD_HDLC_TX_CL)=0A=
			{=0A=
			DEBUG("%s: BD_HDLC_TX_CL\n", dev->name);=0A=
			chan->stats.tx_carrier_errors++;=0A=
			}=0A=
		}=0A=
}=0A=
=0A=
=0A=
//--------------------------------------------------------------=0A=
// hdlc_ppp_rx_bh()=0A=
//=0A=
// Return:=0A=
//	None.=0A=
//=0A=
// Input Parameters:=0A=
//	(I) dev_id - pointer to this driver's device structure=0A=
//=0A=
// This is one of the bottom half handlers for hdlc_ppp_interrupt().=0A=
// It completes the service of RX buffers that have completed.=0A=
=0A=
static void hdlc_ppp_rx_bh(void* dev_id)=0A=
{=0A=
	struct device* dev =3D (struct device*)dev_id;=0A=
	hdlc_channel_t* chan =3D (hdlc_channel_t*)dev->priv;=0A=
	volatile scc_hdlc_t* hp =3D (scc_hdlc_t*)dev->mem_start;=0A=
	volatile cbd_t* bdp;=0A=
	struct sk_buff*	skb;=0A=
	struct sk_buff*	newskb;=0A=
	ushort pkt_len;=0A=
	ushort rx_stat;=0A=
	int rxerr;=0A=
	int i;=0A=
=0A=
	DEBUG("%s: hdlc_ppp_rx_bh()\n", dev->name);=0A=
=0A=
	while (1)=0A=
		{=0A=
		// Get the tail of the queue=0A=
		i =3D chan->rx_tail;=0A=
		bdp =3D chan->rx_bd[i];=0A=
=0A=
		if (bdp->cbd_sc & BD_HDLC_RX_EMPTY)=0A=
			return; // Nothing more to do=0A=
=0A=
		// Get a socket buffer to replace the one just consumed=0A=
		newskb =3D hdlc_ppp_alloc_skb(hp->genscc.scc_mrblr);=0A=
		if (!newskb)=0A=
			{=0A=
			printk("%s: no rx buffers, dropping packet\n",=0A=
				dev->name);=0A=
			chan->stats.rx_dropped++;=0A=
=0A=
			// Return here so we don't get out of sync w/cpm=0A=
			return;=0A=
			}=0A=
=0A=
		// We found a bd with data, bump the tail index=0A=
		if (++chan->rx_tail >=3D RX_RING_SIZE)=0A=
			chan->rx_tail =3D 0;=0A=
=0A=
		// Get the socket data buffer=0A=
		skb =3D chan->rx_skbuff[i];=0A=
		chan->rx_skbuff[i] =3D newskb;=0A=
		pkt_len =3D bdp->cbd_datlen;=0A=
=0A=
		// Get the status of the RX packet=0A=
		rx_stat =3D bdp->cbd_sc;=0A=
=0A=
		// Clear status flags=0A=
		bdp->cbd_sc &=3D ~BD_HDLC_RX_STATS;=0A=
=0A=
		// Set the physical address of the new socket buffer=0A=
		bdp->cbd_bufaddr =3D __pa(newskb->data);=0A=
=0A=
		// Mark ready to receive data=0A=
		bdp->cbd_sc |=3D BD_HDLC_RX_EMPTY;=0A=
=0A=
=0A=
		// Update statistics=0A=
		chan->stats.rx_packets++;=0A=
		chan->stats.rx_bytes +=3D pkt_len;=0A=
		rxerr =3D 0;=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_DE)=0A=
			{=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_DE\n", dev->name);=0A=
			}=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_LG)=0A=
			{=0A=
			chan->stats.rx_length_errors++;=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_LG\n", dev->name);=0A=
			}=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_NO)=0A=
			{=0A=
			chan->stats.rx_frame_errors++;=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_NO\n", dev->name);=0A=
			}=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_AB)=0A=
			{=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_AB\n", dev->name);=0A=
			}=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_CRC)=0A=
			{=0A=
			chan->stats.rx_crc_errors++;=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_CRC\n", dev->name);=0A=
			}=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_OV)=0A=
			{=0A=
			chan->stats.rx_over_errors++;=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_OV\n", dev->name);=0A=
			}=0A=
=0A=
		if (rx_stat & BD_HDLC_RX_CD)=0A=
			{=0A=
			chan->stats.rx_missed_errors++;=0A=
			rxerr =3D 1;=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): RX_CD\n", dev->name);=0A=
			}=0A=
=0A=
		//chan->stats.rx_fifo_errors=0A=
=0A=
		if (rxerr)=0A=
			{=0A=
			DEBUG("%s: hdlc_ppp_rx_bh(): rxerr=3D0x%x\n",=0A=
				dev->name, rxerr);=0A=
			chan->stats.rx_errors++;=0A=
			}=0A=
=0A=
		// Set the length of the received data, minus the CRC=0A=
		skb_put(skb, pkt_len - 2);=0A=
=0A=
		// Set the protocol type=0A=
		skb->protocol=3Dhtons(ETH_P_WAN_PPP);=0A=
=0A=
		// Point to the mac address (first HDLC byte)=0A=
		skb->mac.raw =3D skb->data;=0A=
=0A=
		// This packet is handled by the SYNC PPP driver=0A=
		skb->dev =3D &(chan->pppdev.dev);=0A=
=0A=
		// Send it to the PPP layer=0A=
		netif_rx(skb);=0A=
		}=0A=
=0A=
}=0A=

------=_NextPart_000_0022_01C4423D.65804580--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
