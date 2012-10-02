Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AE732C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 07:47:55 +1000 (EST)
Subject: Re: [REGRESSION] nfsd crashing with 3.6.0-rc7 on PowerPC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20121002214327.GA29218@linux.vnet.ibm.com>
Date: Tue, 2 Oct 2012 23:47:39 +0200
Message-Id: <9257E705-4EF9-4347-945C-B4A7582C427F@suse.de>
References: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
 <CA+55aFyXwB1QcXE4Z_FAGnXROSgvP2x2+wjnX9OWPa4Dfaaf0A@mail.gmail.com>
 <DC545CD9-8745-47DD-B13B-3385C0EB5B27@suse.de>
 <20120928151043.GA19102@fieldses.org>
 <2A52FC96-148C-4F7A-9950-E152E0C6698D@suse.de>
 <1349139509.3847.2.camel@pasglop> <20121002214327.GA29218@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML List <linux-kernel@vger.kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>, anton@samba.org,
 skinsbursky@parallels.com, bfields@redhat.com,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.10.2012, at 23:43, Nishanth Aravamudan wrote:

> Hi Ben,
>=20
> On 02.10.2012 [10:58:29 +1000], Benjamin Herrenschmidt wrote:
>> On Mon, 2012-10-01 at 16:03 +0200, Alexander Graf wrote:
>>> Phew. Here we go :). It looks to be more of a PPC specific problem
>>> than it appeared as at first:
>>=20
>> Ok, so I suspect the problem is the pushing down of the locks which
>> breaks with iommu backends that have a separate flush callback. In
>> that case, the flush moves out of the allocator lock.
>>=20
>> Now we do call flush before we return, still, but it becomes racy
>> I suspect, but somebody needs to give it a closer look. I'm hoping
>> Anton or Nish will later today.
>=20
> Started looking into this. If your suspicion were accurate, wouldn't =
the
> bisection have stopped at 0e4bc95d87394364f408627067238453830bdbf3
> ("powerpc/iommu: Reduce spinlock coverage in iommu_alloc and
> iommu_free")?
>=20
> Alex, the error is reproducible, right?

Yes. I'm having a hard time to figure out if the reason my U4 based G5 =
Mac crashes and fails reading data is the same since I don't have a =
serial connection there, but I assume so.

> Does it go away by reverting
> that commit against mainline? Just trying to narrow down my focus.

The patch doesn't revert that easily. Mind to provide a revert patch so =
I can try?


Alex
