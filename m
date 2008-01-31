Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D5F79DDFE4
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 08:16:23 +1100 (EST)
Message-ID: <47A239C6.8070402@am.sony.com>
Date: Thu, 31 Jan 2008 13:12:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] [POWERPC] bootwrapper: build multiple cuImages
References: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
In-Reply-To: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 01/30/2008 04:34 PM, Grant Likely wrote:
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
...
>  $(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts

Seems like this could use $(dtstree).

>  	$(STRIP) -s -R .comment $< -o vmlinux.strip
> -	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
> +	$(call cmd,wrap,ps3,$(dtstree)/ps3.dts,,)
>  
>  $(obj)/zImage.initrd.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts $(obj)/ramdisk.image.gz

Same here.

> -	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,$(obj)/ramdisk.image.gz)
> +	$(call cmd,wrap,ps3,$(dtstree)/ps3.dts,,$(obj)/ramdisk.image.gz)
