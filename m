Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 99E72B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 17:18:38 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id DBDD4DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 17:18:36 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so985092qwd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2009 00:18:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4D05AB.1090306@evidence.eu.com>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
	<20090702175725.15773.37291.stgit@localhost.localdomain>
	<4A4D05AB.1090306@evidence.eu.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 3 Jul 2009 01:12:16 -0600
Message-ID: <fa686aa40907030012ge9f6f98v574daf1651bc2115@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: add locking to mpc5200-psc-ac97 driver
To: michael <michael@evidence.eu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 2, 2009 at 1:08 PM, michael<michael@evidence.eu.com> wrote:
> Hi,
>
> Grant Likely wrote:
>>
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> AC97 bus register read/write hooks need to provide locking, but the
>> mpc5200-psc-ac97 driver does not. =A0This patch adds a mutex around
>> the register access routines.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 =A0| =A0 =A01 +
>> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 =A0| =A0 =A01 +
>> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0 13 ++++++++++++-
>> =A03 files changed, 14 insertions(+), 1 deletions(-)
>>
>>
>> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
>> index efec33a..f0a2d40 100644
>> --- a/sound/soc/fsl/mpc5200_dma.c
>> +++ b/sound/soc/fsl/mpc5200_dma.c
>> @@ -456,6 +456,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> =A0 =A0 =A0 =A0 =A0spin_lock_init(&psc_dma->lock);
>> + =A0 =A0 =A0 mutex_init(&psc_dma->mutex);
>> =A0 =A0 =A0 =A0psc_dma->id =3D be32_to_cpu(*prop);
>> =A0 =A0 =A0 =A0psc_dma->irq =3D irq;
>> =A0 =A0 =A0 =A0psc_dma->psc_regs =3D regs;
>> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
>> index 2000803..8d396bb 100644
>> --- a/sound/soc/fsl/mpc5200_dma.h
>> +++ b/sound/soc/fsl/mpc5200_dma.h
>> @@ -55,6 +55,7 @@ struct psc_dma {
>> =A0 =A0 =A0 =A0unsigned int irq;
>> =A0 =A0 =A0 =A0struct device *dev;
>> =A0 =A0 =A0 =A0spinlock_t lock;
>> + =A0 =A0 =A0 struct mutex mutex;
>> =A0 =A0 =A0 =A0u32 sicr;
>> =A0 =A0 =A0 =A0uint sysclk;
>> =A0 =A0 =A0 =A0int imr;
>> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c
>> b/sound/soc/fsl/mpc5200_psc_ac97.c
>> index 9b8503f..7eb5499 100644
>> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
>> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
>> @@ -34,11 +34,14 @@ static unsigned short psc_ac97_read(struct snd_ac97
>> *ac97, unsigned short reg)
>> =A0 =A0 =A0 =A0int status;
>> =A0 =A0 =A0 =A0unsigned int val;
>> =A0+ =A0 =A0 =A0 mutex_lock(&psc_dma->mutex);
>> +
>> =A0 =A0 =A0 =A0/* Wait for command send status zero =3D ready */
>> =A0 =A0 =A0 =A0status =3D
>> spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MPC52xx_P=
SC_SR_CMDSEND), 100, 0);
>> =A0 =A0 =A0 =A0if (status =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("timeout on ac97 bus (rdy)\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>
>
> maybe define an err variable and and a goto out.

My first iteration did that, but after looking at it I decided I like
this better and it adds (slightly) fewer lines of code.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
