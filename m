Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E320DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 15:20:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m0G4KYp9014563
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 21:20:34 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0G4KVsT000615
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 22:20:32 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] drivers/misc :UCC based TDM driver for MPC83xx
	platforms.
Date: Wed, 16 Jan 2008 09:50:30 +0530
Message-ID: <FBA61160C48B8D438F3323FEFB4EF2C26E7ABB@zin33exm24.fsl.freescale.net>
In-Reply-To: <20080114131441.878979d2.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0712101710270.29623@linux121>
	<20080114131441.878979d2.akpm@linux-foundation.org>
From: "Aggrwal Poonam" <Poonam.Aggrwal@freescale.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: kumar.gala@freescale.co, Phillips Kim <Kim.Phillips@freescale.com>,
	Barkowski Michael <Michael.Barkowski@freescale.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rubini@vision.unipv.it, linuxppc-dev@ozlabs.org,
	Kalra Ashish <ashish.kalra@freescale.com>,
	Cutler Richard <Rich.Cutler@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Morton for your comments,
I shall incorporate them and reesnd the patch.

With Regards
Poonam=20
=20
=20

-----Original Message-----
From: Andrew Morton [mailto:akpm@linux-foundation.org]=20
Sent: Tuesday, January 15, 2008 2:45 AM
To: Aggrwal Poonam
Cc: rubini@vision.unipv.it; linux-kernel@vger.kernel.org;
linuxppc-dev@ozlabs.org; netdev@vger.kernel.org;
kumar.gala@freescale.co; Barkowski Michael; Phillips Kim; Kalra Ashish;
Cutler Richard
Subject: Re: [PATCH 1/3] drivers/misc :UCC based TDM driver for MPC83xx
platforms.

On Mon, 10 Dec 2007 17:34:44 +0530 (IST)
Poonam_Aggrwal-b10812 <b10812@freescale.com> wrote:

> From: Poonam Aggrwal <b10812@freescale.com>
>=20
> The UCC TDM driver basically multiplexes and demultiplexes data from=20
> different channels. It can interface with for example SLIC kind of=20
> devices to receive TDM data  demultiplex it and send to upper=20
> applications. At the transmit end it receives data for different=20
> channels multiplexes it and sends them on the TDM channel. It=20
> internally uses TSA( Time Slot Assigner) which does multiplexing and=20
> demultiplexing, UCC to perform SDMA between host buffers and the TSA,
CMX to connect TSA to UCC.
>=20
> This driver will run on MPC8323E-RDB platforms.
>=20
> ...
>
> +#define PREV_PHASE(x) ((x =3D=3D 0) ? MAX_PHASE : (x - 1)) #define=20
> +NEXT_PHASE(x) (((x + 1) > MAX_PHASE) ? 0 : (x + 1))

These macros can reference their arg more than once and are hence
dangerous.  What does PREV_PHASE(foo++) do to foo?

And, in general: do not implement in cpp that which could have been
implemented in C.

> +static struct ucc_tdm_info utdm_primary_info =3D {
> +	.uf_info =3D {
> +		.tsa =3D 1,
> +		.cdp =3D 1,
> +		.cds =3D 1,
> +		.ctsp =3D 1,
> +		.ctss =3D 1,
> +		.revd =3D 1,
> +		.urfs =3D 0x128,
> +		.utfs =3D 0x128,
> +		.utfet =3D 0,
> +		.utftt =3D 0x128,
> +		.ufpt =3D 256,
> +		.ttx_trx =3D
UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_TRANSPARENT,
> +		.tenc =3D UCC_FAST_TX_ENCODING_NRZ,
> +		.renc =3D UCC_FAST_RX_ENCODING_NRZ,
> +		.tcrc =3D UCC_FAST_16_BIT_CRC,
> +		.synl =3D UCC_FAST_SYNC_LEN_NOT_USED,
> +	},
> +	.ucc_busy =3D 0,
> +};
> +
> +static struct ucc_tdm_info utdm_info[8];
> +
> +static void dump_siram(struct tdm_ctrl *tdm_c) { #if defined(DEBUG)

Microscopic note: kernel code tends to do

	#ifdef FOO

if only one identifier is being tested and

	#if defined(FOO) && defined(BAR)

if more than one is being tested.

There is no rational reason for this ;)

