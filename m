Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 1628E67B9B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 23:56:55 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 9813322D6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 13:56:50 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
In-Reply-To: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
MIME-Version: 1.0
Message-ID: <200612131356.50092.roman.fietze@telemotive.de>
Date: Wed, 13 Dec 2006 13:56:49 +0100
Content-Type: multipart/signed; boundary="nextPart14049312.1dJujBo9Ay";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart14049312.1dJujBo9Ay
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Si/fFHPjgOphdxQ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Si/fFHPjgOphdxQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Pedro,

On Wednesday 13 December 2006 10:39, Pedro Luis D. L. wrote:

> for sure. I=B4m interested in the code. Maybe I can adapt this code or
> migrate the application to 2.4 from Wolfgang. At this moment, I=B4m
> quite focus on make something sounds through the audio board.

See what you can achive with the code in the attachments of the two
posts. They are

alsa/alsa-kernel/i2c/mpc5200-uda1380.c   ALSA PCM driver
alsa/alsa-kernel/ppc/uda1380.[hc]        ALSA Codec Controls


And in the second post the kernel patch.

linux/include/asm-ppc/mpc5xxx.h          MPC5200 constants
arch/ppc/5xxx_io/snd-psc.c               Kernel side of ALSA sound driver

I'va also attached mpc5xxx.h, I think I used some additional constants
which I added there. I had to separate the ALSA and kernel parts of
the PCM driver, so I could more easily manage it.

The driver uses some modified bestcomm code, because the original
bestcomm code from Freescale is, ahem, not very well designed, one of
the reasons for the new design in the 2.6. The changes were done in
the code image 2. They are a more generic approach for the PSC tasks,
so I can more easily switch PSC's. You should easily be able to modify
the kernel part of the driver, to use the bestcomm code from
Wolfgang's 2.4.25 git kernel tree. If not, please contact me and I
will send you the sources of my bestcomm/ subdirectory, or anybody
else of course.

One day, when we have the 2.6 running, I will try to get the code
upstream to ALSA and the powerpc kernel.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--Boundary-01=_Si/fFHPjgOphdxQ
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="uda1380.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uda1380.c"

/*
 * Sound driver for Philips uda1380 - i2c related stuff
 *
 * Copyright (C) 2005 Roman Fietze <roman.fietze@telemotive.de>
 * Copyright (C) 2004 Giorgio Padrin
 *
 * This file is subject to the terms and conditions of the GNU General Publ=
ic
 * License.  See the file COPYING in the main directory of this archive for
 * more details.
 *
 * based on code by:
 *
 * 2004-03	Mattew Reimer=20
 * Copyright (C) 2003 Christian Pellegrin
 * Copyright (C) 2000 Lernout & Hauspie Speech Products, N.V.
 * Copyright (c) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
 * Copyright (c) 2002 Hewlett-Packard Company
 * Copyright (c) 2000 Nicolas Pitre <nico@cam.org>
 */

#undef UDA1380_DEBUG
// #define UDA1380_DEBUG

#include <sound/driver.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/slab.h>
#include <linux/wait.h>
#include <linux/errno.h>
#include <linux/ioctl.h>
#include <linux/delay.h>
#include <linux/soundcard.h>
#include <linux/i2c.h>

#include <sound/core.h>
#include <sound/control.h>
#include <sound/initval.h>
#include <sound/info.h>
#include "uda1380.h"

#include <asm/uaccess.h>

static int debug =3D -1;


#if defined(UDA1380_DEBUG)
#define PRDEBUG(level, format, x... )  do {if (level <=3D debug) printk(KER=
N_INFO format, ## x );} while (0)
static inline void DBGDELAY(int _level, unsigned long _ms)
{
	if (_ms && _level <=3D debug)
	{
		wait_queue_head_t wait;
		init_waitqueue_head(&wait);
		interruptible_sleep_on_timeout(&wait, (HZ * _ms) / 1000UL);
	}
}
#else
#define PRDEBUG(level, format, x... )	do {} while(0)
#define DBGDELAY(t)			do {} while(0)
#endif


static struct i2c_driver uda1380_driver;

static struct uda1380_reg_info {
	unsigned short num;
	unsigned short default_value;
} uda1380_reg_info[] =3D {
	{
		EMCS_REG,
		EMCS_REG_SC_256FS | EMCS_REG_DAC_USE_WSPLL | EMCS_REG_ADC_USE_WSPLL |
		EMCS_REG_PLL_25TO50 | EMCS_REG_EN_ADC | EMCS_REG_EN_DEC | EMCS_REG_EN_DAC=
 | EMCS_REG_EN_INT
	},
	{
		I2S_REG,
		(FMT_I2S << I2S_REG_SFORO_SHIFT) | (FMT_I2S << I2S_REG_SFORI_SHIFT) |
		I2S_REG_SEL_DECIMATOR | I2S_REG_SIM_SLAVE
	},
	{
		PWR_REG,
		PWR_REG_PON_PLL |
		PWR_REG_PON_DAC | PWR_REG_PON_BIAS | PWR_REG_PON_HP |
		PWR_REG_EN_AVC | PWR_REG_PON_AVC | PWR_REG_PON_LNA | PWR_REG_PON_ADCL | P=
WR_REG_PON_ADCR |
		PWR_REG_PON_PGAL | PWR_REG_PON_PGAR
	},
	{
		AMIX_REG,
		AMIX_AVCL(0x3F) | AMIX_AVCR(0x3F)
	},
	{
		MASTER_VOL_REG,
		MASTER_VCL(0) | MASTER_VCR(0)
	},
	{
		MIXER_VOL_REG,
		MIXER_VC_CH1(00) | MIXER_VC_CH2(0xff)
	},
	{
		MBT_REG,
		0x00
	},
	{
		MMCDM_REG,
		MMCDM_MASTER_MUTE| MMCDM_CHANNEL2_MUTE
	},
	{
		MIXER_CTL_REG,
		0x00
	},
	{
		DEC_VOL_REG,
		DEC_VCL(0) | DEC_VCR(0)
	},
	{
		DPM_REG,
		DPM_MUTE_ADC
	},
	{
		DEC_ADC_REG,
		0x050c
	},
	{
		DEC_AGC_REG,
		0x00
	}
};

typedef unsigned int uda1380_enumerated_t;
typedef long uda1380_value_t;

typedef struct _uda1380_lr_value
{
	uda1380_value_t left;
	uda1380_value_t right;
} uda1380_lr_value_t;


typedef struct _uda1380
{
	uint16_t regs[REG_MAX];

	int mic_enable;

	int mod_cnt;

	uda1380_enumerated_t deemp;
	uda1380_enumerated_t strength;
	uda1380_value_t playback_mute;
	uda1380_value_t mic_gain;
	uda1380_value_t mic_sw;
	uda1380_value_t line_mute;
	uda1380_lr_value_t line_gain;
	uda1380_lr_value_t master_playback_volume;
	uda1380_lr_value_t analog_playback_volume;
	uda1380_lr_value_t pcm_capture_volume;
	uda1380_lr_value_t bass;
	uda1380_lr_value_t treble;

	struct i2c_client client;
} uda1380_t;


#if defined(UDA1380_DEBUG) && 0
static void uda1380_dump(int level, const uda1380_t *uda1380)
{
	PRDEBUG(level, "uda1380: volume=3D%u bass=3D%u treble=3D%u line=3D%u mic=
=3D%u\n",
		uda1380->volume, uda1380->bass, uda1380->treble, uda1380->line, uda1380->=
mic);
	PRDEBUG(level, "uda1380: mod_cnt=3D%d client=3D%p\n",
		uda1380->mod_cnt, &uda1380->client);
}
#endif


static int uda1380_write_reg(struct i2c_client *client, uda1380_t *uda1380,=
 int regaddr)
{
	uint8_t buffer[3];
	int r;

	PRDEBUG(3, "%s(): [%u] =3D %04x\n", __FUNCTION__, regaddr, uda1380->regs[r=
egaddr]);

	buffer[0] =3D regaddr;
	buffer[1] =3D uda1380->regs[regaddr] >> 8;
	buffer[2] =3D uda1380->regs[regaddr] & 0xff;

	r =3D i2c_master_send(client, buffer, 3);
	if (r =3D=3D 3)
		r =3D 0;
	else if (r >=3D 0)
		r =3D -EIO;
	=09
	return r;
}


