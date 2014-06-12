Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A06B21A054E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 12:07:14 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 12 Jun 2014 07:37:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 01710E004B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 07:38:07 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5C27x0L7274938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 07:38:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5C2762F004986
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 07:37:06 +0530
Message-ID: <53990B48.8010902@linux.vnet.ibm.com>
Date: Thu, 12 Jun 2014 10:07:04 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH v2] powerpc: Avoid circular dependency with zImage.%
References: <53984D4F.6040808@linux.vnet.ibm.com>
 <1402501243-28213-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <1402501243-28213-1-git-send-email-mmarek@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This v2 patch is good,

Tested-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

On 06/11/2014 11:40 PM, Michal Marek wrote:
> The rule to create the final images uses a zImage.% pattern.
> Unfortunately, this also matches the names of the zImage.*.lds linker
> scripts, which appear as a dependency of the final images. This somehow
> worked when $(srctree) used to be an absolute path, but now the pattern
> matches too much. List only the images from $(image-y) as the target of
> the rule, to avoid the circular dependency.
>
> Signed-off-by: Michal Marek <mmarek@suse.cz>
> ---
> v2:
>    - Filter out duplicates in the target list
>    - fix the platform argument to cmd_wrap
>
>   arch/powerpc/boot/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 426dce7..ccc25ed 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -333,8 +333,8 @@ $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
>   $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
>   	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
>
> -$(obj)/zImage.%: vmlinux $(wrapperbits)
> -	$(call if_changed,wrap,$*)
> +$(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))
>
>   # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
>   $(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
