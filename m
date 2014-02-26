Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D3EB2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 14:09:21 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>, "rtc-linux@googlegroups.com"
 <rtc-linux@googlegroups.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: RE: [rtc-linux] [PATCH] rtc/ds3232: Enable ds3232 to work as wakeup
 source
Date: Wed, 26 Feb 2014 03:09:13 +0000
Message-ID: <3eba8b896e624b698ab8291399c5a1b0@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1390281891-9632-1-git-send-email-dongsheng.wang@freescale.com>
 <20140225140705.fe9f7038bbffbfbde899e0f7@linux-foundation.org>
In-Reply-To: <20140225140705.fe9f7038bbffbfbde899e0f7@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org]
> Sent: Wednesday, February 26, 2014 6:07 AM
> To: rtc-linux@googlegroups.com
> Cc: Wang Dongsheng-B40534; a.zummo@towertech.it; Zhao Chenhui-B35336; lin=
uxppc-
> dev@lists.ozlabs.org
> Subject: Re: [rtc-linux] [PATCH] rtc/ds3232: Enable ds3232 to work as wak=
eup
> source
>=20
> On Tue, 21 Jan 2014 13:24:51 +0800 Dongsheng Wang <dongsheng.wang@freesca=
le.com>
> wrote:
>=20
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Add suspend/resume and device_init_wakeup to enable ds3232 as
> > wakeup source, /sys/class/rtc/rtcX/wakealarm for set wakeup alarm.
> >
> > ...
> >
> > @@ -411,23 +424,21 @@ static int ds3232_probe(struct i2c_client *client=
,
> >  	if (ret)
> >  		return ret;
> >
> > -	ds3232->rtc =3D devm_rtc_device_register(&client->dev, client->name,
> > -					  &ds3232_rtc_ops, THIS_MODULE);
> > -	if (IS_ERR(ds3232->rtc)) {
> > -		dev_err(&client->dev, "unable to register the class device\n");
> > -		return PTR_ERR(ds3232->rtc);
> > -	}
> > -
> > -	if (client->irq >=3D 0) {
> > +	if (client->irq !=3D NO_IRQ) {
>=20
> x86_64 allmodconfig:
>=20
> drivers/rtc/rtc-ds3232.c: In function 'ds3232_probe':
> drivers/rtc/rtc-ds3232.c:427: error: 'NO_IRQ' undeclared (first use in th=
is
> function)
> drivers/rtc/rtc-ds3232.c:427: error: (Each undeclared identifier is repor=
ted
> only once
> drivers/rtc/rtc-ds3232.c:427: error: for each function it appears in.)
>=20
> Not all architectures implement NO_IRQ.
>=20
> I think this should be
>=20
> 	if (client->irq > 0) {
>=20
> but I'm not sure - iirc, x86 (at least) treats zero as "not an IRQ".
> But I think some architectures permit IRQ 0.  There was discussion many
> years ago but I don't think anything got resolved.
>=20
I think this is why NO_IRQ is defined in kernel, that should be resolved th=
is issue.

Sorry, I don't know why some architectures didn't define this macro?


Hi Ben,

Did you have some suggestion?

Thanks,
-Dongsheng

>=20
> Help!  I think some ppc people will know what to do here?
>=20
