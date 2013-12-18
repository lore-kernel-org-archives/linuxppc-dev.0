Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D49E22C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 08:43:51 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 22:44:08 +0100
Message-Id: <0AB88010-F2B7-44A1-8FA9-2A40079706BB@suse.de>
References: <1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.11.2013, at 15:02, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Don't try to compute these values.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>=20
> NOTE: I am not sure why we were originally computing dsisr and dar. So =
may be
> we need a variant of this patch. But with this and the additional =
patch
> "powerpc: book3s: PR: Enable Little Endian PR guest" I am able to get =
a Little Endian
> PR guest to boot.

It's quite easy to find out - git blame tells you all the history and =
points you to commit ca7f4203b.

commit ca7f4203b9b66e12d0d9968ff7dfe781f3a9695a
Author: Alexander Graf <agraf@suse.de>
Date:   Wed Mar 24 21:48:28 2010 +0100

    KVM: PPC: Implement alignment interrupt

    Mac OS X has some applications - namely the Finder - that require =
alignment
    interrupts to work properly. So we need to implement them.

    But the spec for 970 and 750 also looks different. While 750 =
requires the
    DSISR and DAR fields to reflect some instruction bits (DSISR) and =
the fault
    address (DAR), the 970 declares this as an optional feature. So we =
need
    to reconstruct DSISR and DAR manually.

    Signed-off-by: Alexander Graf <agraf@suse.de>
    Signed-off-by: Avi Kivity <avi@redhat.com>

Read this as "on 970, alignment interrupts don't give us DSISR and DAR =
of the faulting instruction" as otherwise I wouldn't have implemented =
it.

So this is clearly a nack on this patch :).


Alex