void uda1380_configure(struct i2c_client *client, long rate)
{
	uda1380_t *uda1380 =3D container_of(client, uda1380_t, client);
	uint16_t pll;

	PRDEBUG(2, "%s(%p,%ld) uda1380=3D%p\n", __FUNCTION__, client, rate, uda138=
0);

	if (!rate) {
		PRDEBUG(2, "%s: rate set to default of 44100\n", __FUNCTION__);
		rate =3D 44100;
	}

	if (rate > 50000)
		pll =3D EMCS_REG_PLL_50TO100;
	if (rate >=3D 25000)
		pll =3D EMCS_REG_PLL_25TO50;
	else if (rate >=3D 12000)
		pll =3D EMCS_REG_PLL_12TO25;
	else
		pll =3D EMCS_REG_PLL_6TO12;
	uda1380->regs[EMCS_REG] &=3D ~(EMCS_REG_SC_MASK | EMCS_REG_PLL_MASK);
	uda1380->regs[EMCS_REG] |=3D EMCS_REG_SC_256FS;
	uda1380->regs[EMCS_REG] |=3D pll;
	uda1380_write_reg(client, uda1380, EMCS_REG);
	PRDEBUG(3, "%s: %u\n", __FUNCTION__, __LINE__);

	uda1380->regs[I2S_REG] =3D ((uda1380->regs[I2S_REG] & ~(I2S_REG_SFORO_MASK=
 | I2S_REG_SFORI_MASK)) |
				  (FMT_I2S << I2S_REG_SFORO_SHIFT) | (FMT_I2S << I2S_REG_SFORI_SHIFT));
	uda1380_write_reg(client, uda1380, I2S_REG);
	PRDEBUG(3, "%s: %u\n", __FUNCTION__, __LINE__);

	uda1380->regs[PWR_REG] &=3D ~PWR_REG_PON_PLL;
	uda1380_write_reg(client, uda1380, PWR_REG);
	PRDEBUG(3, "%s: %u\n", __FUNCTION__, __LINE__);
	mdelay(5);

	uda1380->regs[PWR_REG] |=3D PWR_REG_PON_PLL;
	uda1380_write_reg(client, uda1380, PWR_REG);
	PRDEBUG(3, "%s: %u\n", __FUNCTION__, __LINE__);
	mdelay(5);
}


int uda1380_mute(struct i2c_client *client, int mute)=20
{
	int ret;
	uda1380_t *uda1380 =3D container_of(client, uda1380_t, client);

	PRDEBUG(2, "%s(client=3D%p,mute=3D%d) uda1380=3D%p\n", __FUNCTION__, clien=
t, mute, uda1380);
=09
	ret =3D (uda1380->regs[MMCDM_REG] & MMCDM_MASTER_MUTE) > 0;

	if (mute)
		uda1380->regs[MMCDM_REG] |=3D MMCDM_MASTER_MUTE;
	else
		uda1380->regs[MMCDM_REG] &=3D ~MMCDM_MASTER_MUTE;

	uda1380_write_reg(client, uda1380, MMCDM_REG);
	PRDEBUG(3, "%s: %u\n", __FUNCTION__, __LINE__);

	return ret;
}


/* The private value of the controls. */
enum
{
	UDAC_MASTER_PLAYBACK_VOLUME,
	UDAC_MASTER_PLAYBACK_MUTE,
	UDAC_ANALOG_PLAYBACK_VOLUME,
	UDAC_STRENGTH,
	UDAC_BASS,
	UDAC_TREBLE,
	UDAC_DEEMP,
	UDAC_PCM_CAPTURE_VOLUME,
	UDAC_MIC_GAIN,
	UDAC_LINE_GAIN,
	UDAC_LINE_MUTE,
	UDAC_MIC_SW,
	UDAC_LAST
};


