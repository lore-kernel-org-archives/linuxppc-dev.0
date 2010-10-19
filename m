Return-Path: <pku.leo@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 517AAB70D2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 20:37:32 +1100 (EST)
Received: by wyf23 with SMTP id 23so3362303wyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 02:37:30 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20101018223256.GA30946@udp111988uds.am.freescale.net>
References: <20101018223256.GA30946@udp111988uds.am.freescale.net>
Date: Tue, 19 Oct 2010 17:37:30 +0800
Message-ID: <AANLkTimp1fs=TU4PZTf771qRz_xYnOQMQG7N0BE_bhxg@mail.gmail.com>
Subject: Re: [PATCH RFC] PPC: /dev/mem: All RAM is cacheable,
	not just the kernel's.
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 19, 2010 at 6:32 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> If mem=3D is used on the kernel command line to create reserved regions
> for userspace to map using /dev/mem, let it be mapped cacheable as long
> as it is within the memory region described in the device tree.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This isn't just a performance issue, but it could also be a correctness
> issue, if the reserved portion of RAM is mapped cacheable by e.g. a KVM
> guest. =C2=A0This patch does not address cases where such regions could s=
how up
> as something other than a standard memory node -- such as shared regions
> in an AMP configuration. =C2=A0Ideally there would be some means for a pl=
atform
> to register cacheable regions, without having to completely replace the
> entire phys_mem_access_prot function.

Agreed.  Such requirement might be special case in server/desktop
world, but much more common in embedded market when migrating to
multi-core in which shared memory is commonly used for inter-core
communication.  It will be best to have a common way to achieve this.

Not only cache-ability but also coherent property might need to be tunable.

- Leo
