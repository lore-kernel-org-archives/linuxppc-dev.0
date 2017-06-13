Return-Path: <dcaratti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn84m6w4dzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 22:21:12 +1000 (AEST)
Message-ID: <1497356469.2604.18.camel@redhat.com>
Subject: Re: [PATCH] powerpc/configs: fix default values for NF_CT_PROTO_*
From: Davide Caratti <dcaratti@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <87lgowgo2f.fsf@concordia.ellerman.id.au>
References: <eb1df478772aec9e4caa43f575df5579c1f4170a.1496668107.git.dcaratti@redhat.com>
 <87lgowgo2f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jun 2017 14:21:09 +0200
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 20:49 +1000, Michael Ellerman wrote:
> Davide Caratti <dcaratti@redhat.com> writes:
> 
> > NF_CT_PROTO_{SCTP,UDPLITE,DCCP} can't be set to 'm' anymore, since they
> > have been redefined as 'bool': fix defconfig for linkstation, mvme5100 and
> > ppc6xx platforms accordingly.
> 
> Since when? ie. which commit changed the symbols to bool from tristate?
> 
> cheers

hello Michael,

the commits are:

a85406afeb3e ("netfilter: conntrack: built-in support for SCTP")
c51d39010a1b ("netfilter: conntrack: built-in support for DCCP")
9b91c96c5d1f ("netfilter: conntrack: built-in support for UDPlite")

they were causing a "warning symbol value 'm' invalid" in kconfig: sorry
for not noticing this before. I see that ARM and MIPS already have a fix:

5aff1d245e8c ("ARM: defconfigs: make NF_CT_PROTO_SCTP and
NF_CT_PROTO_UDPLITE built-in")
9ddc16ad8e0b ("MIPS: Update defconfigs for NF_CT_PROTO_DCCP/UDPLITE
change")

but (some) ppc and tile defconfig were still missing the correction:
that's why I submitted this patch (and a similar one, http://www.mail-arch
ive.com/linux-kernel@vger.kernel.org/msg1413473.html , for tile).

thank you for looking at this,
regards
--
davide
