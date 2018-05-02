Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bvqr09mLzF2T8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 09:39:03 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w42NcxeE065438
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 19:39:01 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hqmmnd5fv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 19:39:00 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 3 May 2018 00:38:56 +0100
Date: Wed, 2 May 2018 16:38:48 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Florian Weimer <fweimer@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
 Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>,
 linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
 X86 ML <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <20180502211254.GA5863@ram.oc3035372033.ibm.com>
 <CALCETrUfO=vXg5rT-n=y8pLktcq5+ORvgpsOXCHG4GaugB3k2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUfO=vXg5rT-n=y8pLktcq5+ORvgpsOXCHG4GaugB3k2A@mail.gmail.com>
Message-Id: <20180502233848.GB5863@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 02, 2018 at 09:18:11PM +0000, Andy Lutomirski wrote:
> On Wed, May 2, 2018 at 2:13 PM Ram Pai <linuxram@us.ibm.com> wrote:
> 
> 
> > > Ram, would you please comment?
> 
> > on POWER the pkey behavior will remain the same at entry or at exit from
> > the signal handler.  For eg:  if a key is read-disabled on entry into
> > the signal handler, and gets read-enabled in the signal handler, than it
> > will continue to be read-enabled on return from the signal handler.
> 
> > In other words, changes to key permissions persist across signal
> > boundaries.
> 
> I don't know about POWER's ISA, but this is crappy behavior.  If a thread
> temporarily grants itself access to a restrictive memory key and then gets
> a signal, the signal handler should *not* have access to that key.

This is a new requirement that I was not aware off. Its not documented
anywhere AFAICT.  Regardless of how the ISA behaves, its still a kernel
behavior that needs to be clearly defined.

-- 
Ram Pai
