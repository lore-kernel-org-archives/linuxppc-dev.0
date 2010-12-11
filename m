Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [72.52.115.56])
	by ozlabs.org (Postfix) with SMTP id 57C3CB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Dec 2010 05:39:06 +1100 (EST)
Received: from chimera.site ([173.50.240.230]) by xenotime.net for
	<linuxppc-dev@lists.ozlabs.org>; Sat, 11 Dec 2010 10:28:59 -0800
Date: Sat, 11 Dec 2010 10:28:58 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 1/2] video, sm501: add OF binding to support SM501
Message-Id: <20101211102858.fd1b5426.rdunlap@xenotime.net>
In-Reply-To: <1292049075-1809-1-git-send-email-hs@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1292049075-1809-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 11 Dec 2010 07:31:15 +0100 Heiko Schocher wrote:

> - add commandline options:
>   sm501.fb_mode:

    sm501.mode:

>     Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>   sm501.bpp:
>     Specify bit-per-pixel if not specified mode
> 
> ---
> 
>  Documentation/kernel-parameters.txt          |    7 +
>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
>  drivers/mfd/sm501.c                          |  141 ++++++++------
>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
>  include/linux/sm501.h                        |    8 +
>  5 files changed, 299 insertions(+), 151 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index cdd2a6e..6341541 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2301,6 +2301,13 @@ and is between 256 and 4096 characters. It is defined in the file
>  			merging on their own.
>  			For more information see Documentation/vm/slub.txt.
>  
> +	sm501.bpp=	SM501 Display driver:
> +			Specify bit-per-pixel if not specified mode

			Specifiy bits-per-pixel if not specified by 'mode'

> +
> +	sm501fb.mode=	SM501 Display driver:
> +			Specify resolution as
> +			"<xres>x<yres>[-<bpp>][@<refresh>]"
> +
>  	smart2=		[HW]
>  			Format: <io1>[,<io2>[,...,<io8>]]


However, I think that these shouldn't be added to Documentation/kernel-parameters.txt
but should be added to the Documentation/fb/ sub-directory either by adding to
Documentation/fb/modedb.txt or by adding a new file Documentation/fb/sm501.txt.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