static int=20
snd_uda1380_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
{
	static const char *strengths[]	=3D {"minimum", "flat", "maximum"};
	static const char *deemps[]	=3D {"off", "32kHz", "44.1kHz", "48kHz", "96kH=
z"};

	PRDEBUG(4, "%s(%p,%p) private_value=3D%ld\n",
		__FUNCTION__,
		kcontrol, uinfo,
		kcontrol->private_value);

	switch (kcontrol->private_value) {
	case UDAC_MASTER_PLAYBACK_VOLUME:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 2;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 0xFF;
		return 0;
	case UDAC_PCM_CAPTURE_VOLUME:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 2;
		uinfo->value.integer.min =3D -128;
		uinfo->value.integer.max =3D 0x30;
		return 0;
	case UDAC_MASTER_PLAYBACK_MUTE:
	case UDAC_LINE_MUTE:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
		uinfo->count =3D 1;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 1;
		return 0;
	case UDAC_ANALOG_PLAYBACK_VOLUME:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 2;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 0x3F;
		return 0;
	case UDAC_BASS:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 2;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 0x0F;
		return 0;
	case UDAC_TREBLE:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 2;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 0x03;
		return 0;
	case UDAC_STRENGTH:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
		uinfo->count =3D 1;
		uinfo->value.enumerated.items =3D ARRAY_SIZE(strengths);
		if (uinfo->value.enumerated.item >=3D ARRAY_SIZE(strengths))
			uinfo->value.enumerated.item =3D ARRAY_SIZE(strengths) - 1;
		strncpy(uinfo->value.enumerated.name,
			strengths[uinfo->value.enumerated.item],
			sizeof(uinfo->value.enumerated.name));
		return 0;
	case UDAC_LINE_GAIN:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 2;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 8;
		return 0;
	case UDAC_MIC_GAIN:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
		uinfo->count =3D 1;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 15;
		return 0;
	case UDAC_DEEMP:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
		uinfo->count =3D 1;
		uinfo->value.enumerated.items =3D ARRAY_SIZE(deemps);
		if (uinfo->value.enumerated.item >=3D ARRAY_SIZE(deemps))
			uinfo->value.enumerated.item =3D ARRAY_SIZE(deemps) - 1;
		strncpy(uinfo->value.enumerated.name,
			deemps[uinfo->value.enumerated.item],
			sizeof(uinfo->value.enumerated.name));
		return 0;
	case UDAC_MIC_SW:
		uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
		uinfo->count =3D 1;
		uinfo->value.integer.min =3D 0;
		uinfo->value.integer.max =3D 1;
		return 0;
	}
	printk(KERN_WARNING "%s called with bad private info: %ld\n", __FUNCTION__=
, kcontrol->private_value);
	return -EINVAL;
}


#if defined(UDA1380_DEBUG)
static const char *kontrol_value_names[] =3D {
	"MASTER_PLAYBACK_VOLUME",
	"MASTER_PLAYBACK_MUTE",
	"ANALOG_PLAYBACK_VOLUME",
	"STRENGTH",
	"BASS",
	"TREBLE",
	"DEEMP",
	"PCM_CAPTURE_VOLUME",
	"MIC_GAIN",
	"LINE_GAIN",
	"LINE_MUTE",
	"MIC_SW",
	"LAST",

	"<INVALID>"
};
#endif


static int=20
snd_uda1380_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
{
	uda1380_t *uda1380 =3D snd_kcontrol_chip(kcontrol);
	struct i2c_client *client =3D &uda1380->client;
	uint8_t newregnum;
	uint16_t val;

#if defined(UDA1380_DEBUG)
	if (4 <=3D debug)
	{
		size_t i =3D kcontrol->private_value;
		if (i >=3D ARRAY_SIZE(kontrol_value_names))
			i =3D ARRAY_SIZE(kontrol_value_names) - 1;
		PRDEBUG(4, "%s(%p,%p) value=3D%s int_values=3D%ld/%ld uda1380=3D%p client=
=3D%p\n",
			__FUNCTION__,
			kcontrol, ucontrol,
			kontrol_value_names[i],
			ucontrol->value.integer.value[0], ucontrol->value.integer.value[1],
			uda1380, client);
	}
#endif

	switch (kcontrol->private_value)
	{
	case UDAC_STRENGTH:
		switch (uda1380->strength =3D ucontrol->value.integer.value[0])
		{
		case 0:
			val =3D 1;
			break;
		case 2:
			val =3D 3;
			break;
		default:
			val =3D 0;
			break;
		}

		uda1380->regs[MBT_REG] &=3D ~(MBT_MODE_MASK);
		uda1380->regs[MBT_REG] |=3D val << MBT_MODE_SHIFT;
		newregnum =3D MBT_REG;
		break;

	case UDAC_DEEMP:
		val =3D uda1380->deemp =3D ucontrol->value.enumerated.item[0];
		if (val > 4)
			val =3D 4;
		uda1380->regs[MMCDM_REG] &=3D ~(MMCDM_CHANNEL1_DEEMPHASIS_MASK | MMCDM_CH=
ANNEL2_DEEMPHASIS_MASK);
		uda1380->regs[MMCDM_REG] |=3D (val << MMCDM_CHANNEL2_DEEMPHASIS_SHIFT) | =
(val << MMCDM_CHANNEL1_DEEMPHASIS_SHIFT);
		newregnum =3D MMCDM_REG;
		return 0;

	case UDAC_MASTER_PLAYBACK_MUTE:
		if ((uda1380->playback_mute =3D ucontrol->value.integer.value[0]))
			uda1380->regs[MMCDM_REG] &=3D ~MMCDM_MASTER_MUTE;
		else
			uda1380->regs[MMCDM_REG] |=3D MMCDM_MASTER_MUTE;
		newregnum =3D MMCDM_REG;
		break;

	case UDAC_MIC_GAIN:
		uda1380->mic_gain =3D ucontrol->value.integer.value[0] & 0x0F;
		uda1380->regs[DEC_ADC_REG] &=3D ~DEC_ADC_VGA_CTRL_MASK;
		uda1380->regs[DEC_ADC_REG] |=3D DEC_ADC_VGA_CTRL(uda1380->mic_gain);
		if (uda1380->mic_gain)
			uda1380->regs[DEC_ADC_REG] |=3D DEC_ADC_SEL_LNA | DEC_ADC_SEL_MIC;
		else
			uda1380->regs[DEC_ADC_REG] &=3D ~ (DEC_ADC_SEL_LNA | DEC_ADC_SEL_MIC);
		newregnum =3D DEC_ADC_REG;	=09
		break;

	case UDAC_MIC_SW:
		if ((uda1380->mic_sw =3D ucontrol->value.integer.value[0]))
			uda1380->regs[DEC_ADC_REG] |=3D DEC_ADC_SEL_LNA | DEC_ADC_SEL_MIC;
		else
			uda1380->regs[DEC_ADC_REG] &=3D ~ (DEC_ADC_SEL_LNA | DEC_ADC_SEL_MIC);
		newregnum =3D DEC_ADC_REG;
		break;

	case UDAC_LINE_MUTE:
		if ((uda1380->line_mute =3D ucontrol->value.integer.value[0]))
			uda1380->regs[DPM_REG] &=3D ~DPM_MUTE_ADC;
		else
			uda1380->regs[DPM_REG] |=3D DPM_MUTE_ADC;
		newregnum =3D DPM_REG;	=09
		break;

	case UDAC_MASTER_PLAYBACK_VOLUME:
		uda1380->master_playback_volume.left =3D ucontrol->value.integer.value[0]=
 & 0xFF;
		uda1380->master_playback_volume.right =3D ucontrol->value.integer.value[1=
] & 0xFF;
		uda1380->regs[MASTER_VOL_REG] =3D (MASTER_VCL(0xFF - uda1380->master_play=
back_volume.left) |
						 MASTER_VCR(0xFF - uda1380->master_playback_volume.right));
		newregnum =3D MASTER_VOL_REG;
		break;

	case UDAC_ANALOG_PLAYBACK_VOLUME:
		uda1380->analog_playback_volume.left =3D ucontrol->value.integer.value[0]=
 & 0x3F;
		uda1380->analog_playback_volume.right =3D ucontrol->value.integer.value[1=
] & 0x3F;
		uda1380->regs[AMIX_REG] =3D (AMIX_AVCL(0x3F - uda1380->analog_playback_vo=
lume.left) |
					   AMIX_AVCR(0x3F - uda1380->analog_playback_volume.right));
		newregnum =3D AMIX_REG;
		break;

	case UDAC_PCM_CAPTURE_VOLUME:
		uda1380->pcm_capture_volume.left =3D ucontrol->value.integer.value[0];
		if (uda1380->pcm_capture_volume.left < -128)
			uda1380->pcm_capture_volume.left =3D -128;
		else if (uda1380->pcm_capture_volume.left > 0x30)
			uda1380->pcm_capture_volume.left =3D 0x30;

		uda1380->pcm_capture_volume.right =3D ucontrol->value.integer.value[1];
		if (uda1380->pcm_capture_volume.right < -128)
			uda1380->pcm_capture_volume.right =3D -128;
		else if (uda1380->pcm_capture_volume.right > 0x30)
			uda1380->pcm_capture_volume.right =3D 0x30;

		uda1380->regs[DEC_VOL_REG] &=3D ~(DEC_VCL_MASK | DEC_VCR_MASK);
		val =3D uda1380->pcm_capture_volume.left & 0xFF;
		uda1380->regs[DEC_VOL_REG] |=3D DEC_VCL(val);
		val =3D uda1380->pcm_capture_volume.right & 0xFF;
		uda1380->regs[DEC_VOL_REG] |=3D DEC_VCR(val);
		newregnum =3D DEC_VOL_REG;	=09
		break;

	case UDAC_BASS:
		uda1380->bass.left =3D ucontrol->value.integer.value[0] & 0x0F;
		uda1380->bass.right =3D ucontrol->value.integer.value[1] & 0x0F;
		uda1380->regs[MBT_REG] &=3D ~(MBT_BBL_MASK | MBT_BBR_MASK);
		uda1380->regs[MBT_REG] |=3D MBT_BBL(uda1380->bass.left) | MBT_BBR(uda1380=
=2D>bass.right);
		newregnum =3D MBT_REG;
		break;

	case UDAC_TREBLE:
		uda1380->treble.left =3D ucontrol->value.integer.value[0] & 0x03;
		uda1380->treble.right =3D ucontrol->value.integer.value[1] & 0x03;
		uda1380->regs[MBT_REG] &=3D ~(MBT_TRL_MASK | MBT_TRR_MASK);
		uda1380->regs[MBT_REG] |=3D MBT_TRL(uda1380->treble.left) | MBT_TRR(uda13=
80->treble.right);
		newregnum =3D MBT_REG;
		break;

	case UDAC_LINE_GAIN:
		uda1380->line_gain.left =3D ucontrol->value.integer.value[0] & 0x0F;
		uda1380->line_gain.right =3D ucontrol->value.integer.value[1] & 0x0F;
		uda1380->regs[DPM_REG] &=3D ~(DPM_GAINL_MASK | DPM_GAINR_MASK);
		uda1380->regs[DPM_REG] |=3D DPM_GAINL(uda1380->line_gain.left) | DPM_GAIN=
R(uda1380->line_gain.right);
		newregnum =3D DPM_REG;	=09
		break;	=09

	default:
		return -EINVAL;
	}

	return uda1380_write_reg(client, uda1380, newregnum);
}


static int=20
snd_uda1380_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
{
	uda1380_t *uda1380 =3D snd_kcontrol_chip(kcontrol);

	PRDEBUG(4, "%s(%p,%p) value=3D%ld uda1380=3D%p\n",
		__FUNCTION__,
		kcontrol, ucontrol,
		kcontrol->private_value,
		uda1380);

	switch (kcontrol->private_value)
	{
	case UDAC_STRENGTH:
		ucontrol->value.enumerated.item[0] =3D uda1380->strength;
		return 0;
	case UDAC_DEEMP:
		ucontrol->value.enumerated.item[0] =3D uda1380->deemp;
		return 0;
	case UDAC_MASTER_PLAYBACK_MUTE:
		ucontrol->value.enumerated.item[0] =3D uda1380->playback_mute;
		return 0;
	case UDAC_MIC_GAIN:
		ucontrol->value.integer.value[0] =3D uda1380->mic_gain;
		return 0;
	case UDAC_MIC_SW:
		ucontrol->value.integer.value[0] =3D uda1380->mic_sw;
		return 0;
	case UDAC_LINE_MUTE:
		ucontrol->value.integer.value[0] =3D uda1380->line_mute;
		return 0;
	case UDAC_MASTER_PLAYBACK_VOLUME:
		ucontrol->value.integer.value[0] =3D uda1380->master_playback_volume.left;
		ucontrol->value.integer.value[1] =3D uda1380->master_playback_volume.righ=
t;
		return 0;
	case UDAC_ANALOG_PLAYBACK_VOLUME:
		ucontrol->value.integer.value[0] =3D uda1380->analog_playback_volume.left;
		ucontrol->value.integer.value[1] =3D uda1380->analog_playback_volume.righ=
t;
		return 0;
	case UDAC_PCM_CAPTURE_VOLUME:
		ucontrol->value.integer.value[0] =3D uda1380->pcm_capture_volume.left;
		ucontrol->value.integer.value[1] =3D uda1380->pcm_capture_volume.right;
		return 0;
	case UDAC_BASS:
		ucontrol->value.integer.value[0] =3D uda1380->bass.left;
		ucontrol->value.integer.value[1] =3D uda1380->bass.right;
		return 0;
	case UDAC_TREBLE:
		ucontrol->value.integer.value[0] =3D uda1380->treble.left;
		ucontrol->value.integer.value[1] =3D uda1380->treble.right;
		return 0;
	case UDAC_LINE_GAIN:
		ucontrol->value.integer.value[0] =3D uda1380->line_gain.left;
		ucontrol->value.integer.value[1] =3D uda1380->line_gain.right;
		return 0;
	}
	printk(KERN_WARNING "%s called with bad private info: %ld\n", __FUNCTION__=
, kcontrol->private_value);
	return -EINVAL;
}


#define UDA1380(xname, pvt_value) \
{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
  .name =3D xname, \
  .info =3D snd_uda1380_info, \
  .get =3D snd_uda1380_get, \
  .put =3D snd_uda1380_put, \
  .private_value =3D pvt_value \
}


static snd_kcontrol_new_t snd_uda1380_controls[] =3D
{
	UDA1380("Master Playback Volume",	UDAC_MASTER_PLAYBACK_VOLUME),
	UDA1380("Master Playback Switch",	UDAC_MASTER_PLAYBACK_MUTE),
	UDA1380("Line Bypass Playback Volume",	UDAC_ANALOG_PLAYBACK_VOLUME),
	UDA1380("Tone Control - Strenght",	UDAC_STRENGTH),
	UDA1380("Tone Control - Bass",		UDAC_BASS),
	UDA1380("Tone Control - Treble",	UDAC_TREBLE),
	UDA1380("De-emphasis",			UDAC_DEEMP),
	UDA1380("Capture Volume",		UDAC_PCM_CAPTURE_VOLUME),
	UDA1380("Mic Capture Gain",		UDAC_MIC_GAIN),
	UDA1380("Line Capture Volume",		UDAC_LINE_GAIN),
	UDA1380("Line Capture Switch",		UDAC_LINE_MUTE),
	UDA1380("Mic Capture Switch",		UDAC_MIC_SW),
};


/* initialization stuff */

static struct i2c_client client_template =3D {
	name: "(unset)",
	flags:  I2C_CLIENT_ALLOW_USE,
	driver: &uda1380_driver
};


static int uda1380_attach(struct i2c_adapter *adap, int addr, unsigned shor=
t flags, int zero_or_minus_one)	=09
{
	uda1380_t *uda1380;
	struct i2c_client *client;
	int i;

	PRDEBUG(2,
		"%s(adap=3D%p,addr=3D%02x,flags=3D%u,zomo=3D%d)\n",
		__FUNCTION__,
		adap, addr, flags, zero_or_minus_one);

	uda1380 =3D kmalloc(sizeof(*uda1380), GFP_KERNEL);
	if (!uda1380)
		return -ENODEV;

	PRDEBUG(2, "%s: uda1380=3D%p created\n", __FUNCTION__, uda1380);

	memset(uda1380, 0, sizeof(*uda1380));

	/* set default values of registers */
	for (i =3D 0; i < ARRAY_SIZE(uda1380_reg_info); i++)
	{
		PRDEBUG(3, "%s: reg[%u] =3D 0x%04x\n",
			__FUNCTION__,
			uda1380_reg_info[i].num, uda1380_reg_info[i].default_value);

		uda1380->regs[uda1380_reg_info[i].num] =3D uda1380_reg_info[i].default_va=
lue;
	}

	client =3D &uda1380->client;
	memcpy(client, &client_template, sizeof(*client));
	client->adapter =3D adap;
	client->addr =3D addr;
	strcpy(client->name, "uda1380");

	i2c_attach_client(client);

	return 0;
}


static int uda1380_detach_client(struct i2c_client *client)
{
	uda1380_t *uda1380 =3D container_of(client, uda1380_t, client);

	PRDEBUG(2, "%s(%p) uda1380=3D%p\n", __FUNCTION__, client, uda1380);
	i2c_detach_client(client);
	PRDEBUG(2, "%s: freeing %p\n", __FUNCTION__, uda1380);
	kfree(uda1380);
	PRDEBUG(2, "%s: freed %p\n", __FUNCTION__, uda1380);
	return 0;
}


#define UDA1380_I2C_DEFAULT_ADDRESS     (0x30U >> 1)

/* Addresses to scan */
static unsigned short normal_i2c[] =3D 	{UDA1380_I2C_DEFAULT_ADDRESS, I2C_C=
LIENT_END};
static unsigned short normal_i2c_range[] =3D {I2C_CLIENT_END};
static unsigned short probe[]        =3D	{ I2C_CLIENT_END, I2C_CLIENT_END };
static unsigned short probe_range[]  =3D	{ I2C_CLIENT_END, I2C_CLIENT_END };
static unsigned short ignore[]       =3D	{ I2C_CLIENT_END, I2C_CLIENT_END };
static unsigned short ignore_range[] =3D	{ I2C_CLIENT_END, I2C_CLIENT_END };
static unsigned short force[]        =3D	{ I2C_CLIENT_END, I2C_CLIENT_END };

static struct i2c_client_address_data addr_data =3D {
	normal_i2c, normal_i2c_range,=20
	probe, probe_range,=20
	ignore, ignore_range,=20
	force
};

static int uda1380_attach_adapter(struct i2c_adapter *adap)
{
	PRDEBUG(2, "%s(adap=3D%p)\n", __FUNCTION__, adap);
	return i2c_probe(adap, &addr_data, uda1380_attach);
}

static void uda1380_inc_use(struct i2c_client *client)
{
	PRDEBUG(2, "%s:\n", __FUNCTION__);
	MOD_INC_USE_COUNT;
}


static void uda1380_dec_use(struct i2c_client *client)
{
	PRDEBUG(2, "%s:\n", __FUNCTION__);
	MOD_DEC_USE_COUNT;
}


static struct i2c_driver uda1380_driver =3D
{
	.name		=3D "UDA1380",
	.id		=3D I2C_DRIVERID_UDA1380,
	.flags		=3D I2C_DF_NOTIFY,
	.attach_adapter	=3D uda1380_attach_adapter,
	.detach_client	=3D uda1380_detach_client,
	.inc_use	=3D uda1380_inc_use,
	.dec_use	=3D uda1380_dec_use
};


int snd_chip_uda1380_mixer_new(snd_card_t *_card, struct i2c_client **_clie=
nt, int _mic_enable)
{
	size_t i;
	size_t n =3D 0;
	int err;
	struct i2c_client *client;
	uda1380_t *uda1380;

	MOD_INC_USE_COUNT;

	PRDEBUG(2, "%s(card=3D%p,_client=3D%p)\n", __FUNCTION__, _card, _client);
       =20
	snd_assert(_card !=3D NULL, return -EINVAL);

	client =3D i2c_get_client(I2C_DRIVERID_UDA1380, I2C_ALGO_MPC5xxx, NULL);
	*_client =3D client;

	if (!client)
	{
		printk(KERN_ERR "uda1380: error: cannot get i2c client\n");
		MOD_DEC_USE_COUNT;
		return -ENODEV;
	}

	uda1380 =3D container_of(client, uda1380_t, client);
	uda1380->mic_enable =3D _mic_enable;
=20
	PRDEBUG(1, "%s: i2c_get_client returned client=3D%p uda1380=3D%p\n", __FUN=
CTION__, client, uda1380);

	for (i =3D 0; i < ARRAY_SIZE(snd_uda1380_controls); i++) {
		if ((snd_uda1380_controls[i].private_value !=3D UDAC_MIC_SW &&
		     snd_uda1380_controls[i].private_value !=3D UDAC_MIC_GAIN) ||
		    _mic_enable)
		{
			if ((err =3D snd_ctl_add(_card, snd_ctl_new1(&snd_uda1380_controls[i], u=
da1380))) < 0)
			{
				MOD_DEC_USE_COUNT;
				return err;
			}
			n++;
		}
	}

	PRDEBUG(2, "added %u controls\n", n);
	strncpy(_card->mixername, "UDA1380 Mixer", sizeof(_card->mixername));

	return 0;
}


void snd_chip_uda1380_mixer_del(snd_card_t *_card, struct i2c_client *_clie=
nt)
{
	PRDEBUG(2, "%s(%p,%p)\n", __FUNCTION__, _card, _client);
	MOD_DEC_USE_COUNT;
}


static int __init uda1380_init(void)
{
	PRDEBUG(2, "%s\n", __FUNCTION__);
#if defined(UDA1380_DEBUG)
	printk(KERN_INFO "%s: debug=3D%d\n", __FUNCTION__, debug);
#else
	if (debug !=3D -1)
		printk(KERN_WARNING "%s: compiled without debug support\n", __FUNCTION__);
#endif
	return i2c_add_driver(&uda1380_driver);
}

static void __exit uda1380_exit(void)
{
	PRDEBUG(2, "%s\n", __FUNCTION__);
	i2c_del_driver(&uda1380_driver);
}


module_init(uda1380_init);
module_exit(uda1380_exit);

EXPORT_SYMBOL(uda1380_mute);
EXPORT_SYMBOL(uda1380_configure);
EXPORT_SYMBOL(snd_chip_uda1380_mixer_new);
EXPORT_SYMBOL(snd_chip_uda1380_mixer_del);

MODULE_AUTHOR("Giorgio Padrin");
MODULE_DESCRIPTION("Philips UDA1380 codec driver");
MODULE_LICENSE("GPL");

#if defined(UDA1380_DEBUG)
MODULE_PARM(debug, "i");
MODULE_PARM_DESC(debug, "debug level (0-6)");
#endif

--Boundary-01=_Si/fFHPjgOphdxQ
Content-Type: text/x-chdr;
  charset="iso-8859-1";
  name="uda1380.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uda1380.h"

/*
 * Sound driver for Philips uda1380 - i2c related stuff
 *
 * Copyright (C) 2005 Roman Fietze <roman.fietze@telemotive.de>
 * Copyright (C) 2004 Giorgio Padrin
 *
 * This file is subject to the terms and conditions of the GNU General Publ=
ic
 * License.  See the file COPYING in the main directory of this archive for
 * more details.
 *
 * based on code by:
 *=20
 * Copyright (c) 2002 Hewlett-Packard Company
 * Copyright (c) 2000 Nicolas Pitre <nico@cam.org>
 */

#ifndef _UDA1380_H_
#define _UDA1380_H_

#include <sound/driver.h>
#include <sound/core.h>
#include <sound/control.h>
#include <sound/initval.h>
#include <sound/info.h>
#include <linux/i2c.h>

#ifndef container_of
#define container_of    list_entry
#endif

#define FMT_I2S		0
#define FMT_LSB16	1
#define FMT_LSB18	2
#define FMT_LSB20	3
#define FMT_MSB		5


#define REG_MAX 0x24

#define EMCS_REG			0x00

#define EMCS_REG_EN_ADC			(1 << 11)
#define EMCS_REG_EN_DEC			(1 << 10)
#define EMCS_REG_EN_DAC			(1 <<  9)
#define EMCS_REG_EN_INT			(1 <<  8)
#define EMCS_REG_ADC_USE_WSPLL		(1 <<  5)
#define EMCS_REG_ADC_USE_SYSCLK		(0 <<  5)
#define EMCS_REG_DAC_USE_WSPLL		(1 <<  4)
#define EMCS_REG_DAC_USE_SYSCLK		(0 <<  4)

#define EMCS_REG_SC_MASK		(3 <<  2)
#define EMCS_REG_SC_768FS		(3 <<  2)
#define EMCS_REG_SC_512FS		(2 <<  2)
#define EMCS_REG_SC_384FS		(1 <<  2)
#define EMCS_REG_SC_256FS		(0 <<  2)

#define EMCS_REG_PLL_MASK		(3 <<  0)
#define EMCS_REG_PLL_6TO12		(0 <<  0)
#define EMCS_REG_PLL_12TO25		(1 <<  0)
#define EMCS_REG_PLL_25TO50		(2 <<  0)
#define EMCS_REG_PLL_50TO100		(3 <<  0)

#define I2S_REG				0x01

#define I2S_REG_SFORO_MASK		(7 << 0)
#define I2S_REG_SFORO_SHIFT		0
#define I2S_REG_SFORI_MASK		(7 << 8)
#define I2S_REG_SFORI_SHIFT		8
#define I2S_REG_SEL_DECIMATOR		(0 << 6)
#define I2S_REG_SEL_MIXER		(1 << 6)
#define I2S_REG_SIM_SLAVE		(0 << 4)
#define I2S_REG_SIM_MASTER		(1 << 4)

#define PWR_REG				0x02

#define PWR_REG_PON_PLL			(1 << 15)
#define PWR_REG_PON_HP			(1 << 13)
#define PWR_REG_PON_DAC			(1 << 10)
#define PWR_REG_PON_BIAS		(1 << 8)
#define PWR_REG_EN_AVC			(1 << 7)
#define PWR_REG_PON_AVC			(1 << 6)
#define PWR_REG_PON_LNA			(1 << 4)
#define PWR_REG_PON_PGAL		(1 << 3)
#define PWR_REG_PON_ADCL		(1 << 2)
#define PWR_REG_PON_PGAR		(1 << 1)
#define PWR_REG_PON_ADCR		(1 << 0)

/* analog mixer */
#define AMIX_REG			0x03

#define AMIX_AVCL(x)			(((x) & 0x3f) << 8)
#define AMIX_AVCL_MASK			(0x3f << 8)
#define AMIX_AVCR(x)			(((x) & 0x3f) << 0)
#define AMIX_AVCR_MASK			(0x3f << 0)

/* digital master volume control register */
#define MASTER_VOL_REG			0x10

#define MASTER_VCL(x)			(((x) & 0xff) << 8)
#define MASTER_VCL_MASK			(0xff << 8)
#define MASTER_VCR(x)			(((x) & 0xff) << 0)
#define MASTER_VCR_MASK			(0xff << 0)

/* digital mixer control register */
#define MIXER_VOL_REG			0x11

#define MIXER_VC_CH2(x)			(((x) & 0xff) << 8)
#define MIXER_VC_CH2_MASK		(0xff << 8)
#define MIXER_VC_CH1(x)			(((x) & 0xff) << 0)
#define MIXER_VC_CH1_MASK		(0xff << 0)

/* mode, bass boost, treble */
#define MBT_REG				0x12
#define MBT_MODE_MASK			(3 << 14)
#define MBT_MODE_FLAT			(0 << 14)
#define MBT_MODE_MIN			(1 << 14)
#define MBT_MODE_MAX			(3 << 14)
#define MBT_MODE_SHIFT			(14)
#define MBT_TRL_WIDTH			2
#define MBT_TRL_MASK			(3 << 12)
#define MBT_TRL(x)			((x) << 12)
#define MBT_TRR_MASK			(3 << 4)
#define MBT_TRR(x)			((x) << 4)
#define MBT_BBL_WIDTH			4
#define MBT_BBL_MASK			(0xf << 8)
#define MBT_BBL(x)			((x) << 8)
#define MBT_BBR_MASK			(0xf << 0)
#define MBT_BBR(x)			((x) << 0)

/* channel2 is from decimation filter */
/* channel1 is from digital data from I2S */

#define MMCDM_REG			0x13
#define MMCDM_MASTER_MUTE		(1 << 14)
#define MMCDM_CHANNEL2_MUTE		(1 << 11)
#define MMCDM_CHANNEL2_DEEMPHASIS_OFF	(0 << 8)
#define MMCDM_CHANNEL2_DEEMPHASIS_32KHZ	(1 << 8)
#define MMCDM_CHANNEL2_DEEMPHASIS_44KHZ	(2 << 8)
#define MMCDM_CHANNEL2_DEEMPHASIS_48KHZ	(3 << 8)
#define MMCDM_CHANNEL2_DEEMPHASIS_96KHZ	(4 << 8)
#define MMCDM_CHANNEL2_DEEMPHASIS_MASK	(7 << 8)
#define MMCDM_CHANNEL2_DEEMPHASIS_SHIFT	(8)
#define MMCDM_CHANNEL1_MUTE		(1 << 3)
#define MMCDM_CHANNEL1_DEEMPHASIS_32KHZ	(1 << 0)
#define MMCDM_CHANNEL1_DEEMPHASIS_44KHZ	(2 << 0)
#define MMCDM_CHANNEL1_DEEMPHASIS_48KHZ	(3 << 0)
#define MMCDM_CHANNEL1_DEEMPHASIS_96KHZ	(4 << 0)
#define MMCDM_CHANNEL1_DEEMPHASIS_MASK	(7 << 0)
#define MMCDM_CHANNEL1_DEEMPHASIS_SHIFT	(0)

#define MIXER_CTL_REG			0x14

#define MIXER_CTL_DAC_POLARITY_INVERT	(1 << 15)
#define MIXER_CTL_SEL_5TH_ORDER_NS	(1 << 14)
#define MIXER_CTL_MIX_POS	        (1 << 13)
#define MIXER_CTL_MIX		        (1 << 12)
#define MIXER_CTL_SILENCE	        (1 << 7)
#define MIXER_CTL_SDET_ON	        (1 << 6)
#define MIXER_CTL_SDET_VALUE_MASK       (3 << 4)
#define MIXER_CTL_SDET_VALUE_SHIFT	4
#define MIXER_CTL_OVERSAMPLING_MASK     (3 << 0)
#define MIXER_CTL_OVERSAMPLING_SHIFT    0

#define DEC_VOL_REG			0x20

#define DEC_VCL(x)	(((x) & 0xff) << 8)
#define DEC_VCL_MASK	(0xff << 8)
#define DEC_VCR(x)	(((x) & 0xff) << 0)
#define DEC_VCR_MASK	(0xff << 0)

#define DPM_REG				0x21

#define DPM_MUTE_ADC	(1 << 15)
#define DPM_GAINL(x)	(((x) & 0xf) << 8)
#define DPM_GAINL_MASK	(0xf << 8)
#define DPM_GAINR(x)	(((x) & 0xf) << 0)
#define DPM_GAINR_MASK	(0xf << 0)

#define DEC_ADC_REG			0x22

#define DEC_ADC_POL_INV			(1 << 12)
#define DEC_ADC_VGA_CTRL(x)		((x) << 8)
#define DEC_ADC_VGA_CTRL_MASK		(0xf << 8)
#define DEC_ADC_SEL_LNA			(1 << 3)
#define DEC_ADC_SEL_MIC			(1 << 2)
#define DEC_ADC_SKIP_DCFIL		(1 << 1)
#define DEC_ADC_EN_DCFIL		(1 << 0)

#define DEC_AGC_REG			0x23

#define DEC_AGC_EN			(1 << 0)


int snd_chip_uda1380_mixer_new(snd_card_t *card, struct i2c_client **clnt, =
int _mic_enable);
void snd_chip_uda1380_mixer_del(snd_card_t *card, struct i2c_client *clnt);

// int uda1380_configure(struct i2c_client *client, struct uda1380_cfg *con=
f);
void uda1380_configure(struct i2c_client *client, long rate);
int uda1380_mute(struct i2c_client *clnt, int mute);

