Return-Path: <galak@kernel.crashing.org>
Message-Id: <9DD9B395-38FF-422B-83D8-B91178AB46E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200806121345.52293.david.jander@protonic.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB to current head
Date: Thu, 12 Jun 2008 07:12:15 -0500
References: <200806121344.26883.david.jander@protonic.nl>
	<200806121345.52293.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 12, 2008, at 6:45 AM, David Jander wrote:

Your commit message isn't exactly helpful as most people dont know  
what LTIB is and its not terribly relevant.  It just seems like you  
are adding support for the FEC on MPC5121 and this point.

>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
> arch/powerpc/platforms/Kconfig     |    2 +-
> drivers/net/fec.h                  |   43 ++++++++++++++++++++
> drivers/net/fs_enet/Kconfig        |   22 +++++++++-
> drivers/net/fs_enet/fs_enet-main.c |   76 +++++++++++++++++++++++++++ 
> +++------
> drivers/net/fs_enet/fs_enet.h      |   17 +++++---
> drivers/net/fs_enet/mac-fec.c      |   22 +++++++++-
> drivers/net/fs_enet/mii-fec.c      |   10 ++++-
> 7 files changed, 167 insertions(+), 25 deletions(-)
>
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/ 
> Kconfig
> index 87454c5..a96937f 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -288,7 +288,7 @@ config CPM2
>
> config PPC_CPM_NEW_BINDING
> 	bool
> -	depends on CPM1 || CPM2
> +	depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
> 	default y
>
> config AXON_RAM
> diff --git a/drivers/net/fec.h b/drivers/net/fec.h
> index 292719d..5c9fe34 100644
> --- a/drivers/net/fec.h
> +++ b/drivers/net/fec.h
> @@ -59,6 +59,7 @@ typedef struct fec {
> } fec_t;
>
> #else
> +#if !defined(CONFIG_FS_ENET_MPC5121_FEC)
>
> /*
>  *	Define device register set address map.
> @@ -97,6 +98,48 @@ typedef struct fec {
> 	unsigned long	fec_fifo_ram[112];	/* FIFO RAM buffer */
> } fec_t;
>
> +#else /* CONFIG_FS_ENET_MPC5121_FEC */
> +
> +typedef struct fec {
> +	u32 fec_reserved0;
> +	u32 fec_ievent;		/* Interrupt event reg */
> +	u32 fec_imask;		/* Interrupt mask reg */
> +	u32 fec_reserved1;
> +	u32 fec_r_des_active;	/* Receive descriptor reg */
> +	u32 fec_x_des_active;	/* Transmit descriptor reg */
> +	u32 fec_reserved2[3];
> +	u32 fec_ecntrl;		/* Ethernet control reg */
> +	u32 fec_reserved3[6];
> +	u32 fec_mii_data;		/* MII manage frame reg */
> +	u32 fec_mii_speed;		/* MII speed control reg */
> +	u32 fec_reserved4[7];
> +	u32 fec_mib_ctrlstat;	/* MIB control/status reg */
> +	u32 fec_reserved5[7];
> +	u32 fec_r_cntrl;		/* Receive control reg */
> +	u32 fec_reserved6[15];
> +	u32 fec_x_cntrl;		/* Transmit Control reg */
> +	u32 fec_reserved7[7];
> +	u32 fec_addr_low;		/* Low 32bits MAC address */
> +	u32 fec_addr_high;		/* High 16bits MAC address */
> +	u32 fec_opd;		/* Opcode + Pause duration */
> +	u32 fec_reserved8[10];
> +	u32 fec_hash_table_high;	/* High 32bits hash table */
> +	u32 fec_hash_table_low;	/* Low 32bits hash table */
> +	u32 fec_grp_hash_table_high;/* High 32bits hash table */
> +	u32 fec_grp_hash_table_low;	/* Low 32bits hash table */
> +	u32 fec_reserved9[7];
> +	u32 fec_x_wmrk;		/* FIFO transmit water mark */
> +	u32 fec_reserved10;
> +	u32 fec_r_bound;		/* FIFO receive bound reg */
> +	u32 fec_r_fstart;		/* FIFO receive start reg */
> +	u32 fec_reserved11[11];
> +	u32 fec_r_des_start;	/* Receive descriptor ring */
> +	u32 fec_x_des_start;	/* Transmit descriptor ring */
> +	u32 fec_r_buff_size;	/* Maximum receive buff size */
> +	u32 fec_dma_control;	/* DMA Endian and other ctrl */
> +} fec_t;
> +
> +#endif /* CONFIG_FS_ENET_MPC5121_FEC */
> #endif /* CONFIG_M5272 */

I'm not exactly clear as to why this was done this way but this not  
acceptable as it means we can't build a multiplatform kernel that  
needs this driver.

I'm also not clear to me if the MPC5121 FEC is really the same device  
or close to it that it should be sharing this driver or have its own.

- k
