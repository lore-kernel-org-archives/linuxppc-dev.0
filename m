Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8DE8B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 23:33:25 +1000 (EST)
In-Reply-To: <181804936ABC2349BE503168465576460F20CB90@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F1AAEC6@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AAEE1@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AB73E@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F20CB90@exchserver.basler.com>
Subject: RE: JFFS2 corruption when mounting filesystem with
	filenames	oflength> 7
To: "Steve Deiters" <SteveDeiters@BASLER.com>
Message-ID: <OFFDC634FC.2BD6844E-ONC125774E.0049ADAC-C125774E.0049E418@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 26 Jun 2010 15:27:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> > -----Original Message-----
> > From: linux-mtd-bounces@lists.infradead.org
> > [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of
> > Steve Deiters
> > Sent: Thursday, June 24, 2010 3:02 PM
> > To: linux-mtd@lists.infradead.org
> > Subject: RE: JFFS2 corruption when mounting filesystem with
> > filenames oflength> 7
> >
> > > -----Original Message-----
> > > From: linux-mtd-bounces@lists.infradead.org
> > > [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of Steve
> > > Deiters
> > > Sent: Wednesday, June 23, 2010 5:42 PM
> > > To: linux-mtd@lists.infradead.org
> > > Subject: RE: JFFS2 corruption when mounting filesystem with
> > filenames
> > > oflength > 7
> > >
> > > > -----Original Message-----
> > > > From: linux-mtd-bounces@lists.infradead.org
> > > > [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of Steve
> > > > Deiters
> > > > Sent: Wednesday, June 23, 2010 5:21 PM
> > > > To: linux-mtd@lists.infradead.org
> > > > Subject: JFFS2 corruption when mounting filesystem with
> > > filenames of
> > > > length > 7
> > > >
> > > > I found an archived post which seems to be identical to my issue.
> > > > However, this is quite old and there never seemed to be any
> > > > resolution.
> > > >
> > > > http://www.infradead.org/pipermail/linux-mtd/2006-September/01
> > > > 6491.html
> > > >
> > > > If I mount a filesystem that has filenames greater than 7
> > > characters
> > > > in length, the files are corrupted when I mount.
> > > > In my case, I am making a
> > > > JFFS2 image with mkfs.jffs2 and flashing it in with u-boot.
> > > > However, I have attached a workflow where I erase the Flash
> > > and create
> > > > a new filesystem completely within Linux and it gives the same
> > > > behavior.  I can list the files with the 'ls'
> > > > command from within u-boot.  If I mount from within
> > Linux, and then
> > > > reboot into u-boot, it will not display any files that had
> > > a filename
> > > > greater than 7 characters.
> > > >
> > > > I enabled the MTD debug verbosity at level 2 for the
> > > attached example
> > > > session.
> > > >
> > > > I am running on a custom board with a MPC5121 and Linux 2.6.33.4.
> > > >
> > > > Thanks in advance for any help.
> > >
> > >
> > > Sorry for the jumbled mess.  Looks like the line endings are messed
> > > up.
> > > Trying again.  I also provided this as an attachment in
> > case it gets
> > > messed up again.
> >
> > Once again sorry for the mess.
> >
> > I tried this again with the DENX-v2.6.34 tag in the DENX git
> > repository (git://git.denx.de/linux-2.6-denx.git).  The only
> > modification I made was to add my dts file.  I still get the
> > same issue I had before.
> >
> > I've attached my kernel config if that gives any clues.
> >
> > Are there any thoughts on what may be causing this?
> >
> > Thanks.
>
>
> I think there may be something weird going on with the memcpy in my
> build.  If I use the following patch I no longer get errors when I mount
> the filesystem.  All I did was replace the memcpy with a loop.
>
> I'm not sure what's special about this particular use of memcpy.  I
> can't believe that things would be working as well as they do if memcpy
> was broken in general.
>
> This is on a PowerPC 32 bit build for a MPC5121.  I am using a GCC 4.1.2
> to compile.  Is anyone aware of any issues with memcpy in this
> configuration?
>
> Thanks.
>
> -------
>
> diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
> index 46f870d..673caa2 100644
> --- a/fs/jffs2/scan.c
> +++ b/fs/jffs2/scan.c
> @@ -1038,7 +1038,10 @@ static int jffs2_scan_dirent_node(struct
> jffs2_sb_info *c, struct jffs2_eraseblo
>     if (!fd) {
>        return -ENOMEM;
>     }
> -   memcpy(&fd->name, rd->name, checkedlen);

Are the pointers to memcpy overlapping? If so memcpy is undefined
and you have to use memmove().

> +   int i;
> +   for(i = 0; i < checkedlen; i++)
> +      ((unsigned char*)fd->name)[i] = ((const unsigned
> char*)rd->name)[i];
> +
>     fd->name[checkedlen] = 0;
>
>     crc = crc32(0, fd->name, rd->nsize);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