#endif /* _UDA1380_H_ */

--Boundary-01=_Si/fFHPjgOphdxQ
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="mpc5200-uda1380.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpc5200-uda1380.c"

/*
  Copyright (C) 2005 Roman Fietze, Telemotive AG

  Audio driver for the FreeScale MPC5200 PSC in I2S codec
  mode. Optionally using I2C to an UDA1380 to control the Codec.

  This code is released under GPL (GNU Public License) with absolutely
  no warranty. Please see http://www.gnu.org/ for a complete discussion
  of the GPL.

  based on code by:

  Copyright (C) 2003 Christian Pellegrin
  Copyright (C) 2000 Lernout & Hauspie Speech Products, N.V.
  Copyright (c) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
  Copyright (c) 2002 Hewlett-Packard Company
  Copyright (c) 2000 Nicolas Pitre <nico@cam.org>

*/

/*
  mpc5200-uda1380.c
*/


#include <linux/module.h>
#include <sound/driver.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/fs.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/sound.h>
#include <linux/soundcard.h>
#include <linux/i2c.h>
#include <linux/kmod.h>

#include <asm/semaphore.h>
#include <asm/uaccess.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/initval.h>
#include "../i2c/uda1380.h"

#include <asm/mpc5xxx_snd.h>

#undef SND_MPC5200_DEBUG
// #define SND_MPC5200_DEBUG

