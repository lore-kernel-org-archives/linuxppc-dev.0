Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange.deka.local (mail.dekaresearch.com [208.65.175.196])
	by ozlabs.org (Postfix) with ESMTP id 7C960DE14D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:38:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: mpc5200 fec error
Date: Wed, 20 May 2009 12:41:38 -0400
Message-ID: <A88094362DE0AE49A118AB9B4EB3612403F9DEC0@dekaexchange.deka.local>
In-Reply-To: <9e4733910905200829o423bf483h5b0b6dd202367872@mail.gmail.com>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519203645.GW19843@pengutronix.de>
	<20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
	<20090520064218.GA29102@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
	<9e4733910905200814p63915ff8pf65614dbb8dc9adf@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBF@dekaexchange.deka.local>
	<9e4733910905200829o423bf483h5b0b6dd202367872@mail.gmail.com>
From: "Eric Millbrandt" <emillbrandt@dekaresearch.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, May 20, 2009 at 9:42 AM, Eric Millbrandt
> <emillbrandt@dekaresearch.com> wrote:
>>> > I am able to reproduce the error using 2.6.29.2-rt11.  I was able =
to
>>> > mitigate the problem by raising the priority of the transmit irq.
>>> > However when running an NFS server on the pcm030 under high cpu =
load I
>>> > now get
>>> >
>>> > [  132.477503] net eth0: FEC_IEVENT_RFIFO_ERROR
>>> > [  132.892329] net eth0: FEC_IEVENT_RFIFO_ERROR
>>> > [  133.884109] net eth0: FEC_IEVENT_RFIFO_ERROR
>>> > [  134.876059] net eth0: FEC_IEVENT_RFIFO_ERROR
>>> >
>>> > Raising the priority of the rx irq does not seem to fix this =
problem
>>> > though.
>>>
>>> Hi Eric,
>>>
>>> This error has been seen before in non-rt kernels.  I haven't had =
the
>>> chance to track it down and kill it yet.  I believe there are =
locking
>>> issues associated with it.
>>
>> Uuuh, I recall this message. Kept me busy for some time :(
>>
>> You might try this patch which helped in our situation.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Subject: Enable XLB pipelining for MPC5200B
>> From: Wolfram Sang <w.sang@pengutronix.de>
>>
>> Enable pipelining as it helps getting rid of FEC problems.
>> Not intended for upstream, this must be dealt differently there.
>>
>> This patch is disabled by default. The bootloader should enable this =
feature.
>> So, this patch is only intended to be used where the bootloader does =
it in a
>> wrong manner and can't be replaced.
>>
>> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> Acked-by: Juergen Beisert <j.beisert@pengutronix.de>
>>
>> ---
>>  arch/powerpc/platforms/52xx/mpc52xx_common.c |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
>> +++ arch/powerpc/platforms/52xx/mpc52xx_common.c
>> @@ -107,6 +107,13 @@ mpc5200_setup_xlb_arbiter(void)
>>         */
>>        if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) =3D=3D MPC5200_SVR)
>>                out_be32(&xlb->config, in_be32(&xlb->config) | =
MPC52xx_XLB_CFG_PLDIS);
>> +#if 0
>> +       /*
>> +        * Enable pipelining, fixes FEC problems. The previous =
workaround is not
>> +        * needed, as we have an MPC5200B (not A).
>> +        */
>> +       out_be32(&xlb->config, in_be32(&xlb->config) & =
~MPC52xx_XLB_CFG_PLDIS);
>> +#endif
>>
>>        iounmap(xlb);
>>  }
>>
>> --
>> Pengutronix e.K.                           | Wolfram Sang             =
   |
