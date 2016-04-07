Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgb9B5psLzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 18:19:26 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id q6so6320473pav.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Apr 2016 01:19:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] perf probe fixes for ppc64le
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: Mark Wielaard <mjw@redhat.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57061802.7020508@gmail.com>
Date: Thu, 7 Apr 2016 18:19:14 +1000
MIME-Version: 1.0
In-Reply-To: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06/04/16 22:32, Naveen N. Rao wrote:
> This patchset fixes three issues found with perf probe on ppc64le:
> 1. 'perf test kallsyms' failure on ppc64le (reported by Michael
> Ellerman). This was due to the symbols being fixed up during symbol
> table load. This is fixed in patch 2 by delaying symbol fixup until
> later.
> 2. perf probe function offset was being calculated from the local entry
> point (LEP), which does not match user expectation when trying to look
> at function disassembly output (reported by Ananth N). This is fixed for
> kallsyms in patch 1 and for symbol table in patch 2.

I think the bit where the offset is w.r.t LEP when using a name, but w.r.t
GEP when using function+offset can be confusing. Do we really need probe
points between GEP and LEP? All the GEP does is setup r2. The use case
could be more generic, but please clarify.

> 3. perf probe failure with kretprobe when using kallsyms. This was
> failing as we were specifying an offset. This is fixed in patch 1.
> 

Balbir Singh.
