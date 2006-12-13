Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 7E53B67C2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 00:15:12 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 928B227E8A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 14:15:05 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
In-Reply-To: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
MIME-Version: 1.0
Message-ID: <200612131415.05250.roman.fietze@telemotive.de>
Date: Wed, 13 Dec 2006 14:15:04 +0100
Content-Type: multipart/signed; boundary="nextPart1374342.E4oIqa98fE";
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

--nextPart1374342.E4oIqa98fE
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Zz/fFXwpdSGTRJT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Zz/fFXwpdSGTRJT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Pedro,

I just discovered one important, but missing file.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--Boundary-01=_Zz/fFXwpdSGTRJT
Content-Type: text/x-chdr;
  charset="iso-8859-1";
  name="mpc5xxx_snd.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpc5xxx_snd.h"

/*
 * mpc5xxx_snd.h
 *
 * Definitions to use the PSC in I2S codec mode with the BestComm for
 * an ALSA sound driver.
 */

#ifndef _MPC5XXX_SND_H
#define _MPC5XXX_SND_H

#include <linux/kernel.h>
#include <linux/interrupt.h>

#define SND_PSC_TRACE	(0)
// #define SND_PSC_TRACE		(1000)

// #undef SND_PSC_STATISTICS
#define SND_PSC_STATISTICS

/* Some needed or useful constants. */
#define SND_PSC_AUDIO_RATE_MIN		(8000)
#define SND_PSC_AUDIO_RATE_DEFAULT	(44100)
#define SND_PSC_AUDIO_RATE_MAX		(48000)
#define SND_PSC_MAX_BUFFER_SIZE		(0x40000)
#define SND_PSC_MIN_PERIOD_SIZE		(1024)
#define SND_PSC_MAX_PERIOD_SIZE		(4096)


#if SND_PSC_TRACE
# if defined(MODULE)
#  if !defined(CONFIG_TRACE) && !defined(CONFIG_TRACE_MODULE)
#   warning "Need CONFIG_TRACE or CONFIG_TRACE_MODULE, disable trace."
#   undef SND_PSC_TRACE
#   define SND_PSC_TRACE	(0)
#  endif
# elif !defined(CONFIG_TRACE)
#   warning "Need CONFIG_TRACE, disable trace."
#   undef SND_PSC_TRACE
#   define SND_PSC_TRACE	(0)
# endif
#endif

#if SND_PSC_TRACE
# include <linux/trace.h>
#endif

#define SND_PSC_MAX_STREAMS	(2)

typedef void (*snd_psc_irq_handler_t)(void *_stream);

typedef struct _snd_mpc5xxx_i2s_substream
{
	char name[40];

	int id;
	struct _snd_mpc5xxx_i2s_card *card;

	int dma_started;
	int8_t task_id;
	int32_t bdidx;			/* BestComms current BDIdx */
	int irq;
	dma_addr_t dma_addr;
	size_t dmapos;
	size_t irqpos;
	size_t processed;		/* processed since last call of xxx_pointer() */
	size_t buffer_size;
	size_t period_size;

	snd_psc_irq_handler_t handler;
	void *stream;

#if SND_PSC_TRACE
	trace_handle_t *trace_handle;
#endif

} snd_mpc5xxx_i2s_substream_t;


typedef struct _snd_mpc5xxx_i2s_card
{
	char name[20];
	uint16_t pscnum;	/* identical to cardid in ALSA driver */
	int loopback;
	uint32_t rate;
	size_t channels;
	size_t bits;
	int slave;		/* run I2S codec in clock slave mode */
	int spi;		/* run SPI codec instead of I2S codec */

	spinlock_t lock;

	int psc_started;	/* bit mask for started substreams */

	snd_mpc5xxx_i2s_substream_t *streams[SND_PSC_MAX_STREAMS];
} snd_mpc5xxx_i2s_card_t;


int snd_psc_card_create(snd_mpc5xxx_i2s_card_t **_card,
			uint16_t _pscnum,
			int _slave, int _spi, int _loopback);

void snd_psc_card_free(snd_mpc5xxx_i2s_card_t *_card);

int snd_psc_substream_create(snd_mpc5xxx_i2s_substream_t **_s,
			     snd_mpc5xxx_i2s_card_t *_card,
			     const char *_name,
			     int _id,			/* 0..1 */
			     snd_psc_irq_handler_t _handler);

int snd_psc_substream_open(snd_mpc5xxx_i2s_substream_t *_s, void *_stream);

int snd_psc_substream_params(snd_mpc5xxx_i2s_substream_t *_s,
			     uint32_t _rate, size_t _channels, size_t _bits,
			     size_t _buffer_size, size_t _period_size);

int snd_psc_substream_start(snd_mpc5xxx_i2s_substream_t *_s, dma_addr_t _dma_addr);

size_t snd_psc_get_substream_pos(snd_mpc5xxx_i2s_substream_t *_s);
int snd_psc_substream_stop(snd_mpc5xxx_i2s_substream_t *_s);
int snd_psc_substream_close(snd_mpc5xxx_i2s_substream_t *_s);
int snd_psc_substream_free(snd_mpc5xxx_i2s_substream_t *_s);

#endif

--Boundary-01=_Zz/fFXwpdSGTRJT--

--nextPart1374342.E4oIqa98fE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFf/zZp5XY/BK//MIRAjJAAJ4kfNczSJAhk0hnbX19ddUDaoEANACggUMM
IR3LeiVk3JV2XhcKQBzuYfs=
=FhvH
-----END PGP SIGNATURE-----

--nextPart1374342.E4oIqa98fE--
