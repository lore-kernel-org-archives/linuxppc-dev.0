Return-Path: <khalid.aziz@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yh7kT0jyQzDr0n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 01:48:32 +1100 (AEDT)
Message-ID: <1511275666.14446.1.camel@oracle.com>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, benh@kernel.crashing.org, paulus@samba.org,
 akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
 arbab@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, mhocko@suse.com, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, mgorman@techsingularity.net
Date: Tue, 21 Nov 2017 07:47:46 -0700
In-Reply-To: <20171117014601.31606-1-pasha.tatashin@oracle.com>
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-16 at 20:46 -0500, Pavel Tatashin wrote:
> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> as all the page initialization code is in common code.
>=20
> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization
> code
> does not really use hotplug memory functionality. So, we can remove
> this
> requirement as well.
>=20
> This patch allows to use deferred struct page initialization on all
> platforms with memblock allocator.
>=20
> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> PPC with CONFIG_MEMORY_HOTPLUG disabled.
>=20
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
> =C2=A0arch/powerpc/Kconfig | 1 -
> =C2=A0arch/s390/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0| 1 -
> =C2=A0arch/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 1 -
> =C2=A0mm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 7 +------
> =C2=A04 files changed, 1 insertion(+), 9 deletions(-)
>=20
>=20

Looks reasonable to me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
