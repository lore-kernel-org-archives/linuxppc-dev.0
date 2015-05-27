Return-Path: <namhyung@gmail.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 903C61A0DED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 00:59:27 +1000 (AEST)
Received: by oifu123 with SMTP id u123so9464409oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 07:59:25 -0700 (PDT)
MIME-Version: 1.0
Sender: namhyung@gmail.com
In-Reply-To: <20150527144007.GL7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
 <20150527144007.GL7484@tassilo.jf.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 May 2015 23:59:04 +0900
Message-ID: <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
To: Andi Kleen <ak@linux.intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andi,

On Wed, May 27, 2015 at 11:40 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> So we build tables of all models in the architecture, and choose
>> matching one when compiling perf, right?  Can't we do that when
>> building the tables?  IOW, why don't we check the VFM and discard
>> non-matching tables?  Those non-matching tables are also needed?
>
> We build it for all cpus in an architecture, not all architectures.
> So e.g. for an x86 binary power is not included, and vice versa.

OK.

> It always includes all CPUs for a given architecture, so it's possible
> to use the perf binary on other systems than just the one it was
> build on.

So it selects one at run-time not build-time, good.  But I worry about
the size of the intel tables.  How large are they?  Maybe we can make
it dynamic-loadable if needed..

Thanks,
Namhyung