// #undef SND_MPC5200_SIMPLE_PROC
#define SND_MPC5200_SIMPLE_PROC

#if defined(SND_MPC5200_DEBUG)
#define PRDEBUG(level, format, x... )  do {if (level <= debug) printk(KERN_INFO format, ## x );} while (0)
#else
#define PRDEBUG(level, format, x... )	do {} while(0)
#endif


enum
{
	CMD_EXTSW	/* optional */
};


typedef enum _stream_id
{
	PLAYBACK	= 0,	/* playback stream index */
	CAPTURE,		/* capture stream index */

	NUM_STREAMS		/* every "card" or PSC can have up to two (snd_pcm_sub)streams */
} stream_id_t;

typedef struct _mpc5200_uda1380
{
	snd_card_t *card;
	snd_pcm_t *pcm;
	int cardid;
	struct i2c_client *uda1380;	/* optional, no mixer if NULL */
	int extsw;
	snd_info_entry_t *extsw_proc_entry;
#if !defined(SND_MPC5200_SIMPLE_PROC)
	wait_queue_head_t extsw_wait;
#endif
	long samplerate;
	snd_mpc5xxx_i2s_card_t *i2s_card;
	snd_mpc5xxx_i2s_substream_t *i2s_substreams[NUM_STREAMS];
} mpc5200_uda1380_t;

