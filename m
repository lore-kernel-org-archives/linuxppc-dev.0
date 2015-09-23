Return-Path: <mmarek@suse.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE7461A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 19:50:57 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3877E1401DE
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2015 19:50:56 +1000 (AEST)
Subject: Re: [RFC PATCH 1/2] scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG
 to be a target
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 yann.morin.1998@free.fr
From: Michal Marek <mmarek@suse.com>
Message-ID: <560275FC.60104@suse.com>
Date: Wed, 23 Sep 2015 11:50:52 +0200
MIME-Version: 1.0
In-Reply-To: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015-09-23 07:40, Michael Ellerman wrote:
> +else ifneq ($(wildcard arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
>  	@$(kecho) "*** Default configuration is based on '$(KBUILD_DEFCONFIG)'"
>  	$(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kconfig)
> +else
> +	@$(kecho) "*** Default configuration is based on target '$(KBUILD_DEFCONFIG)'"
> +	$(Q)$(MAKE) -f $(srctree)/Makefile $(KBUILD_DEFCONFIG)
>  endif

What is the anticipated usage of this? The patch is not needed to make

  make ppc64le_defconfig

work with the second patch. If it was, this would create a loop anyway.

Michal
