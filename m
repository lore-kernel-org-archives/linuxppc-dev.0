Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bS7Y5ptWzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 06:51:21 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PKmaDg130075
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:51:18 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kf04j11g4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:51:18 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 25 Jul 2018 16:51:17 -0400
Date: Wed, 25 Jul 2018 17:51:08 -0300
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
Subject: Re: [PATCH 7/7] powerpc/traps: Show instructions on exceptions
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-8-muriloo@linux.ibm.com>
 <20180725180134.Horde.BdhyE2b-TXhoVB7W8bsBhg1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180725180134.Horde.BdhyE2b-TXhoVB7W8bsBhg1@messagerie.si.c-s.fr>
Message-Id: <20180725205108.GE23643@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Wed, Jul 25, 2018 at 06:01:34PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> 
> > Move show_instructions() declaration to arch/powerpc/include/asm/stacktrace.h
> > and include asm/stracktrace.h in arch/powerpc/kernel/process.c, which
> > contains
> > the implementation.
> > 
> > Modify show_instructions() not to call __kernel_text_address(), allowing
> > userspace instruction dump.  probe_kernel_address(), which returns -EFAULT if
> > something goes wrong, is still being called.
> > 
> > Call show_instructions() in arch/powerpc/kernel/traps.c to dump
> > instructions at
> > faulty location, useful to debugging.
> 
> Shouldn't this part be in a second patch ?

Makes sense.  Perhaps I should split this patch in two: one to remove
__kernel_text_address() check in show_instructions(), and another to
call show_instructions() in show_signal_msg().

> Wouldn't it be better to also see regs in addition if we want to use this to
> understand what happened ?
> So you could call show_regs() instead of show_instructions() ?

I see that show_regs() prints more information and calls
show_instructions() at the end if in privileged state.

I'm not sure about which situations we might want to call show_regs() -
and display a bunch of information - or just dump instructions for some
signals.

Isn't calling show_regs() in this case considered overkill?

Cheers
Murilo
