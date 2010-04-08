Return-Path: <BATV+3e47b603ed6d9c45fb78+2419+infradead.org+mchehab@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F54DB7C67
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Apr 2010 08:56:37 +1000 (EST)
Message-ID: <4BBE5EF0.5000801@infradead.org>
Date: Thu, 08 Apr 2010 19:55:44 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] device_attributes: add sysfs_attr_init() for dynamic
	attributes
References: <1270170140-325-1-git-send-email-w.sang@pengutronix.de>
	<1270170140-325-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1270170140-325-2-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: platform-driver-x86@vger.kernel.org, Len Brown <len.brown@intel.com>,
	Michal Simek <monstr@monstr.eu>, linux-media@vger.kernel.org,
	Lin Ming <ming.m.lin@intel.com>,
	Krzysztof Helt <krzysztof.h1@wp.pl>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bob Moore <robert.moore@intel.com>, Kai Jiang <b18973@freescale.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sujith Thomas <sujith.thomas@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anatolij Gustschin <agust@denx.de>, Mike Isely <isely@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, Matthew Garrett <mjg@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> Made necessary by 6992f5334995af474c2b58d010d08bc597f0f2fe. Prevents further
> "key xxx not in .data" bug-reports. Although some attributes could probably be
> converted to static ones, this is left for people having hardware to test.
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
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Greg KH <gregkh@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/macintosh/windfarm_core.c           |    1 +
>  drivers/media/video/pvrusb2/pvrusb2-sysfs.c |    8 ++++++++

I suspect that several (if not all) occurrences at pvrusb2 could be replaced by
static attributes, but let Mike Isely have the final word on that, as the driver
maintainer. From my side, I'm ok with either options.

Cheers,
Mauro
