Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 2AF97DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 18:05:35 +1000 (EST)
Date: Tue, 6 May 2008 10:08:11 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] add Phytec pcm030 board support
Message-ID: <20080506080811.GB4326@pengutronix.de>
References: <20080425134805.GP6692@pengutronix.de>
	<9e4733910805051001h2c02fd57yb246091af8bf5a7d@mail.gmail.com>
	<fa686aa40805051008t656e7e11pc469b6a43241c63f@mail.gmail.com>
	<9e4733910805051022q7c2f868bw80173fd93e92b907@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910805051022q7c2f868bw80173fd93e92b907@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 05, 2008 at 01:22:40PM -0400, Jon Smirl wrote:
> On 5/5/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Mon, May 5, 2008 at 11:01 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> >  > Did this get fixed somehow? I used to need this to boot a pcm030.
> >
> >
> > I'm sorry; I'm at a lost as to context.  Are you asking for this patch
> >  to be applied?  Or are you asking if this has been addressed in
> >  another way?
> 
> Sascha said the pcm030 was working with the simple dts. I always
> needed that patch to get a pcm030 to boot. Sasha's company wrote the
> patch. I'm just wondering how it got handled, do we still need the
> patch or did he come up with some other solution.

Yes, it is working with the simple dts except for the flash support. For
this we need the Flash description in the oftree.

> >  >
> >  >  diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
> >  >  index 272872d..c982adc 100644
> >  >  --- a/fs/jffs2/scan.c
> >  >  +++ b/fs/jffs2/scan.c
> >  >  @@ -16,6 +16,7 @@
> >  >   #include <linux/pagemap.h>
> >  >   #include <linux/crc32.h>
> >  >   #include <linux/compiler.h>
> >  >  +#include <asm/io.h>
> >  >   #include "nodelist.h"
> >  >   #include "summary.h"
> >  >   #include "debug.h"
> >  >  @@ -505,7 +506,7 @@ static int jffs2_scan_eraseblock (struct
> >  >  jffs2_sb_info *c, struct jffs2_eraseblo
> >  >                                         sumptr = kmalloc(sumlen, GFP_KERNEL);
> >  >                                         if (!sumptr)
> >  >                                                 return -ENOMEM;
> >  >  -                                       memcpy(sumptr + sumlen -
> >  >  buf_len, buf + buf_size - buf_len, buf_len);
> >  >  +                                       memcpy_fromio(sumptr + sumlen
> >  >  - buf_len, buf + buf_size - buf_len, buf_len);
> >  >                                 }
> >  >                                 if (buf_len < sumlen) {
> >  >                                         /* Need to read more so that
> >  >  the entire summary node is present */
> >  >  @@ -1035,7 +1036,7 @@ static int jffs2_scan_dirent_node(struct
> >  >  jffs2_sb_info *c, struct jffs2_eraseblo
> >  >         if (!fd) {
> >  >                 return -ENOMEM;
> >  >         }
> >  >  -       memcpy(&fd->name, rd->name, checkedlen);
> >  >  +       memcpy_fromio(&fd->name, rd->name, checkedlen);

This patch is needed because memcpy uses unaligned accesses whereas
memcpy_fromio only uses aligned accesses on the io side. See this
thread: http://ozlabs.org/pipermail/linuxppc-embedded/2006-April/022544.html


-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