> +	int i;
> +	u16 phy_num_ts;
> +
> +	phy_num_ts =3D tdm_c->physical_num_ts;
> +
> +	pr_debug("SI TxRAM dump\n");
> +	/* each slot entry in SI RAM is of 2 bytes */
> +	for (i =3D 0; i < phy_num_ts * 2; i++)
> +		pr_debug("%x ", in_8(&qe_immr->sir.tx[i]));
> +	pr_debug("\nSI RxRAM dump\n");
> +	for (i =3D 0; i < phy_num_ts * 2; i++)
> +		pr_debug("%x ", in_8(&qe_immr->sir.rx[i]));
> +	pr_debug("\n");
> +#endif
> +}
> +
> +/*
> + * converts u-law compressed samples to linear PCM
> + * If the CONFIG_TDM_LINEAR_PCM flag is not set the
> + * TDM driver receives u-law compressed data from the
> + * SLIC device. This function converts the compressed
> + * data to linear PCM and sends it to upper layers.
> + */
> +static inline int ulaw2int(unsigned char log) {
> +	u32 sign, segment, temp, quant;
> +	int val;
> +
> +	temp =3D log ^ 0xFF;
> +	sign =3D (temp & 0x80) >> 7;
> +	segment =3D (temp & 0x70) >> 4;
> +	quant =3D temp & 0x0F;
> +	quant <<=3D 1;
> +	quant +=3D 33;
> +	quant <<=3D segment;
> +	if (sign)
> +		val =3D 33 - quant;
> +	else
> +		val =3D quant - 33;
> +
> +	val *=3D 4;
> +	return val;
> +}
> +
> +/*
> + * converts linear PCM samples to u-law compressed format.
> + * If the CONFIG_TDM_LINEAR_PCM flag is not set the
> + * TDM driver calls this function to convert the PCM samples
> + * to u-law compressed format before sending them to SLIC
> + * device.
> + */
> +static inline u8 int2ulaw(short linear) {
> +	u8  quant, ret;
> +	u16 output, absol, temp;
> +	u32 i, sign;
> +	char segment;
> +
> +	ret =3D 0;
> +	if (linear >=3D 0)
> +		linear =3D (linear >> 2);
> +	else
> +		linear =3D (0xc000 | (linear >> 2));
> +
> +	absol =3D abs(linear) + 33;
> +	temp =3D absol;
> +	sign =3D (linear >=3D 0) ? 1 : 0;
> +	for (i =3D 0; i < 16; i++) {
> +		output =3D temp & 0x8000;
> +		if (output)
> +			break;
> +		temp <<=3D 1;
> +	}
> +	segment =3D 11 - i;
> +	quant =3D (absol >> segment) & 0x0F;
> +	segment--;
> +	segment <<=3D 4;
> +	output =3D segment + quant;
> +	if (absol > 8191)
> +		output =3D 0x7F;
> +	if (sign)
> +		ret ^=3D 0xFF;
> +	else
> +		ret ^=3D 0x7F;
> +	return ret;
> +}

hrm, how many copies of ulaw/alaw conversion functions do we need in the
tree before someone writes a library function for it?

> +	out_be16(&rx_bd->status, bd_status);
> +	out_be32(&rx_bd->buf,
> +		 tdm_c->dma_input_addr + i * SAMPLE_DEPTH * act_num_ts);
> +
> +	bd_status =3D (u16) ((T_R | T_CM | T_W) >> 16);
> +	bd_len =3D  SAMPLE_DEPTH * act_num_ts;
> +	out_be16(&tx_bd->length, bd_len);
> +	out_be16(&tx_bd->status, bd_status);
> +	out_be32(&tx_bd->buf,
> +		 tdm_c->dma_output_addr + i * SAMPLE_DEPTH *
act_num_ts);
> +
> +	config_si(tdm_c);
> +
> +	setbits32(&qe_immr->ic.qimr, (0x80000000 >> ucc));

