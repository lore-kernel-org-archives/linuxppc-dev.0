Return-Path: <bzolnier@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 0499CDDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 20:54:39 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so497948fke.9
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 03:54:37 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 12:51:01 +0200
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217478322.11188.410.camel@pasglop>
In-Reply-To: <1217478322.11188.410.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807311251.02251.bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 31 July 2008, Benjamin Herrenschmidt wrote:
>=20
> > Is it actually caused by additional reference counting on drive->gendev?
> > IOW if you reverse the patch below instead of applying the previous fix
> > do things work OK again?
> >=20
> > > Note that there shouldn't be anything fundamentally different from
> > > ide-pmac here vs. something like pcmcia IDE cards... do you have one =
of
> > > these to test with ?
> >=20
> > Nope and I really don't intend to have one.  I count on other people
> > to take some care of support for host drivers that they maintain/use. ;)
>=20
> Reverting the patch below does the job. Thanks.

Thanks, this narrows down the problem pretty nicely.

[ Unfortunately we cannot revert the whole patch as it would break
  unloading of IDE host drivers modules so I still need you help on
  fixing this one. ]

Lets get back to the oops:

Vector: 300 (Data Access) at [c59dfdc0]
=C2=A0 =C2=A0 pc: c0211f78: ide_device_put+0x18/0x58
=C2=A0 =C2=A0 lr: c0223c34: ide_cd_put+0x40/0x5c
=C2=A0 =C2=A0 sp: c59dfe70
=C2=A0 =C2=A0msr: 9032
=C2=A0 =C2=A0dar: 10
=C2=A0dsisr: 40000000
=C2=A0 current =3D 0xc58a9880
=C2=A0 =C2=A0 pid =C2=A0 =3D 843, comm =3D media-bay
enter ? for help
[c59dfe80] c0223c34 ide_cd_put+0x40/0x5c
[c59dfea0] c02114d4 generic_ide_remove+0x28/0x3c
[c59dfeb0] c01ea108 __device_release_driver+0x78/0xb4
[c59dfec0] c01ea218 device_release_driver+0x28/0x44
[c59dfee0] c01e9350 bus_remove_device+0xac/0xd8
[c59dff00] c01e77f8 device_del+0x104/0x198
[c59dff20] c01e78a4 device_unregister+0x18/0x30
[c59dff40] c0212598 __ide_port_unregister_devices+0x6c/0x88
[c59dff60] c021276c ide_port_unregister_devices+0x38/0x80
[c59dff80] c0209078 media_bay_step+0x1cc/0x5c0
[c59dffb0] c02094f8 media_bay_task+0x8c/0xcc
[c59dffd0] c0048640 kthread+0x48/0x84
[c59dfff0] c0011b38 kernel_thread+0x44/0x60

On a fresh look at ide_device_put(), ide_host_alloc() and pmac.c
it may be that the above oops is actually media-bay specific.

ide_device_put():
=2E..
        struct device *host_dev =3D drive->hwif->host->dev[0];
        struct module *module =3D host_dev ? host_dev->driver->owner : NULL;
=2E..

ide_host_alloc():
=2E..
       if (hws[0])
                host->dev[0] =3D hws[0]->dev;
=2E..

pmac.c:
=2E..
pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *ma=
tch)
=2E..
	dev_set_drvdata(&mdev->ofdev.dev, pmif);

	memset(&hw, 0, sizeof(hw));
	pmac_ide_init_ports(&hw, pmif->regbase);
	hw.irq =3D irq;
	hw.dev =3D &mdev->bus->pdev->dev;
	hw.parent =3D &mdev->ofdev.dev;
=2E..

pmac macio is unique in using different devices for hwif->dev / host->dev
(hw.dev) and hwif->gendev.parent / dev_set_drvdata() (hw.parent)

[ I has been actually wondering why is it so for some time...? ]

Thus we may be hitting oops in ide_device_put() on host_dev->driver
because hw.dev is used as host->dev for pmac macio in ide_device_put()
while we really want to use hw.parent.

=46ix should be as simple as:

=2D                host->dev[0] =3D hws[0]->dev;
+                host->dev[0] =3D hws[0]->parent ? hws[0]->parent : hws[0]-=
>dev;

Could you please try it together with my previous patch for
ide_device_{get,put}()?

Bart
