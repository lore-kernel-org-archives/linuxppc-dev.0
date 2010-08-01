Return-Path: <segooon@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 0E9A11007D1
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 16:19:55 +1000 (EST)
Received: by eyh6 with SMTP id 6so5790253eyh.15
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 23:19:54 -0700 (PDT)
Date: Sun, 1 Aug 2010 10:19:34 +0400
From: Vasiliy Kulikov <segooon@gmail.com>
To: Dan Carpenter <error27@gmail.com>, kernel-janitors@vger.kernel.org,
	Li Yang <leoli@freescale.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] usb: fsl_udc_core: check return value of
	create_proc_read_entry()
Message-ID: <20100801061934.GB2650@albatros>
References: <1280597900-8405-1-git-send-email-segooon@gmail.com>
	<20100731191743.GF26313@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100731191743.GF26313@bicker>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 31, 2010 at 21:17 +0200, Dan Carpenter wrote:
> On Sat, Jul 31, 2010 at 09:38:20PM +0400, Kulikov Vasiliy wrote:
> > create_proc_read_entry() may fail, if so return -ENOMEM.
> > 
> 
> It can fail, but also we return NULL if procfs is disabled.  I haven't
> looked at it very carefully, would this patch break the module if procfs
> was disabled?
Probably you are right, but many drivers in tree compare return value
with NULL. Some of them interpret this as error, some of them simply
call pr_warn("Hmm, I cannot create file in proc, strange..."). Maybe
there is more simplier way to check it without #ifdefs?

> 
> The same applies to the similar patches in this set.
> 
> regards,
> dan carpenter
> 
> 