static const char DRIVER_KERNEL_NAME[] = "snd-mpc5200";
static const char DRIVER_NAME[] = "MPC5xxx I2S UDA1380";

static int debug = -1;

static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static int uda[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static int slave[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static int spi[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static int mic[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static int extsw[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static int loopback[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
static snd_card_t *cards[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* initialize to NULL */
static const int allowed[SNDRV_CARDS] = {0, 1, 1, 1, 0, 0, 1, 0}; /* allow PSC 1,2,3,6 */

#if !defined(SND_MPC5200_SIMPLE_PROC)
static char snd_mpc5200_extsw_data[2] = {'0', '\n'};
#endif

static void snd_mpc5200_uda1380_set_samplerate(mpc5200_uda1380_t *chip, long rate)
{
	struct i2c_client *uda1380 = chip->uda1380;
	int mute;

	PRDEBUG(1,
		"%s(id=%d,rate=%ld) chip->samplerate=%ld\n",
		__FUNCTION__,
		chip->cardid, rate,
		chip->samplerate);

	if (rate == chip->samplerate)
		return;

	mute = uda1380_mute(uda1380, 1);

	chip->samplerate = rate;
	udelay(125);

	uda1380_configure(uda1380, chip->samplerate = rate);
	uda1380_mute(uda1380, mute);

	PRDEBUG(1, "%s done\n", __FUNCTION__);
}


static const snd_pcm_hardware_t snd_mpc5200_playback_capture =
{
	.info			= (SNDRV_PCM_INFO_INTERLEAVED |
				   SNDRV_PCM_INFO_BLOCK_TRANSFER |
				   SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
	.formats		= SNDRV_PCM_FMTBIT_S16_BE,
	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min		= SND_PSC_AUDIO_RATE_MIN,
	.rate_max		= SND_PSC_AUDIO_RATE_MAX,
	.channels_min		= 2,
	.channels_max		= 2,
	.buffer_bytes_max	= SND_PSC_MAX_BUFFER_SIZE,
	.period_bytes_min	= SND_PSC_MIN_PERIOD_SIZE,
	.period_bytes_max	= SND_PSC_MAX_PERIOD_SIZE,
	.periods_min		= 1,
	.periods_max		= 1024,
	.fifo_size		= 0,
};

#if 0
static const snd_pcm_hardware_t snd_mpc5200_playback =
{
	.info			= (SNDRV_PCM_INFO_INTERLEAVED |
				   SNDRV_PCM_INFO_BLOCK_TRANSFER |
				   SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
	.formats		= SNDRV_PCM_FMTBIT_S16_BE,
	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min		= SND_PSC_AUDIO_RATE_MIN,
	.rate_max		= SND_PSC_AUDIO_RATE_MAX,
	.channels_min		= 2,
	.channels_max		= 2,
	.buffer_bytes_max	= SND_PSC_MAX_BUFFER_SIZE,
	.period_bytes_min	= SND_PSC_MIN_PERIOD_SIZE,
	.period_bytes_max	= SND_PSC_MAX_PERIOD_SIZE,
	.periods_min		= 1,
	.periods_max		= 1024,
	.fifo_size		= 0,
};
#endif

static int snd_card_mpc5200_playback_open(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	int err;

	PRDEBUG(1, "%s\n", __FUNCTION__);
	runtime->hw = snd_mpc5200_playback_capture;

	err = snd_psc_substream_open(chip->i2s_substreams[PLAYBACK], substream);
	if (err < 0)
		return err;

        if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                return err;

	return 0;
}


static int snd_card_mpc5200_playback_close(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	PRDEBUG(1, "%s\n", __FUNCTION__);
	return snd_psc_substream_close(chip->i2s_substreams[PLAYBACK]);
}


static int snd_card_mpc5200_playback_ioctl(snd_pcm_substream_t *substream,
					   unsigned int cmd,
					   void *arg)
{
	PRDEBUG(1, "%s(cmd=%d)\n", __FUNCTION__, cmd);
	return snd_pcm_lib_ioctl(substream, cmd, arg);
}


static int snd_card_mpc5200_playback_hw_params(snd_pcm_substream_t *substream,
					       snd_pcm_hw_params_t *hw_params)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	int err;

	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
	{
		if (err < 0)
			printk(KERN_ERR "%s: memory allocation failed\n", DRIVER_NAME);
		return err;
	}

	/* set requested samplerate on an optional UDA1380 */
	if (chip->uda1380)
		snd_mpc5200_uda1380_set_samplerate(chip, runtime->rate);

	return snd_psc_substream_params(chip->i2s_substreams[PLAYBACK],
					runtime->rate,
					runtime->channels,
					snd_pcm_format_width(runtime->format),
					snd_pcm_lib_buffer_bytes(substream),
					snd_pcm_lib_period_bytes(substream));
}


static int snd_card_mpc5200_playback_prepare(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;

	/* set requested samplerate on an optional UDA1380 */
	if (chip->uda1380)
		snd_mpc5200_uda1380_set_samplerate(chip, runtime->rate);

	return snd_psc_substream_params(chip->i2s_substreams[PLAYBACK],
					runtime->rate,
					runtime->channels,
					snd_pcm_format_width(runtime->format),
					snd_pcm_lib_buffer_bytes(substream),
					snd_pcm_lib_period_bytes(substream));
}


static int snd_card_mpc5200_playback_trigger(snd_pcm_substream_t *substream, int cmd)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);

	switch (cmd)
	{
	case SNDRV_PCM_TRIGGER_START:
		PRDEBUG(1, "%s(%p,START)\n", __FUNCTION__, substream);
		return snd_psc_substream_start(chip->i2s_substreams[PLAYBACK],
					       substream->runtime->dma_addr);

	case SNDRV_PCM_TRIGGER_STOP:
		PRDEBUG(1, "%s(%p,STOP)\n", __FUNCTION__, substream);
		return snd_psc_substream_stop(chip->i2s_substreams[PLAYBACK]);
	}

	return -EINVAL;
}


static snd_pcm_uframes_t snd_card_mpc5200_playback_pointer(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	size_t ret = snd_psc_get_substream_pos(chip->i2s_substreams[PLAYBACK]);
	PRDEBUG(3, "%s returns %u\n", __FUNCTION__, ret);
	return bytes_to_frames(substream->runtime, ret);
}


static void snd_card_mpc5200_playback_capture_irq(void *_substream)
{
	snd_pcm_substream_t *substream = _substream;
	PRDEBUG(3, "%s(%p)\n", __FUNCTION__, substream);
	snd_pcm_period_elapsed(substream);
	return IRQ_HANDLED;
}


static int snd_card_mpc5200_capture_open(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	int err;

	PRDEBUG(1, "%s\n", __FUNCTION__);

	runtime->hw = snd_mpc5200_playback_capture;

	err = snd_psc_substream_open(chip->i2s_substreams[CAPTURE], substream);
	if (err < 0)
		return err;

        if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                return err;

	return 0;
}


static int snd_card_mpc5200_capture_close(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	PRDEBUG(1, "%s:\n", __FUNCTION__);
	return snd_psc_substream_close(chip->i2s_substreams[CAPTURE]);
}


static int snd_card_mpc5200_capture_ioctl(snd_pcm_substream_t *substream,
					  unsigned int cmd, void *arg)
{
	PRDEBUG(1, "%s:\n", __FUNCTION__);
	return snd_pcm_lib_ioctl(substream, cmd, arg);
}


static int snd_card_mpc5200_capture_hw_params(snd_pcm_substream_t *substream,
					      snd_pcm_hw_params_t *hw_params)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	int err;

	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
	{
		if (err < 0)
			printk(KERN_ERR "%s: memory allocation failed\n", DRIVER_NAME);
		return err;
	}

	/* set requested samplerate on an optional UDA1380 */
	if (chip->uda1380)
		snd_mpc5200_uda1380_set_samplerate(chip, runtime->rate);

	return snd_psc_substream_params(chip->i2s_substreams[CAPTURE],
					runtime->rate,
					runtime->channels,
					snd_pcm_format_width(runtime->format),
					snd_pcm_lib_buffer_bytes(substream),
					snd_pcm_lib_period_bytes(substream));
}


static int snd_card_mpc5200_capture_prepare(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;

	/* set requested samplerate on an optional UDA1380 */
	if (chip->uda1380)
		snd_mpc5200_uda1380_set_samplerate(chip, runtime->rate);

	return snd_psc_substream_params(chip->i2s_substreams[CAPTURE],
					runtime->rate,
					runtime->channels,
					snd_pcm_format_width(runtime->format),
					snd_pcm_lib_buffer_bytes(substream),
					snd_pcm_lib_period_bytes(substream));
}


static int snd_card_mpc5200_capture_trigger(snd_pcm_substream_t *substream, int cmd)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);

	switch (cmd)
	{
	case SNDRV_PCM_TRIGGER_START:
		PRDEBUG(1, "%s(%p,START)\n", __FUNCTION__, substream);
		return snd_psc_substream_start(chip->i2s_substreams[CAPTURE],
					       substream->runtime->dma_addr);

	case SNDRV_PCM_TRIGGER_STOP:
		PRDEBUG(1, "%s(%p,STOP)\n", __FUNCTION__, substream);
		return snd_psc_substream_stop(chip->i2s_substreams[CAPTURE]);
	}

	return -EINVAL;
}


static snd_pcm_uframes_t snd_card_mpc5200_capture_pointer(snd_pcm_substream_t *substream)
{
	mpc5200_uda1380_t *chip = snd_pcm_substream_chip(substream);
	size_t ret = snd_psc_get_substream_pos(chip->i2s_substreams[CAPTURE]);
	PRDEBUG(3, "%s returns %u\n", __FUNCTION__, ret);
	return bytes_to_frames(substream->runtime, ret);
}


static int snd_mpc5200_hw_free(snd_pcm_substream_t *substream)
{

	PRDEBUG(1, "%s\n", __FUNCTION__);
	return snd_pcm_lib_free_pages(substream);
}


static snd_pcm_ops_t snd_card_mpc5200_playback_ops =
{
	.open			= snd_card_mpc5200_playback_open,
	.close			= snd_card_mpc5200_playback_close,
	.ioctl			= snd_card_mpc5200_playback_ioctl,
	.hw_params	        = snd_card_mpc5200_playback_hw_params,
	.hw_free	        = snd_mpc5200_hw_free,
	.prepare		= snd_card_mpc5200_playback_prepare,
	.trigger		= snd_card_mpc5200_playback_trigger,
	.pointer		= snd_card_mpc5200_playback_pointer,
};


static snd_pcm_ops_t snd_card_mpc5200_capture_ops =
{
	.open			= snd_card_mpc5200_capture_open,
	.close			= snd_card_mpc5200_capture_close,
	.ioctl			= snd_card_mpc5200_capture_ioctl,
	.hw_params	        = snd_card_mpc5200_capture_hw_params,
	.hw_free	        = snd_mpc5200_hw_free,
	.prepare		= snd_card_mpc5200_capture_prepare,
	.trigger		= snd_card_mpc5200_capture_trigger,
	.pointer		= snd_card_mpc5200_capture_pointer,
};


static void snd_mpc5200_pcm_free(snd_pcm_t *pcm)
{
	mpc5200_uda1380_t *chip = snd_pcm_chip(pcm);

	snd_psc_substream_free(chip->i2s_substreams[PLAYBACK]);
	chip->i2s_substreams[PLAYBACK] = NULL;

	snd_psc_substream_free(chip->i2s_substreams[CAPTURE]);
	chip->i2s_substreams[CAPTURE] = NULL;
}


static int __init snd_mpc5200_pcm_create(mpc5200_uda1380_t *chip, int cardid)
{
	static char pcm_name[] = "PSC?_I2S_PCM";
	static char playback_name[] = "PSC?_I2S_PLAYBACK";
	static char capture_name[] = "PSC?_I2S_CAPTURE";
	int err;

	pcm_name[3] = '0' + cardid;
	playback_name[3] = '0' + cardid;
	capture_name[3] = '0' + cardid;

	PRDEBUG(1, "%s\n", __FUNCTION__);

	// audio power is turned on and a clock is set at the same time so this gives us a default
	// starting rate
	chip->samplerate = 0;

	if ((err = snd_pcm_new(chip->card, pcm_name, 0, 1, 1, &(chip->pcm))) < 0)
		return err;

	snd_pcm_set_ops(chip->pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_mpc5200_playback_ops);
	snd_pcm_set_ops(chip->pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_mpc5200_capture_ops);
	snd_pcm_lib_preallocate_pages_for_all(chip->pcm, SNDRV_DMA_TYPE_DEV, snd_dma_isa_data(), 0x10000, 0x10000);

	chip->pcm->private_data = chip;
	chip->pcm->private_free = snd_mpc5200_pcm_free;
	chip->pcm->info_flags = 0;

	/* setup playback and capture */
	strncpy(chip->pcm->name, pcm_name, sizeof(chip->pcm->name));

	/* setup DMA structures */
	err = snd_psc_substream_create(chip->i2s_substreams + PLAYBACK,
				       chip->i2s_card,
				       playback_name,
				       PLAYBACK,
				       snd_card_mpc5200_playback_capture_irq);
	if (err < 0)
		return err;

	err = snd_psc_substream_create(chip->i2s_substreams + CAPTURE,
				       chip->i2s_card,
				       capture_name,
				       CAPTURE,
				       snd_card_mpc5200_playback_capture_irq);
	if (err < 0)
		return err;

	return 0;
}


static int
snd_mpc5200_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
{
	static const char *extsws[]	= {"Line", "Ext.Mic"};

	PRDEBUG(2, "%s(%p,%p)\n", __FUNCTION__, kcontrol, uinfo);

	switch (kcontrol->private_value)
	{
	case CMD_EXTSW:
		uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
		uinfo->count = 1;
		uinfo->value.enumerated.items = ARRAY_SIZE(extsws);
		if (uinfo->value.enumerated.item >= ARRAY_SIZE(extsws))
			uinfo->value.enumerated.item = ARRAY_SIZE(extsws) - 1;
		strncpy(uinfo->value.enumerated.name,
			extsws[uinfo->value.enumerated.item],
			sizeof(uinfo->value.enumerated.name));
		return 0;
	}


	printk(KERN_WARNING "%s called with bad private info: %ld\n", __FUNCTION__, kcontrol->private_value);
	return -EINVAL;
}


static int
snd_mpc5200_put_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
{
	mpc5200_uda1380_t *chip = snd_kcontrol_chip(kcontrol);

	PRDEBUG(2, "%s(%p,%p) value=%lu chip=%p\n",
		__FUNCTION__,
		kcontrol, ucontrol,
		kcontrol->private_value,
		chip);

	switch (kcontrol->private_value)
	{
	case CMD_EXTSW:
		if (!extsw[chip->cardid])
			ucontrol->value.enumerated.item[0] = 0;
		chip->extsw = ucontrol->value.enumerated.item[0];
		PRDEBUG(2, "%s: extsw=%d\n", __FUNCTION__, chip->extsw);
#if !defined(SND_MPC5200_SIMPLE_PROC)
		if (chip->extsw_proc_entry)
		{
			snd_mpc5200_extsw_data[0] = chip->extsw ? '1' : '0';
			wake_up(&chip->extsw_wait);
		}
#endif
		return 0;
	}

	printk(KERN_WARNING "%s called with bad private info: %ld\n", __FUNCTION__, kcontrol->private_value);
	return -EINVAL;
}


static int
snd_mpc5200_get_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
{
	mpc5200_uda1380_t *chip = snd_kcontrol_chip(kcontrol);

	PRDEBUG(3, "%s(%p,%p) private_value=%ld\n",
		__FUNCTION__,
		kcontrol, ucontrol,
		kcontrol->private_value);

	switch (kcontrol->private_value)
	{
	case CMD_EXTSW:
		ucontrol->value.enumerated.item[0] = chip->extsw;
		PRDEBUG(2, "%s: extsw=%d\n", __FUNCTION__, chip->extsw);
		return 0;
	}
	printk(KERN_WARNING "%s called with bad private info: %ld\n", __FUNCTION__, kcontrol->private_value);
	return -EINVAL;
}


#define MPC5200(xname, pvt_value) \
{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
  .name = xname, \
  .info = snd_mpc5200_info, \
  .get = snd_mpc5200_get_single, \
  .put = snd_mpc5200_put_single, \
  .private_value = pvt_value \
}


/* The name "Capture Source" seems to confuse ALSA. Name it differently. */
static snd_kcontrol_new_t snd_mpc5200_extsw_controls = MPC5200("Line MUX", CMD_EXTSW);


#if defined(SND_MPC5200_SIMPLE_PROC)

static void snd_mpc5200_extsw_read(snd_info_entry_t *entry, snd_info_buffer_t *buffer)
{
	mpc5200_uda1380_t *chip = entry->private_data;

	PRDEBUG(2, "%s(%p,%p) cs=%d\n", __FUNCTION__, entry, buffer, chip->extsw);
	snd_iprintf(buffer, "%d\n", chip->extsw);
}

#else

static unsigned int snd_mpc5200_extsw_poll(snd_info_entry_t *entry,
					   void *private,
					   struct file *file,
					   poll_table *wait)
{
	mpc5200_uda1380_t *chip = entry->private_data;

	PRDEBUG(2, "%s(%p,%p,%p,%p)\n",
		__FUNCTION__,
		entry, private, file, wait);

	poll_wait(file, &chip->extsw_wait, wait);
	PRDEBUG(2, "%s: return from poll_wait\n", __FUNCTION__);

	return POLLIN | POLLRDNORM;
}


static long snd_mpc5200_extsw_read(snd_info_entry_t *entry,
				   void *private,
				   struct file *file,
				   char *buf, unsigned long count, unsigned long pos)
{
	mpc5200_uda1380_t *chip = entry->private_data;
	unsigned long size = count;

	PRDEBUG(2, "%s(%p,%p,%p,%p,%lu,%lu) cs=%d\n",
		__FUNCTION__,
		entry, private, file, buf, count, pos,
		chip->extsw);

	if (pos + size > sizeof(snd_mpc5200_extsw_data))
		size = sizeof(snd_mpc5200_extsw_data) - pos;
	if (copy_to_user(buf, snd_mpc5200_extsw_data + pos, size))
		return -EFAULT;

	return size;
}


static long long snd_mpc5200_extsw_llseek(snd_info_entry_t *entry, void *private,
					  struct file *file, long long offset, int orig)
{
	PRDEBUG(2, "%s(%p,%p,%p,%Lu,%d)\n",
		__FUNCTION__,
		entry, private, file, offset, orig);

	if (orig == 0 && offset >= 0)
		return file->f_pos = offset;
	else
		return -EINVAL;
}


static struct snd_info_entry_ops snd_mpc5200_extsw_ops =
{
	.read = snd_mpc5200_extsw_read,
	.poll = snd_mpc5200_extsw_poll,
	.llseek = snd_mpc5200_extsw_llseek
};

#endif


static void snd_mpc5200_card_free(snd_card_t *card)
{
	mpc5200_uda1380_t *chip = card->private_data;

	PRDEBUG(1, "%s(%p) chip=%p\n", __FUNCTION__, card, chip);

	if (chip->uda1380)
		snd_chip_uda1380_mixer_del(card, chip->uda1380);

	snd_psc_card_free(chip->i2s_card);
	kfree(chip);
	card->private_data = NULL;

#ifdef SND_DELAY_ON_EXIT
	snd_psc_delay(__FUNCTION__, 4000, 1);
#endif

	PRDEBUG(1, "%s done\n", __FUNCTION__);
}


static int __init snd_mpc5200_card_create(int cardid)
{
	snd_card_t *card;
	mpc5200_uda1380_t *chip;
	int err;

	PRDEBUG(1, "%s(%d)\n", __FUNCTION__, cardid);

	/* register the soundcard */
	card = snd_card_new(index[cardid], id[cardid], THIS_MODULE, 0);
	if (card == NULL)
		return -ENOMEM;

	PRDEBUG(2, "%s: card=%p created\n", __FUNCTION__, card);

	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
	if (chip == NULL)
	{
		snd_card_free(card);
		return -ENOMEM;
	}

	PRDEBUG(2, "%s: chip=%p created\n", __FUNCTION__, chip);

	card->private_data = chip;
	card->private_free = snd_mpc5200_card_free;

	chip->card = card;
	chip->cardid = cardid;

#if !defined(SND_MPC5200_SIMPLE_PROC)
	init_waitqueue_head(&chip->extsw_wait);
#endif

	if (uda[cardid])
	{
		PRDEBUG(2, "%s: card %u: checking for UDA1380\n", __FUNCTION__, cardid);

		// mixer
		err = snd_chip_uda1380_mixer_new(chip->card, &chip->uda1380, mic[cardid]);
		if (err < 0)
		{
			printk(KERN_ERR "%s: cannot create or find mixer for card id=%d!\n", DRIVER_NAME, cardid);
			snd_card_free(card);
			return err;
		}
		else
		{
			// init mixer with default values
			uda1380_configure(chip->uda1380, chip->samplerate = SND_PSC_AUDIO_RATE_DEFAULT);
		}

		snprintf(card->mixername, sizeof(card->mixername), "MPC5xxx_UDA_PSC%u", cardid);

		if (extsw[cardid])
		{
			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_mpc5200_extsw_controls, chip))) < 0)
				return err;

			if ((err = snd_card_proc_new(card, "extsw", &chip->extsw_proc_entry)) < 0)
				return err;

#if defined(SND_MPC5200_SIMPLE_PROC)
			snd_info_set_text_ops(chip->extsw_proc_entry, chip, 64, snd_mpc5200_extsw_read);
#else
			chip->extsw_proc_entry->content = SNDRV_INFO_CONTENT_DATA;
			chip->extsw_proc_entry->private_data = chip;
			chip->extsw_proc_entry->c.ops = &snd_mpc5200_extsw_ops;
			chip->extsw_proc_entry->size = 8;
			chip->extsw_proc_entry->mode = S_IFREG | S_IRUGO;
#endif
		}

		snprintf(card->longname, sizeof(card->longname),
			 "Telemotive Board with I2S on PSC%u + Philips UDA1380", cardid);
	}
	else
	{
		chip->uda1380 = NULL;
		chip->extsw_proc_entry = NULL;
		snprintf(card->longname, sizeof(card->longname),
			 "Telemotive Board with I2S on PSC%u", cardid);
	}

	err = snd_psc_card_create(&chip->i2s_card, cardid,
				  slave[cardid], spi[cardid], loopback[cardid]);
	if (err < 0)
	{
		snd_card_free(card);
		return err;
	}

	if ((err = snd_mpc5200_pcm_create(chip, cardid)) < 0)
	{
		snd_card_free(card);
		return err;
	}

	strcpy(card->driver, "mpc5200-uda1380");
	snprintf(card->shortname, sizeof(card->shortname), "PSC%u", cardid);

	if ((err = snd_card_register(card)) < 0)
	{
		snd_card_free(card);
		return err;
	}

	cards[cardid] = card;

	return err;
}


