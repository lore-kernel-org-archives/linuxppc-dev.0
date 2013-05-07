Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, eranian@google.com
MIME-Version: 1.0
Subject: Invalid perf_branch_entry.to entries question
Date: Tue, 07 May 2013 11:35:28 +1000
Message-ID: <25394.1367890528@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter & Stephane,

We are plumbing the POWER8 Branch History Rolling Buffer (BHRB) into
struct perf_branch_entry.

Sometimes on POWER8 we may not be able to fill out the "to" address.  We
initially thought of just making this 0, but it's feasible that this
could be a valid address to branch to. 

The other logical value to indicate an invalid entry would be all 1s
which is not possible (on POWER at least).

Do you guys have a preference as to what we should use as an invalid
entry?  This would have some consequences for the userspace tool also.

The alternative would be to add a flag alongside mispred/predicted to
indicate the validity of the "to" address.

Mikey
