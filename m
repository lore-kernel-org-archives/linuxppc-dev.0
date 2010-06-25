Return-Path: <stevedeiters@basler.com>
Received: from tethra.basler.com (tethra.basler.com [206.107.254.19])
	by ozlabs.org (Postfix) with ESMTP id 3BD441007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:54:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: JFFS2 corruption when mounting filesystem with filenames
	oflength> 7
Date: Fri, 25 Jun 2010 18:48:23 -0500
Message-ID: <181804936ABC2349BE503168465576460F20CB90@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460F1AB73E@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F1AAEC6@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AAEE1@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AB73E@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@BASLER.com>
To: <linux-mtd@lists.infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linux-mtd-bounces@lists.infradead.org=20
> [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of=20
> Steve Deiters
> Sent: Thursday, June 24, 2010 3:02 PM
> To: linux-mtd@lists.infradead.org
> Subject: RE: JFFS2 corruption when mounting filesystem with=20
> filenames oflength> 7
>=20
> > -----Original Message-----
> > From: linux-mtd-bounces@lists.infradead.org
> > [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of Steve=20
> > Deiters
> > Sent: Wednesday, June 23, 2010 5:42 PM
> > To: linux-mtd@lists.infradead.org
> > Subject: RE: JFFS2 corruption when mounting filesystem with=20
> filenames=20
> > oflength > 7
> >=20
> > > -----Original Message-----
> > > From: linux-mtd-bounces@lists.infradead.org
> > > [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of Steve=20
> > > Deiters
> > > Sent: Wednesday, June 23, 2010 5:21 PM
> > > To: linux-mtd@lists.infradead.org
> > > Subject: JFFS2 corruption when mounting filesystem with
> > filenames of
> > > length > 7
> > >=20
> > > I found an archived post which seems to be identical to my issue.
> > > However, this is quite old and there never seemed to be any=20
> > > resolution.
> > >=20
> > > http://www.infradead.org/pipermail/linux-mtd/2006-September/01
> > > 6491.html
> > >=20
> > > If I mount a filesystem that has filenames greater than 7
> > characters
> > > in length, the files are corrupted when I mount.
> > > In my case, I am making a
> > > JFFS2 image with mkfs.jffs2 and flashing it in with u-boot. =20
> > > However, I have attached a workflow where I erase the Flash
> > and create
> > > a new filesystem completely within Linux and it gives the same=20
> > > behavior.  I can list the files with the 'ls'
> > > command from within u-boot.  If I mount from within=20
> Linux, and then=20
> > > reboot into u-boot, it will not display any files that had
> > a filename
> > > greater than 7 characters.
> > >=20
> > > I enabled the MTD debug verbosity at level 2 for the
> > attached example
> > > session.
> > >=20
> > > I am running on a custom board with a MPC5121 and Linux 2.6.33.4.
> > >=20
> > > Thanks in advance for any help.
> >=20
> >=20
> > Sorry for the jumbled mess.  Looks like the line endings are messed=20
> > up.
> > Trying again.  I also provided this as an attachment in=20
> case it gets=20
> > messed up again.
>=20
> Once again sorry for the mess.
>=20
> I tried this again with the DENX-v2.6.34 tag in the DENX git=20
> repository (git://git.denx.de/linux-2.6-denx.git).  The only=20
> modification I made was to add my dts file.  I still get the=20
> same issue I had before.
>=20
> I've attached my kernel config if that gives any clues.
>=20
> Are there any thoughts on what may be causing this?
>=20
> Thanks.


I think there may be something weird going on with the memcpy in my
build.  If I use the following patch I no longer get errors when I mount
the filesystem.  All I did was replace the memcpy with a loop.

I'm not sure what's special about this particular use of memcpy.  I
can't believe that things would be working as well as they do if memcpy
was broken in general.

This is on a PowerPC 32 bit build for a MPC5121.  I am using a GCC 4.1.2
to compile.  Is anyone aware of any issues with memcpy in this
configuration?

Thanks.

-------

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 46f870d..673caa2 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -1038,7 +1038,10 @@ static int jffs2_scan_dirent_node(struct
jffs2_sb_info *c, struct jffs2_eraseblo
 	if (!fd) {
 		return -ENOMEM;
 	}
-	memcpy(&fd->name, rd->name, checkedlen);
+	int i;
+	for(i =3D 0; i < checkedlen; i++)
+		((unsigned char*)fd->name)[i] =3D ((const unsigned
char*)rd->name)[i];
+
 	fd->name[checkedlen] =3D 0;
=20
 	crc =3D crc32(0, fd->name, rd->nsize);
