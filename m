Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6024D1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 11:46:39 +1100 (AEDT)
Message-ID: <1444178798.6794.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] perf: Fix build break on powerpc due to
 sample_reg_masks
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>,  linux-kernel@vger.kernel.org,
 eranian@google.com
Date: Wed, 07 Oct 2015 11:46:38 +1100
In-Reply-To: <20150930194535.GK1944@kernel.org>
References: <20150930182836.GA27858@us.ibm.com>
 <20150930190909.GA27570@krava.redhat.com>
 <20150930194535.GK1944@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-30 at 16:45 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 30, 2015 at 09:09:09PM +0200, Jiri Olsa escreveu:
> > On Wed, Sep 30, 2015 at 11:28:36AM -0700, Sukadev Bhattiprolu wrote:
> > > From e29aeeee7236122c4d807ec9ebc721b5d7d75c8d Mon Sep 17 00:00:00 2001
> > > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > Date: Thu, 24 Sep 2015 17:53:49 -0400
> > > Subject: [PATCH v2] perf: Fix build break on powerpc due to sample_reg_masks
> > > 
> > > perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
> > > So the weak definition for 'sample_regs_masks' doesn't get picked up.
> > > 
> > > Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
> > > error for 'perf_reg_value()' function (due to the static inline version
> > > in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
> > > function.
> > > 
> > > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks, applied.

Is this going to Linus' tree any time soon?

I have folks pinging me to say that perf is broken on powerpc.

cheers
