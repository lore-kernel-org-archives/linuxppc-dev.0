Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BD3A1A1745
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 04:17:26 +1100 (EST)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B55F1400E2
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2014 04:17:25 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 8 Oct 2014 11:17:23 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1635019D8045
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2014 11:06:04 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s98HHKfM50266274
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Oct 2014 19:17:20 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s98HHILZ028669
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Oct 2014 11:17:19 -0600
Date: Wed, 8 Oct 2014 10:16:50 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 3/3] powerpc, ptrace: Enable support for miscellaneous
 registers
Message-ID: <20141008171650.GA7110@us.ibm.com>
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1400858138-3939-4-git-send-email-khandual@linux.vnet.ibm.com>
 <20140827213559.GB11489@us.ibm.com>
 <54356444.1080702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54356444.1080702@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org, davej@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
| On 08/28/2014 03:05 AM, Sukadev Bhattiprolu wrote:
| >=20
| > I see these in  arch/powerpc/include/asm/processor.h
| >=20
| > #ifdef CONFIG_PPC64
| >         unsigned long   dscr;
| >         int             dscr_inherit;
| >         unsigned long   ppr;    /* used to save/restore SMT priority */
| > #endif
| >=20
| > where there is an 'int' between ppr and dscr. So, should one of
| > the above sizeof(unsigned long) be changed to sizeof(int) ?
|=20
| Right, I understand that but strangely I get this compile time error
| when it is changed to sizeof(int).
|=20
|  error: call to =E2=80=98__compiletime_assert_1350=E2=80=99 declared with=
 attribute error:
|   BUILD_BUG_ON failed: TSO(dscr) + sizeof(unsigned long) + sizeof(int) !=
=3D TSO(ppr)
|   BUILD_BUG_ON(TSO(dscr) + sizeof(unsigned long) + sizeof(int) !=3D TSO(p=
pr));
|=20
| may be I am missing something here.

I guess there is a 4-byte padding after dscr_inherit. We could make that
explicit by adding a field or just go with the sizeof(unsigned long).

Thanks,

Sukadev
