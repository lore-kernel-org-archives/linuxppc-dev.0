Return-Path: <ananth@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6EEBBB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 14:36:12 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 7 Jun 2012 22:36:10 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9648EC90058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 00:36:06 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q584a6Xw190346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 00:36:07 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q584a57d020914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2012 22:36:06 -0600
Date: Fri, 8 Jun 2012 10:06:05 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
Message-ID: <20120608043605.GB13409@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606092150.GC6745@in.ibm.com> <1338974822.2749.89.camel@twins>
 <20120606093541.GA29580@in.ibm.com> <1339006084.3458.25.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339006084.3458.25.camel@localhost>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2012 at 11:08:04AM -0700, Jim Keniston wrote:
> On Wed, 2012-06-06 at 15:05 +0530, Ananth N Mavinakayanahalli wrote:
> > On Wed, Jun 06, 2012 at 11:27:02AM +0200, Peter Zijlstra wrote:
> > > On Wed, 2012-06-06 at 14:51 +0530, Ananth N Mavinakayanahalli wrote:

...

> > For the kernel, the only ones that are off limits are rfi (return from
> > interrupt), mtmsr (move to msr). All other instructions can be probed.
> > 
> > Both those instructions are supervisor level, so we won't see them in
> > userspace at all; so we should be able to probe all user level
> > instructions.
> 
> Presumably rfi or mtmsr could show up in the instruction stream via an
> erroneous or mischievous asm statement.  It'd be good to verify that you
> handle that gracefully.

That'd be flagged elsewhere, by the architecture itself -- you'd get a
privileged instruciton exception if you try execute any instruction not
part of the UISA. I therefore don't think its a necessary check in the
uprobes code.

Ananth