>> Industrial Linux Solutions                 | =
http://www.pengutronix.de/  |
>>
>> Wolfram,
>>
>> Thanks, but no luck with this patch.  It was already setup correctly =
by U-Boot.
>
>
> I don't see where this gets enabled in the u-boot source. Have you
> added it locally?
>
> These are the only two I see:
> cpu/mpc5xxx/cpu_init.c: *(vu_long *)(MPC5XXX_XLBARB + 0x40) |=3D (1 << =
13);
> cpu/mpc5xxx/cpu_init.c: *(vu_long *)(MPC5XXX_XLBARB + 0x40) |=3D (1 << =
15);
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>
> If you look a few more lines down you should see
> # if defined(CFG_XLB_PIPELINING)
>        /* Enable piplining */
>        *(vu_long *)(MPC5XXX_XLBARB + 0x40) &=3D ~(1 << 31);
> # endif
>
> I obtained the u-boot sources directly from phytec, for my phyCore, so =
I am not sure if they added it.

It is ok in main u-boot source. I just missed the lower section.

--=20
Jon Smirl
jonsmirl@gmail.com

It looks like the phy is never getting reset properly after the =
FEC_IEVENT_RFIFO_ERROR.  I threw some printk's into the fec mdio driver

/drivers/net/fec_mpc52xx_phy.c
  25 static int mpc52xx_fec_mdio_transfer(struct mii_bus *bus, int =
phy_id,
  26                 int reg, u32 value)
  27 {
  28         struct mpc52xx_fec_mdio_priv *priv =3D bus->priv;
  29         struct mpc52xx_fec __iomem *fec;
  30         int tries =3D 100;
  31=20
  32         value |=3D (phy_id << FEC_MII_DATA_PA_SHIFT) & =
FEC_MII_DATA_PA_MSK;
  33         value |=3D (reg << FEC_MII_DATA_RA_SHIFT) & =
FEC_MII_DATA_RA_MSK;
  34=20
  35         fec =3D priv->regs;
  36         out_be32(&fec->ievent, FEC_IEVENT_MII);
  37         out_be32(&priv->regs->mii_data, value);
  38=20
  39         /* wait for it to finish, this takes about 23 us on =
lite5200b */
  40         while (!(in_be32(&fec->ievent) & FEC_IEVENT_MII) && =
--tries)
  41                 udelay(5);
  42=20
  43         if (!tries) {
  44                 printk("Unable to reset phy\n");
  45                 return -ETIMEDOUT;
  46         }
  47=20
  48         return value & FEC_MII_DATA_OP_RD ?
  49                 in_be32(&priv->regs->mii_data) & =
FEC_MII_DATA_DATAMSK : 0;
  50 }

and got this

[  127.085632] net eth0: FEC_IEVENT_RFIFO_ERROR
[  127.093401] Resetting FEC
[  127.096620] Unable to reset phy
[  127.322224] Unable to reset phy
[  128.321987] PHY: f0003000:00 - Link is Down
[  129.221034] net eth0: FEC_IEVENT_RFIFO_ERROR
[  129.228165] Resetting FEC
[  129.231384] Unable to reset phy
[  129.322286] Unable to reset phy
[  132.885863] net eth0: FEC_IEVENT_RFIFO_ERROR
[  132.893002] Resetting FEC
[  132.896176] Unable to reset phy
[  133.322202] Unable to reset phy
[  135.684793] net eth0: FEC_IEVENT_RFIFO_ERROR
[  135.691969] Resetting FEC
[  135.695192] Unable to reset phy
[  136.322530] Unable to reset phy
[  138.490805] net eth0: FEC_IEVENT_RFIFO_ERROR
[  138.497963] Resetting FEC
[  138.501135] Unable to reset phy
[  139.334200] Unable to reset phy

I guess I have to spend some quality time with the 5200 manual.


_________________________________________________________________________=
________________

This e-mail and the information, including any attachments, it contains =
are intended to be a confidential communication only to the person or =
entity to whom it is addressed and may contain information that is =
privileged. If the reader of this message is not the intended recipient, =
you are hereby notified that any dissemination, distribution or copying =
of this communication is strictly prohibited. If you have received this =
communication in error, please immediately notify the sender and destroy =
the original message.

Thank you.

Please consider the environment before printing this email.