The compiler treats 0xNNN constants as unsigned so this works OK.  I'd
have put a UL on the end of the constant to be sure ;)

> +static int tdm_start(struct tdm_ctrl *tdm_c) {
> +	if (request_irq(tdm_c->ut_info->uf_info.irq, tdm_isr,
> +					0, "tdm", tdm_c)) {
> +		printk(KERN_ERR "%s: request_irq for tdm_isr failed\n",
> +			__FUNCTION__);
> +		return -ENODEV;
> +	}
> +
> +	ucc_fast_enable(tdm_c->uf_private, COMM_DIR_RX | COMM_DIR_TX);
> +
> +#if !defined(CONFIG_TDM_LINEAR_PCM)
> +	pr_info("%s 8-bit u-law compressed mode active\n",
__FUNCTION__);=20
> +#else
> +	pr_info("%s 16-bit linear pcm mode active with"
> +		" slots 0 & 2\n", __FUNCTION__);
> +#endif

Is this the sort of thing which should be controlled at compile-time?
I'd have thought that a runtime control would be more appropriate (a
sysfs knob or a module parameter).  Or just work it out automagically?


> +	dump_siram(tdm_c);
> +	dump_ucc(tdm_c);
> +
> +	setbits8(&(qe_immr->si1.siglmr1_h), (0x1 << tdm_c->tdm_port));
> +	pr_info("%s UCC based TDM enabled\n", __FUNCTION__);
> +
> +	return 0;
> +}
>
> ...
>
> +static void tdm_read(u32 driver_handle, short chn_id, short
*pcm_buffer,
> +								short
len)
> +{
> +	int i;
> +	u32 phase_rx;
> +	/* point to where to start for the current phase data processing
*/
> +	u32 temp_rx;
> +
> +	struct tdm_ctrl *tdm_c =3D (struct tdm_ctrl *)(driver_handle);

eek.  What are we doing here, casting a 32-bit quantity to a kernel
pointer?

a) Seems to rule out ever using this driver on a 64-bit system

b) It's generally suspicious and indicates that some rethinking is
needed.

> +#if !defined(CONFIG_TDM_LINEAR_PCM)
> +	u8 *input_tdm_buffer =3D tdm_c->tdm_input_data;
> +
> +#else
> +	u16 *input_tdm_buffer =3D
> +		(u16 *)tdm_c->tdm_input_data;
> +
> +#endif
> +	phase_rx =3D tdm_c->phase_rx;
> +	phase_rx =3D PREV_PHASE(phase_rx);
> +
> +	temp_rx =3D phase_rx * SAMPLE_DEPTH * EFF_ACTIVE_CH;
> +
> +#if defined(UCC_CACHE_SNOOPING_DISABLED)
> +	flush_dcache_range((size_t) &input_tdm_buffer[temp_rx],
> +				(size_t) &input_tdm_buffer[temp_rx +
> +						SAMPLE_DEPTH *
ACTIVE_CH]);
> +#endif

Again, is it appropriate that this behaviour be determined at
compile-time?
This is very user- and packager- and distributor-unfriendly.

