Return-Path: <vince@deater.net>
Received: from fbr03.mfg.siteprotect.com (fbr03.mfg.siteprotect.com
 [64.26.60.138]) by ozlabs.org (Postfix) with ESMTP id 899A82C00F9
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 12:39:11 +1000 (EST)
Received: from smtpauth05.mfg.siteprotect.com (unknown [192.168.33.144])
 by fbr03.mfg.siteprotect.com (Postfix) with ESMTP id B81D0880614
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 21:33:56 -0500 (CDT)
Date: Sat, 10 Aug 2013 22:34:58 -0400 (EDT)
From: Vince Weaver <vince@deater.net>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] powerpc/perf: Define big-endian version of
 perf_mem_data_src
In-Reply-To: <20130810175153.GF15551@us.ibm.com>
Message-ID: <alpine.DEB.2.02.1308102232120.4119@pianoman.cluster.toy>
References: <20130810174831.GA15551@us.ibm.com>
 <20130810175153.GF15551@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 10 Aug 2013, Sukadev Bhattiprolu wrote:

> 
>  include/uapi/linux/perf_event.h |   55 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 55 insertions(+), 0 deletions(-)

> +#define __PERF_LE	1234
> +#define __PERF_BE	4321
> +
> +#if defined(__KERNEL__)

I could be wrong, but I thought files under uapi weren't supposed to 
contain __KERNEL__ code.  Wasn't that the whole point of uapi?

Also having the perf_event interface depend on endianess just seems like a 
complicated mess.  Can't we just declare the interface to be a certain 
endianess and have the kernel byte-swap as necessary?

Vince