static int __init snd_mpc5200_init(void)
{
	int err;
	size_t i;

	PRDEBUG(1, "%s\n", __FUNCTION__);

#if !defined(SND_MPC5200_DEBUG)
	if (debug != -1)
		printk(KERN_WARNING "%s: compiled without debug support\n", __FUNCTION__);
#endif

	/* be lazy */
	for (i = 0; i < SNDRV_CARDS; i++)
	{
		if (allowed[i] && enable[i])
		{
			err = snd_mpc5200_card_create(i);
			if (err < 0)
				return err;
		}
	}

	return 0;
}


static void __exit snd_mpc5200_exit(void)
{
	size_t cardid;

	PRDEBUG(1, "%s\n", __FUNCTION__);

	for (cardid = 0; cardid < SNDRV_CARDS; cardid++)
	{
		PRDEBUG(3, "%s: cardid=%u\n", __FUNCTION__, cardid);

		if (cards[cardid])
		{
			snd_card_free(cards[cardid]);
			cards[cardid] = NULL;
#ifdef SND_DELAY_ON_EXIT
			snd_psc_delay(__FUNCTION__, 4000, 1);
#endif
		}

		PRDEBUG(3, "%s: cardid=%u done\n", __FUNCTION__, cardid);
	}

	PRDEBUG(1, "%s exit\n", __FUNCTION__);
}


