Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 8A48B2C009B
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 00:59:37 +1100 (EST)
Date: Mon, 21 Jan 2013 14:59:06 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: Fix compile warnings in tests/attr.c
Message-ID: <20130121135906.GD1995@krava.brq.redhat.com>
References: <20130119013052.GA24693@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130119013052.GA24693@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 paulus@samba.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 18, 2013 at 05:30:52PM -0800, Sukadev Bhattiprolu wrote:
> From 4d266e5040c33103f5d226b0d16b89f8ef79e3ad Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Fri, 18 Jan 2013 11:14:28 -0800
> Subject: [PATCH] perf: Fix compile warnings in tests/attr.c
> 
> Replace '%llu' in printf()s with 'PRIu64' in 'tools/perf/tests/attr.c'
> to fix compile warnings (which become errors due to -Werror).

i386 and x86_64 compiles fine for me with gcc versions 4.6.3-2 and 4.7.2-2

with your patch for x86_64 I'm getting following warnings/errors:

    CC tests/attr.o
tests/attr.c: In function ‘store_event’:
tests/attr.c:69:4: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘__u64’ [-Werror=format]
tests/attr.c:69:4: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘__u64’ [-Werror=format]
tests/attr.c:78:7: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:94:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:94:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:95:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:95:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:96:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:96:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:97:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:97:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:122:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:122:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:123:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:123:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:124:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:124:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:125:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
tests/attr.c:125:2: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘__u64’ [-Werror=format]
cc1: all warnings being treated as errors
make: *** [tests/attr.o] Error 1

i386 compiles fine

jirka
