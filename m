Return-Path: <bzolnier@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id CF0CCB6EEB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2010 05:17:31 +1100 (EST)
Received: by ewy6 with SMTP id 6so11999742ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Jan 2010 10:17:29 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] HVSI: Fix apparently backwards args to time_before() in
	hvsi.c
Date: Fri, 1 Jan 2010 19:15:47 +0100
References: <alpine.LFD.2.00.1001011226020.24958@localhost>
In-Reply-To: <alpine.LFD.2.00.1001011226020.24958@localhost>
MIME-Version: 1.0
Message-Id: <201001011915.47849.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: Joe Perches <joe@perches.com>, linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 01 January 2010 06:28:03 pm Robert P. J. Day wrote:
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   no appropriate subsystem maintainer listed in MAINTAINERS.

drivers/char/Makefile:
obj-$(CONFIG_HVC_CONSOLE)       += hvc_vio.o hvsi.o

so it should belong to:

HYPERVISOR VIRTUAL CONSOLE DRIVER
L:      linuxppc-dev@ozlabs.org
S:      Odd Fixes
F:      drivers/char/hvc_*

[ Though maybe Ben would be willing to pick this one up directly
  as hvsi is PPC specific thingy and patch is obviously correct. ]

> diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
> index 793b236..71c0fcd 100644
> --- a/drivers/char/hvsi.c
> +++ b/drivers/char/hvsi.c
> @@ -711,7 +711,7 @@ static void hvsi_drain_input(struct hvsi_struct *hp)
>  	uint8_t buf[HVSI_MAX_READ] __ALIGNED__;
>  	unsigned long end_jiffies = jiffies + HVSI_TIMEOUT;
> 
> -	while (time_before(end_jiffies, jiffies))
> +	while (time_before(jiffies, end_jiffies))
>  		if (0 == hvsi_read(hp, buf, HVSI_MAX_READ))
>  			break;
>  }

--
Bartlomiej Zolnierkiewicz
