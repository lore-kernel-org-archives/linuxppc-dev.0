Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mH14sDSzF1WK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:28:29 +1100 (AEDT)
Date: Wed, 21 Mar 2018 21:28:26 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM & powerpc: Work around POWER9 TM hardware bugs
Message-ID: <20180321102826.GA13509@fergus.ozlabs.ibm.com>
References: <1521627901-13547-1-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521627901-13547-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2018 at 09:24:56PM +1100, Paul Mackerras wrote:
> This patch series applies on top of my patch series "powerpc: Free up
> CPU feature bits".
> 
> POWER9 has some shortcomings in its implementation of transactional
> memory.  Starting with v2.2 of the "Nimbus" chip, some changes have
> been made to the hardware which make it able to generate hypervisor
> interrupts in the situations where hardware needs the hypervisor to
> provide some assistance with the implementation.  Specifically, the
> core does not have enough storage to store a complete checkpoint of
> all the architected state for all 4 threads, and therefore needs to
> be able to offload the checkpointed state of threads which are in
> transactional suspended state (for threads that are in transactional
> state, the hardware can simply abort the transaction).
> 
> This series implements the hypervisor assistance for TM for KVM
> guests, thus allowing them to use TM.  This then means that we can
> allow live migration of guests on POWER8 that may be using TM to
> POWER9 hosts.
> 
> This version adds a feature bit for the XER[SO] bug workaround so that
> it can be turned off on future systems which may still require
> hypervisor assistance for TM but have the XER[SO] bug fixed.  It also
> makes the test in the idle code (which includes a sync instruction)
> conditional on the XER[SO] bug feature bit, meaning that the code to
> force SMT4 mode will only work when that feature bit is set.

Please ignore this series.  I applied a bug fix to the wrong commit.

Paul.
