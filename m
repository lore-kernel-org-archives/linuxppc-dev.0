Return-Path: <adobriyan@gmail.com>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226]) by ozlabs.org (Postfix) with ESMTP id 4BE3BB7D08
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 01:54:48 +1000 (EST)
Received: by ewy26 with SMTP id 26so1950714ewy.23
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 08:54:46 -0700 (PDT)
Date: Wed, 21 Apr 2010 18:55:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
Message-ID: <20100421155547.GA4222@x200>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh> <YeFfFNFyTSF.A.vUB.fSSzLB@tosh>
	<alpine.DEB.2.01.1004192339190.13016@bogon.housecafe.de>
	<1271765898.4324.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1271765898.4324.2.camel@concordia>
Cc: Christian Kujau <lists@nerdbynature.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	schwab@linux-m68k.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 20, 2010 at 10:18:18PM +1000, Michael Ellerman wrote:
> On Mon, 2010-04-19 at 23:45 -0700, Christian Kujau wrote:
> --- a/fs/proc/proc_devtree.c
> +++ b/fs/proc/proc_devtree.c
> @@ -175,6 +175,24 @@ retry:
>         return fixed_name;
>  }
>  
> +static const char *unslash_name(const char *name)
> +{
> +       char *p, *fixed_name;
> +
> +       fixed_name = kstrdup(name);
> +       if (!fixed_name) {
> +               printk(KERN_ERR "device-tree: Out of memory trying to unslash "
> +                               "name \"%s\"\n", name);
> +               return name;
> +       }
> +
> +       p = fixed_name;
> +       while ((p = strstr(p, "/")))
> +               *p++ = '_';

This is wasteful. :-)
Also, I hope we won't spit message every time allocation fail.
