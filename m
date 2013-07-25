Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E3BEE2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 15:17:07 +1000 (EST)
Message-ID: <1374729381.6142.59.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jul 2013 15:16:21 +1000
In-Reply-To: <20130725031501.GA15673@concordia>
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com> <51ECD664.7040708@linux.vnet.ibm.com>
 <20130723134431.GF31944@concordia> <51EF1F97.3070409@asianux.com>
 <20130724011640.GA6042@concordia> <51EF375D.9060006@asianux.com>
 <20130725031501.GA15673@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: chenhui.zhao@freescale.com, Chen Gang <gang.chen@asianux.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-25 at 13:15 +1000, Michael Ellerman wrote:
> > But for API (also include the internal API), at least, better to always
> > provide the return value which can indicate failure by negative number
> > (if succeed can return the meanness value, e.g. the number of cpus).
> 
> Are we still talking about this?
> 
> There is no point returning a value when no one checks it. Which is the
> case here.

Right. The return value is historical, it dates from when we didn't have
cpu_possible_mask etc...

Nowadays, the probe() routine is just some early init, and might also
affect those masks if needed, the return value has become obsolete.

You are welcome to post a patch removing it.

Cheers,
Ben.
