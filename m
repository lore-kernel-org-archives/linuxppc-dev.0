Return-Path: <error27@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 0A58AB6EEA
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 20:50:05 +1000 (EST)
Received: by wwb22 with SMTP id 22so2632912wwb.21
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Aug 2010 03:50:03 -0700 (PDT)
Date: Sun, 1 Aug 2010 12:49:41 +0200
From: Dan Carpenter <error27@gmail.com>
To: Vasiliy Kulikov <segooon@gmail.com>
Subject: Re: [PATCH 2/7] usb: fsl_udc_core: check return value of
	create_proc_read_entry()
Message-ID: <20100801104941.GI26313@bicker>
References: <1280597900-8405-1-git-send-email-segooon@gmail.com>
	<20100731191743.GF26313@bicker> <20100801061934.GB2650@albatros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100801061934.GB2650@albatros>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 01, 2010 at 10:19:34AM +0400, Vasiliy Kulikov wrote:
> On Sat, Jul 31, 2010 at 21:17 +0200, Dan Carpenter wrote:
> > On Sat, Jul 31, 2010 at 09:38:20PM +0400, Kulikov Vasiliy wrote:
> > > create_proc_read_entry() may fail, if so return -ENOMEM.
> > > 
> > 
> > It can fail, but also we return NULL if procfs is disabled.  I haven't
> > looked at it very carefully, would this patch break the module if procfs
> > was disabled?
> Probably you are right, but many drivers in tree compare return value
> with NULL. Some of them interpret this as error, some of them simply
> call pr_warn("Hmm, I cannot create file in proc, strange..."). Maybe
> there is more simplier way to check it without #ifdefs?
> 

If the allocation fails, there is already a warning so no need to add
another.

These things are one time allocation, normally near boot up when memory
is plentifull.  The places that do check should be audited to make sure
there isn't an unneeded dependency on PROC_FS.  I would just leave the
rest.

regards,
dan carpenter
