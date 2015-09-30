Return-Path: <jolsa@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF63D1A0730
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 05:09:15 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5AB01402B6
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 05:09:14 +1000 (AEST)
Date: Wed, 30 Sep 2015 21:09:09 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com,
 naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] perf: Fix build break on powerpc due to
 sample_reg_masks
Message-ID: <20150930190909.GA27570@krava.redhat.com>
References: <20150930182836.GA27858@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150930182836.GA27858@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 30, 2015 at 11:28:36AM -0700, Sukadev Bhattiprolu wrote:
> From e29aeeee7236122c4d807ec9ebc721b5d7d75c8d Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Thu, 24 Sep 2015 17:53:49 -0400
> Subject: [PATCH v2] perf: Fix build break on powerpc due to sample_reg_masks
> 
> perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
> So the weak definition for 'sample_regs_masks' doesn't get picked up.
> 
> Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
> error for 'perf_reg_value()' function (due to the static inline version
> in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
> function.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
