Return-Path: <mpe@ellerman.id.au>
Message-ID: <1393386338.29388.5.camel@concordia>
Subject: Re: [PATCH] powerpc: warn users of smt-snooze-delay that the API
 isn't there anymore
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 26 Feb 2014 14:45:38 +1100
In-Reply-To: <1393368002.6314.10.camel@pasglop>
References: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
 <530C4D57.1030905@linux.vnet.ibm.com> <1393368002.6314.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-02-26 at 09:40 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2014-02-25 at 13:29 +0530, Deepthi Dharwar wrote:
> > We currently do not use smt-snooze-delay in the kernel.
> > The sysfs entries needs to  be retained until we do a clean up
> > ppc64_cpu
> > util that uses these entries to determine SMT,
> > clean up patch for this has already been posted out by Prerna.
> > Once, we have the ppc64_cpu changes in, we can look to clean up these
> > parts from the kernel.
> 
> We generally shouldn't change user visible interfaces.
> 
> People still have old versions of ppc64_cpu, we must not break them

Yeah we can't remove the file entirely, at least for a few more years.

ppc64_cpu should never have used that file to determine if a cpu existed, but
it did, so we're stuck with it.

What we can do is remove the unused percpu, and just leave the file in sysfs,
and have it print a warning when anyone touches it.

cheers
