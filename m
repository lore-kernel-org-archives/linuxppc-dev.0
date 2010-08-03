Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADDF61011EA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 23:43:36 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Subject: setting up of platform device archdata?
Date: Tue, 3 Aug 2010 08:43:30 -0500
Message-Id: <8AD41167-5FB1-4C42-83A7-9F0CC6AF69AA@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg,

We are running into in issue in that we need the platform device =
archdata setup before platform_device_add gets called since we need some =
data in archdata setup to allow the bus notifiers to work properly.  On =
PPC we need this to get the dma masks setup properly that we than use in =
the bus notifiers to determine if we need SWIOTLB support for a given =
device or not.  Any suggestions on how to do this? Something like below?

struct platform_device *platform_device_alloc(const char *name, int id)

...
        if (pa) {
                strcpy(pa->name, name);
                pa->pdev.name =3D pa->name;
                pa->pdev.id =3D id;
                device_initialize(&pa->pdev.dev);
                pa->pdev.dev.release =3D platform_device_release;
#ifdef ARCH_HAS_PDEV_ARCHDATA_SETUP
		arch_setup_pdev_archdata(&pa->pdev.dev);
#endif
        }

- k=
