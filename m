Return-Path: <acme@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFFDA1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 00:19:16 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by ozlabs.org (Postfix) with ESMTP id 84279140DA2
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 00:19:16 +1100 (AEDT)
Date: Wed, 7 Oct 2015 10:19:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH v2] perf: Fix build break on powerpc due to
 sample_reg_masks
Message-ID: <20151007131911.GD14409@kernel.org>
References: <20150930182836.GA27858@us.ibm.com>
 <20150930190909.GA27570@krava.redhat.com>
 <20150930194535.GK1944@kernel.org>
 <1444178798.6794.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444178798.6794.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Oct 07, 2015 at 11:46:38AM +1100, Michael Ellerman escreveu:
> On Wed, 2015-09-30 at 16:45 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 30, 2015 at 09:09:09PM +0200, Jiri Olsa escreveu:
> > > On Wed, Sep 30, 2015 at 11:28:36AM -0700, Sukadev Bhattiprolu wrote:
> > > > From e29aeeee7236122c4d807ec9ebc721b5d7d75c8d Mon Sep 17 00:00:00 2001
> > > > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > > Date: Thu, 24 Sep 2015 17:53:49 -0400
> > > > Subject: [PATCH v2] perf: Fix build break on powerpc due to sample_reg_masks
> > > > 
> > > > perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
> > > > So the weak definition for 'sample_regs_masks' doesn't get picked up.
> > > > 
> > > > Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
> > > > error for 'perf_reg_value()' function (due to the static inline version
> > > > in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
> > > > function.
> > > > 
> > > > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > 
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Thanks, applied.
> 
> Is this going to Linus' tree any time soon?
> 
> I have folks pinging me to say that perf is broken on powerpc.

Checking this now.

- Arnaldo
