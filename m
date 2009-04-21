Return-Path: <bzolnier@gmail.com>
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: subrata@linux.vnet.ibm.com
Subject: Re: [BUILD FAILURE 07/12] Next April 14 : PPC64 randconfig
	[drivers/ide/pmac.c]
Date: Tue, 21 Apr 2009 21:04:37 +0200
References: <1239733759.5344.79.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1239733759.5344.79.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200904212104.38664.bzolnier@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	IDE/ATA development list <linux-ide@vger.kernel.org>,
	Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 14 April 2009 20:29:19 Subrata Modak wrote:
> Observed the following build error:
> ---
> CC [M]  drivers/ide/pmac.o
> drivers/ide/pmac.c: In function =E2=80=98pmac_ide_init_dev=E2=80=99:
> drivers/ide/pmac.c:955: error: implicit declaration of function
> =E2=80=98check_media_bay_by_base=E2=80=99
> drivers/ide/pmac.c: In function =E2=80=98pmac_ide_setup_device=E2=80=99:
> drivers/ide/pmac.c:1090: error: implicit declaration of function
> =E2=80=98media_bay_set_ide_infos=E2=80=99
> make[2]: *** [drivers/ide/pmac.o] Error 1
> make[1]: *** [drivers/ide] Error 2
> make: *** [drivers] Error 2
> ---

Should be fixed by:

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: fix modular build for CONFIG_PMAC_MEDIABAY=3Dy

On Tuesday 14 April 2009 20:29:19 Subrata Modak wrote:
> Observed the following build error:
> ---
> CC [M]  drivers/ide/pmac.o
> drivers/ide/pmac.c: In function =E2=80=98pmac_ide_init_dev=E2=80=99:
> drivers/ide/pmac.c:955: error: implicit declaration of function
> =E2=80=98check_media_bay_by_base=E2=80=99
> drivers/ide/pmac.c: In function =E2=80=98pmac_ide_setup_device=E2=80=99:
> drivers/ide/pmac.c:1090: error: implicit declaration of function
> =E2=80=98media_bay_set_ide_infos=E2=80=99
> make[2]: *** [drivers/ide/pmac.o] Error 1
> make[1]: *** [drivers/ide] Error 2
> make: *** [drivers] Error 2
> ---

IDE PMAC host driver can be modular now so we need to export
check_media_bay_by_base() and media_bay_set_ide_infos().

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
=2D--
 drivers/macintosh/mediabay.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/macintosh/mediabay.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -447,6 +447,7 @@ int check_media_bay_by_base(unsigned lon
=20
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(check_media_bay_by_base);
=20
 int media_bay_set_ide_infos(struct device_node* which_bay, unsigned long b=
ase,
 			    int irq, ide_hwif_t *hwif)
@@ -486,6 +487,7 @@ int media_bay_set_ide_infos(struct devic
=20
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(media_bay_set_ide_infos);
 #endif /* CONFIG_BLK_DEV_IDE_PMAC */
=20
 static void media_bay_step(int i)
