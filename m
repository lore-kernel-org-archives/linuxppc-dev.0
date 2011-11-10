Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 95B69B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:07:57 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 00/17] powerpc/e500: separate e500 from e500mc
Date: Wed,  9 Nov 2011 19:06:58 -0500
Message-Id: <1320883635-17194-1-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Sorry for the repost, I accidentally omitted Baruch's email).

Hello,

I saw Baruch Siach's patch:
  powerpc: 85xx: separate e500 from e500mc

Unfortunately, that patch breaks the dependencies for the P5020DS
platform and does not fix the underlying code which does not
understand what the ambiguous "CONFIG_E500" means.

In order to fix the issue at the fundamental level, I created the
following 17-patch series loosely based on Baruch's patch.

=== High-Level Summary ===

The e500v1/v2 and e500mc/e5500 CPU families are not compatible with
each other, yet they share the same "CONFIG_E500" Kconfig option.

The following patch series splits the 32-bit CPU support into two
separate options: "CONFIG_FSL_E500_V1_V2" and "CONFIG_FSL_E500MC".
Additionally, the 64-bit e5500 support is separated to its own config
option ("CONFIG_FSL_E5500") which is automatically combined with
either 32-bit e500MC or 64-bit Book-3E when the P5020DS board support
is enabled.

I based the patches on v3.2-rc1, please let me know if I should
update the patches against a different tree.

The first 4 patches stand on their own merits; they are generic code
cleanups necessary to support the later patches.

I'd like to know what you all think.

Cheers,
Kyle Moffett

--
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
