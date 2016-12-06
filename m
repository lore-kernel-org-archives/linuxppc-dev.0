Return-Path: <re.emese@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYF714M3TzDvk1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 08:26:21 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id u144so23980744wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 13:26:21 -0800 (PST)
Date: Tue, 6 Dec 2016 22:25:20 +0100
From: Emese Revfy <re.emese@gmail.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-hardening@lists.openwall.com,
 keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, pageexec@freemail.hu, spender@grsecurity.net,
 mmarek@suse.com
Subject: Re: [PATCH 3/3] powerpc: enable support for GCC plugins
Message-Id: <20161206222520.7fb37896488eff1b299eb3db@gmail.com>
In-Reply-To: <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Dec 2016 17:28:00 +1100
Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:

> +      # Various gccs between 4.5 and 5.1 have bugs on powerpc due to missing
> +      # header files. gcc <= 4.6 doesn't work at all, gccs from 4.8 to 5.1 have
> +      # issues with 64-bit targets.
> +      ifeq ($(ARCH),powerpc)
> +        ifeq ($(call cc-ifversion, -le, 0501, y), y)
> +	  @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1
> +        endif
> +      endif

Hi,

What are these missing headers? Because if they aren't necessary then they can
be removed from gcc-common.h. There were missing headers on arm/arm64 and these
archs are supported. I think this version check is unnecessary because
gcc-plugin.sh also checks the missing headers.

What is the problem on gcc-4.5/gcc-4.6?

-- 
Emese
