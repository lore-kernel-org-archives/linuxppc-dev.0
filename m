Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-gx0-f221.google.com (mail-gx0-f221.google.com
	[209.85.217.221]) by ozlabs.org (Postfix) with ESMTP id E2B25B7CF5
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 17:40:35 +1100 (EST)
Received: by gxk21 with SMTP id 21so2280868gxk.2
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 23:40:34 -0700 (PDT)
Date: Sun, 21 Mar 2010 23:40:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] device_attributes: add sysfs_attr_init() for dynamic
	attributes
Message-ID: <20100322064027.GG31621@core.coreip.homeip.net>
References: <1269238878-991-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269238878-991-1-git-send-email-w.sang@pengutronix.de>
Cc: platform-driver-x86@vger.kernel.org, Greg KH <gregkh@suse.de>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@infradead.org>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sujith Thomas <sujith.thomas@intel.com>,
	linux-media@vger.kernel.org, Mike Isely <isely@pobox.com>,
	Matthew Garrett <mjg@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On Mon, Mar 22, 2010 at 07:21:17AM +0100, Wolfram Sang wrote:
> Made necessary by 6992f5334995af474c2b58d010d08bc597f0f2fe.
> 
> Found by this semantic patch:
> 
> @ init @
> type T;
> identifier A;
> @@
> 
>         T {
>                 ...
>                 struct device_attribute A;
>                 ...
>         };
> 
> @ main extends init @
> expression E;
> statement S;
> identifier err;
> T *name;
> @@
> 
>         ... when != sysfs_attr_init(&name->A.attr);
> (
> +       sysfs_attr_init(&name->A.attr);
>         if (device_create_file(E, &name->A))
>                 S
> |
> +       sysfs_attr_init(&name->A.attr);
>         err = device_create_file(E, &name->A);
> )
> 
> While reviewing, I put the initialization to apropriate places.
> 

My standard question - are all of these need to be dynamically
allocated?

Thanks.

-- 
Dmitry