module_init(snd_mpc5200_init);
module_exit(snd_mpc5200_exit);

MODULE_PARM(debug, "i");
MODULE_PARM_DESC(debug, "debug level (0-6)");

module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for MPC5xxx soundcard.");
module_param_array(id, charp, NULL, 0444);
MODULE_PARM_DESC(id, "ID string for MPC5xxx soundcard.");
module_param_array(enable, bool, NULL, 0444);
MODULE_PARM_DESC(enable, "Enable MPC5xxx soundcard.");
module_param_array(uda, bool, NULL, 0444);
MODULE_PARM_DESC(uda, "I2C adress of UDA1380 for MPC5xxx soundcard.");
module_param_array(slave, bool, NULL, 0444);
MODULE_PARM_DESC(slave, "Run I2S port in slave mode.");
module_param_array(spi, bool, NULL, 0444);
MODULE_PARM_DESC(spi, "Use SPI instead of I2S to communicate via the PSC.");
module_param_array(mic, bool, NULL, 0444);
MODULE_PARM_DESC(mic, "Microphone connected [0=no Mic,1=Mic].");
module_param_array(extsw, bool, NULL, 0444);
MODULE_PARM_DESC(extsw, "Enable external capture switch via GPIO.");
module_param_array(loopback, bool, NULL, 0444);
MODULE_PARM_DESC(loopback, "Enable MPC5xxx local loopback mode.");

MODULE_LICENSE("GPL");

--Boundary-01=_Si/fFHPjgOphdxQ--

--nextPart14049312.1dJujBo9Ay
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFf/iSp5XY/BK//MIRApaeAKCQSXYPjjMScIN9yZ7yWJxQUt+d+QCcCoVr
cZWT0U+nMEH33DkqXsbxwEE=
=Sd2A
-----END PGP SIGNATURE-----

--nextPart14049312.1dJujBo9Ay--
