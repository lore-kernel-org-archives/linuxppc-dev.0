Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE381A0205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 00:47:09 +1000 (AEST)
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14F3614009B
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 00:47:07 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Tue, 21 Apr 2015 15:47:04 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CC8D31B08061
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 15:47:38 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3LEl2XB4063522
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 14:47:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3LEkw7K031894
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 08:47:01 -0600
In-Reply-To: <5535D83C.1060302@linux.vnet.ibm.com>
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <54A50094.5070902@linux.vnet.ibm.com> <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
 <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
 <1426718702.4866.2.camel@neuling.org> <1426719027.4866.4.camel@neuling.org>
 <550FEC36.8080803@linux.vnet.ibm.com>
 <OF91038A37.65C405E5-ONC1257E21.0061938F-C1257E21.00620A03@de.ibm.com>
 <1428534695.4682.18.camel@neuling.org> <55267595.90
 <5527938B.1030901@linux.vnet.ibm.com> <552B82F9.3080108@linux.vnet.ibm.com>
 <5535D83C.1060302@linux.vnet.ibm.com>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Message-ID: <OF1F8375CD.27A71A83-ONC1257E2E.00506121-C1257E2E.0050AC3C@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Tue, 21 Apr 2015 16:41:09 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: shuahkh@osg.samsung.com, Michael Neuling <mikey@neuling.org>,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 peterz@infradead.org, palves@redhat.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, tglx@linutronix.de, oleg@redhat.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 21.04.2015
06:55:24:

> Changed ELF core note sections
> ------------------------------
> These core note sections need to be changed to accommodate the in
> transaction ptrace requests when the running/current value of these
> registers will reside some where else instead of the original places
> of thread_struct.
>
> /* Running register state */
> (1) NT_PRFPREG            (Accessible always)
> (2) NT_PPC_VMX            (Accessible always)
> (3) NT_PPC_VSX            (Accessible always)
>
> New ELF core note sections
> --------------------------
> /* TM check pointed register set */
> (1) NT_PPC_TM_CGPR   --> NT_PRSTATUS   (Accessible inside TM)
> (2) NT_PPC_TM_CFPR   --> NT_PRFPREG   (Accessible inside TM)
> (3) NT_PPC_TM_CVMX   --> NT_PPC_VMX   (Accessible inside TM)
> (4) NT_PPC_TM_CVSX   --> NT_PPC_VSX   (Accessible inside TM)
>
> NOTE: The register set data structure for these ELF core not
> sections would exactly match with that of the corresponding
> running value register sets indicated above.

OK.

> /* TM SPR set */         (Accessible always)
> (5) NT_PPC_TM_SPR   thread->tm_tfhar
>          thread->tm_tfiar
>          thread->ttm_exasr

OK.

> /* TM check pointed misc register set */
> (6) NT_PPC_TM_TAR   thread->tm_tar   (Accessible inside TM)
> (7) NT_PPC_TM_PPR   thread->tm_ppr   (Accessible inside TM)
> (8) NT_PPC_TM_DSCR   thread->tm_dscr (Accessible inside TM)
>
> NOTE: Application can have a different set of TAR, PPR and DSCR
> registers inside the transaction compared that of the outside.
> Also seems like they are *not* the check pointed ones, will
> double check on this. Changed the core note section name from
> NT_PPC_TM_CTAR to just NT_PPC_TM_TAR and for all the others.

Huh?  How is this not the checkpointed set?  I would have
expected that NT_PPC_TAR contains the current tar (which is
the one in the transaction if we're within one), while
NT_PPC_TM_CTAR contains the checkpointed value that will be
restored once the transaction aborts.  Why is this not the
case?

> NOTE: They are like any other special purpose register which can
> be changed from the user space. So the elf core note section name
> can be generic. Here are some optional ELF core note sections
> which we can also add like the above ones.
>
> (12)   NT_PPC_EBBRR   thread->ebbrr   (Accessible inside EBB)
> (13)   NT_PPC_EBBHR   thread->ebbhr   (Accessible inside EBB)
> (14)   NT_PPC_BESCR   thread->bescr   (Accessible inside EBB)
> (15)   NT_PPC_SIAR   thread->siar   (Accessible inside EBB)
> (16)    NT_PPC_SDAR   thread->sdar   (Accessible inside EBB)
> (17)   NT_PPC_SIER   thread->sier   (Accessible inside EBB)
> (18)   NT_PPC_MMCR2   thread->mmcr2   (Accessible inside EBB)
> (19)   NT_PPC_MMCR0   thread->mmcr0   (Accessible inside EBB)

So I'm not really familiar with the EBB stuff.  But just as a
general note, if those are in fact related (i.e. on every machine
that has EBB, all those registers will be available), it might
indeed make more sense to collect them into a single note section
(NT_PPC_EBB?) after all.

Bye,
Ulrich
