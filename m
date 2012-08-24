Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EDB492C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 17:08:09 +1000 (EST)
Message-ID: <1345792051.29170.25.camel@pasglop>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 24 Aug 2012 17:07:31 +1000
In-Reply-To: <1345770803.13865.10.camel@concordia>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com> <1345696100.3338.21.camel@concordia>
 <20120823055820.GA14603@in.ibm.com> <1345770803.13865.10.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-24 at 11:13 +1000, Michael Ellerman wrote:
> 
> Yeah. A NULL regs here is a kernel bug, so I think it's actually
> preferable to crash than silently return. 

Or best, if you think there's a remote chance that the bug might hit:

	if (WARN(!regs))
		return

Cheers,
Ben.
