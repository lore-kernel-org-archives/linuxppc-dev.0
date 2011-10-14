Return-Path: <R65777@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 17BDCB6F8F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 16:43:07 +1100 (EST)
Received: from mail74-va3 (localhost.localdomain [127.0.0.1])	by
 mail74-va3-R.bigfish.com (Postfix) with ESMTP id C64AF39027E	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 05:43:00 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "smitha.vanga@wipro.com" <smitha.vanga@wipro.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: I2c-cpm drievr not working
Date: Fri, 14 Oct 2011 05:42:44 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE622DD7D@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4E8C9741.9010401@freescale.com>
 <40631E9A2581F14BA60888C87A76A1FE015B09@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE015B09@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> smitha.vanga@wipro.com
> Sent: Friday, October 14, 2011 9:45 AM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: I2c-cpm drievr not working
>=20
>=20
> Hi Scott,
>=20
> I am using the i2c-cpm driver to read and write to a LM75 sensor. The int
> i2c_master_send(struct i2c_client *client,const char *buf ,int count)
> function is not successful.
> Could you let me know what may be the issue. Below are the traces.
>=20
> DS75_DRIVER : Open
> DS75_DRIVER : Device Open Successful!
> DS75_DRIVER  : ioctl TEMP_READ cmd 1
> In i2c_master_send enter-------
> In i2c_master_send enter [2]-------
> In i2c_master_send msg.addr=3Dc031
> In i2c_master_send 1 client->addr =3D0
> In i2c_master_send 2
> In i2c_master_send 3
> In i2c_master_send 4
> --- enter i2c_transfer

I am a bit confused that i2c_transfer() is called after i2c_master_send is =
entered 4 times. Should not this be called every time ?

> i2c_transfer_entry
> *********** cpm_i2c_xfer
> ***********cpm_i2c_parse_message
> ***********cpm_i2c_check_message
> *********** else
>  rv =3D1
> In i2c_master_send 5
>  i2c_master_recv client.addr=3D0
> --- enter i2c_transfer

This time it is called on first shot.

Do you think you need to define I2C_CHIP_ERRATA ?

Thanks
-Bharat

> i2c_transfer_entry
> *********** cpm_i2c_xfer
> ***********cpm_i2c_parse_message
> i2c_adapter i2c-0: I2C transfer: timeout
> *********** cpm_i2c_xfer out_err
> ***********cpm_i2c_force_close
>  rv =3Dffffff87
> DS75_DRIVER  : Error reading from I2C
>=20
> Regards,
> Smitha
> Please do not print this email unless it is absolutely necessary.
>=20
> The information contained in this electronic message and any attachments
> to this message are intended for the exclusive use of the addressee(s)
> and may contain proprietary, confidential or privileged information. If
> you are not the intended recipient, you should not disseminate,
> distribute or copy this e-mail. Please notify the sender immediately and
> destroy all copies of this message and any attachments.
>=20
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
>=20
> www.wipro.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
