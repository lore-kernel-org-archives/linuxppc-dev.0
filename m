Return-Path: <acme@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E90811A05FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 05:45:41 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by ozlabs.org (Postfix) with ESMTP id 90EBA1402B6
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 05:45:41 +1000 (AEST)
Date: Wed, 30 Sep 2015 16:45:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, eranian@google.com,
 naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] perf: Fix build break on powerpc due to
 sample_reg_masks
Message-ID: <20150930194535.GK1944@kernel.org>
References: <20150930182836.GA27858@us.ibm.com>
 <20150930190909.GA27570@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150930190909.GA27570@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 30, 2015 at 09:09:09PM +0200, Jiri Olsa escreveu:
> On Wed, Sep 30, 2015 at 11:28:36AM -0700, Sukadev Bhattiprolu wrote:
> > From e29aeeee7236122c4d807ec9ebc721b5d7d75c8d Mon Sep 17 00:00:00 2001
> > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > Date: Thu, 24 Sep 2015 17:53:49 -0400
> > Subject: [PATCH v2] perf: Fix build break on powerpc due to sample_reg_masks
> > 
> > perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
> > So the weak definition for 'sample_regs_masks' doesn't get picked up.
> > 
> > Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
> > error for 'perf_reg_value()' function (due to the static inline version
> > in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
> > function.
> > 
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
