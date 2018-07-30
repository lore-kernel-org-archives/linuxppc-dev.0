Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fNl84LFFzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 01:28:52 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6UFPEGo068489
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 11:28:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kj57f0b3x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 11:28:49 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Mon, 30 Jul 2018 09:28:48 -0600
Date: Mon, 30 Jul 2018 12:28:38 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Cyril Bur <cyrilbur@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
Message-Id: <20180730152838.GA23704@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>
> > Simplify the message format by using REG_FMT as the register format.  This
> > avoids having two different formats and avoids checking for MSR_64BIT.
>
> Are you sure it is what we want ?

Yes.

> Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?

In fact, this changes how many zeroes are prefixed when displaying the registers
(%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kernel:

before this series:
  [66475.002900] segv[4599]: unhandled signal 11 at 00000000 nip 10000420 lr 0fe61854 code 1

after this series:
  [   73.414535] segv[3759]: segfault (11) at 0000000000000000 nip 0000000010000420 lr 000000000fe61854 code 1 in segv[10000000+10000]
  [   73.414641] segv[3759]: code: 4e800421 80010014 38210010 7c0803a6 4bffff30 9421ffd0 93e1002c 7c3f0b78
  [   73.414665] segv[3759]: code: 39200000 913f001c 813f001c 39400001 <91490000> 39200000 7d234b78 397f0030

Have you spotted any other behaviour change?

Cheers
Murilo
