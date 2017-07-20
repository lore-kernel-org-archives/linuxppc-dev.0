Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCj2L0HrVzDrD7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:22:18 +1000 (AEST)
Date: Thu, 20 Jul 2017 15:21:59 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: joserz@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, oohall@gmail.com
Subject: Re: KVM guests freeze under upstream kernel
Message-ID: <20170720052159.GB8602@fergus.ozlabs.ibm.com>
References: <20170719194634.GA1222@pacoca>
 <1500507770.3350.41.camel@kernel.crashing.org>
 <20170720030222.GA21034@pacoca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170720030222.GA21034@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 12:02:23AM -0300, joserz@linux.vnet.ibm.com wrote:
> On Thu, Jul 20, 2017 at 09:42:50AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-07-19 at 16:46 -0300, joserz@linux.vnet.ibm.com wrote:
> > > Hello!
> > > 
> > > We're not able to boot any KVM guest using upstream kernel (cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4.13.0-rc1+).
> > > After reaching the SLOF initial counting, the guest simply freezes:
> > 
> > Can you send our .config ?
> 
> Sure,
> 
> Answering Michael as well:
> 
> It's a P9 with RHEL kernel 4.11.0-10.el7a.ppc64le installed. The problem
> was noticed with kernel > 4.13 (I'm currently running 4.13.0-rc1+).
> 
> QEMU is https://github.com/dgibson/qemu (ppc-for-2.10) but I gave the
> default packaged Qemu a try.
> 
> For the guest, I tried both a vanilla Ubuntu 17.04 and the host kernel.
> But they had never a chance to run since the freezing happened in SLOF.
> 
> Note that using the 4.11.0-10.el7a.ppc64le kernel it works fine
> (for any of these Qemu/Guest setup). With 4.13.0-rc1 I have it run after
> reverting that referred commit.

Is the host kernel running in radix mode?

Did you check the host kernel logs for any oops messages?

Paul.