> +	for (i =3D 0; i < len; i++) {
> +#if !defined(CONFIG_TDM_LINEAR_PCM)
> +		pcm_buffer[i] =3D
> +			ulaw2int(input_tdm_buffer[i * EFF_ACTIVE_CH +
> +						temp_rx + chn_id]);
> +#else
> +		pcm_buffer[i] =3D
> +			input_tdm_buffer[i * EFF_ACTIVE_CH + temp_rx +
chn_id]; #endif
> +
> +	}
> +
> +}
> +
> +static int ucc_tdm_probe(struct of_device *ofdev,
> +			 const struct of_device_id *match) {
> +	struct device_node *np =3D ofdev->node;
> +	struct resource res;
> +	const unsigned int *prop;
> +	u32 ucc_num, device_num, err, ret =3D 0;
> +	struct device_node *np_tmp =3D NULL;
> +	dma_addr_t physaddr;
> +	void *tdm_buff;
> +	struct ucc_tdm_info *ut_info;
> +
> +	prop =3D of_get_property(np, "device-id", NULL);
> +	ucc_num =3D *prop - 1;
> +	if ((ucc_num < 0) || (ucc_num > 7))
> +		return -ENODEV;
> +
> +	ut_info =3D &utdm_info[ucc_num];
> +	if (ut_info =3D=3D NULL) {
> +		printk(KERN_ERR "additional data missing\n");
> +		return -ENODEV;
> +	}
> +	if (ut_info->ucc_busy) {
> +		printk(KERN_ERR "UCC in use by another TDM driver
instance\n");
> +		return -EBUSY;
> +	}
> +
> +	ut_info->ucc_busy =3D 1;
> +	tdm_ctrl[num_tdm_devices++] =3D
> +		kzalloc(sizeof(struct tdm_ctrl), GFP_KERNEL);

Shouldn't this check for (num_tdm_devices > MAX_NUM_TDM_DEVICES))?

> +	if (!tdm_ctrl[num_tdm_devices - 1]) {
> +		printk(KERN_ERR "%s: no memory to allocate for"
> +			" tdm control structure\n", __FUNCTION__);
> +		num_tdm_devices--;
> +		return -ENOMEM;
> +	}
> +	device_num =3D num_tdm_devices - 1;
> +
> +	tdm_ctrl[device_num]->device =3D &ofdev->dev;
> +	tdm_ctrl[device_num]->ut_info =3D ut_info;
> +
> +	tdm_ctrl[device_num]->ut_info->uf_info.ucc_num =3D ucc_num;
> +
> +	prop =3D of_get_property(np, "fsl,tdm-num", NULL);
> +	if (prop =3D=3D NULL) {
> +		ret =3D -EINVAL;
> +		goto get_property_error;
> +	}
>
> ...
>
> +
> +#define SET_RX_SI_RAM(n, val)		\
> +		out_be16((u16 *)&qe_immr->sir.rx[(n)*2], (u16)(val))
> +
> +#define SET_TX_SI_RAM(n, val)		\
> +		out_be16((u16 *)&qe_immr->sir.tx[(n)*2], (u16)(val))

I don't think there's anything which requires that these be imlemented
in the preprocessor?

> +struct tdm_cfg {
> +	u8 com_pin;		/* Common receive and transmit pins
> +				 * 0 =3D separate pins
> +				 * 1 =3D common pins
> +				 */
> +
> +	u8 fr_sync_level;	/* SLx bit Frame Sync Polarity
> +				 * 0 =3D L1R/TSYNC active logic "1"
> +				 * 1 =3D L1R/TSYNC active logic "0"
> +				 */
> +
> +	u8 clk_edge;		/* CEx bit Tx Rx Clock Edge
> +				 * 0 =3D TX data on rising edge of clock
> +				 * RX data on falling edge
> +				 * 1 =3D TX data on falling edge of clock
> +				 * RX data on rising edge
> +				 */
> +
> +	u8 fr_sync_edge;	/* FEx bit Frame sync edge
> +				 * Determine when the sync pulses are
sampled
> +				 * 0 =3D Falling edge
> +				 * 1 =3D Rising edge
> +				 */
> +
> +	u8 rx_fr_sync_delay;	/* TFSDx/RFSDx bits Frame Sync Delay
> +				 * 00 =3D no bit delay
> +				 * 01 =3D 1 bit delay
> +				 * 10 =3D 2 bit delay
> +				 * 11 =3D 3 bit delay
> +				 */
> +
> +	u8 tx_fr_sync_delay;	/* TFSDx/RFSDx bits Frame Sync Delay
> +				 * 00 =3D no bit delay
> +				 * 01 =3D 1 bit delay
> +				 * 10 =3D 2 bit delay
> +				 * 11 =3D 3 bit delay
> +				 */
> +
> +	u8 active_num_ts;	/* Number of active time slots in TDM
> +				 * assume same active Rx/Tx time slots
> +				 */
> +};

Nice commenting.
