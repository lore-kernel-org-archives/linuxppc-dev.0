Return-Path: <mpe@ellerman.id.au>
Message-ID: <1389591507.29912.6.camel@concordia>
Subject: Re: [PATCH] pseries/cpuidle: Remove redundant call to
 ppc64_runlatch_off() in cpu idle routines
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 13 Jan 2014 16:38:27 +1100
In-Reply-To: <20140109050519.11532.6044.stgit@preeti.in.ibm.com>
References: <20140109050519.11532.6044.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, deepthi@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-09 at 10:35 +0530, Preeti U Murthy wrote:
> Commit fbd7740fdfdf9475f switched pseries cpu idle handling from complete idle
> loops to ppc_md.powersave functions. Earlier to this switch,
> ppc64_runlatch_off() had to be called in each of the idle routines. But after
> the switch this call is handled in arch_cpu_idle(),just before the call
> to ppc_md.powersave, where platform specific idle routines are called.
> 
> As a consequence, the call to ppc64_runlatch_off() got duplicated in the
> arch_cpu_idle() routine as well as in the some of the idle routines in
> pseries and commit fbd7740fdfdf9475f missed to get rid of these redundant
> calls. These calls were carried over subsequent enhancements to the pseries
> cpuidle routines. This patch takes care of eliminating this redundancy.

It's "obvious" that turning the runlatch off multiple times is harmless,
although it adds extra overhead, but please spell that out in the changelog.

cheers
