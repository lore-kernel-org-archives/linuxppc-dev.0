Return-Path: <frowand.list@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHchl5rwnzDqnv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 00:20:39 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id 77so8357886itj.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:20:39 -0700 (PDT)
Subject: Re: [PATCH 0/4] Removing full paths from DT full_name
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20170725214427.25768-1-robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Frank Rowand <frowand.list@gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <5978A534.5030008@gmail.com>
Date: Wed, 26 Jul 2017 07:20:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170725214427.25768-1-robh@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rob,

On 07/25/17 14:44, Rob Herring wrote:
> This series is the last steps to remove storing the full path for every 
> DT node. Instead, we can create full path strings dynamically as needed 
> with printf %pOF specifiers (commit ce4fecf1fe15). There are a number of 
> remaining direct users of full_name after this series. I don't believe 
> there should be any functional impact for those users with the change to 
> only the node name (+unit-address). The majority are for struct 
> resource.name. This should only affect /proc/iomem display.

I added a new dependency on full_name in:

  [PATCH v4 3/3] of: overlay: add overlay symbols to live device tree

You don't need to fix that -- I knew the removal of full_name was coming
and expected to adapt to that change when it came, so I'll take care of
it.  It will probably take me two or three weeks to get to it, but that
shouldn't be a big deal since the affected code is a new feature that
is not yet used.

-Frank

> 
> Patches 1 and 2 can be applied now for 4.14. For patches 3 and 4, my 
> target is 4.15 after all the dependencies have been merged.
> 
> PPC folks, Please test! The PPC parts are untested. A git branch with 
> all the dependencies is here[1].
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt-printf
> 
> Rob Herring (4):
>   powerpc: pseries: vio: match parent nodes with of_find_node_by_path
>   powerpc: pseries: remove dlpar_attach_node dependency on full path
>   powerpc: pseries: only store the device node basename in full_name
>   of/fdt: only store the device node basename in full_name
> 
>  arch/powerpc/platforms/pseries/dlpar.c       | 26 +++--------
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  2 +-
>  arch/powerpc/platforms/pseries/mobility.c    |  2 +-
>  arch/powerpc/platforms/pseries/pseries.h     |  2 +-
>  arch/powerpc/platforms/pseries/reconfig.c    |  2 +-
>  arch/powerpc/platforms/pseries/vio.c         |  4 +-
>  drivers/of/fdt.c                             | 69 +++++-----------------------
>  7 files changed, 23 insertions(+), 84 deletions(-)
> 
