Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91EB52C00BB
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 03:16:07 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 11 Aug 2013 13:16:04 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6F34CC90026
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 13:15:59 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7BHG0c4199594
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 13:16:01 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7BHG03Q011278
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 13:16:00 -0400
Date: Sun, 11 Aug 2013 10:15:35 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Vince Weaver <vince@deater.net>
Subject: Re: [PATCH 5/7] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20130811171535.GA31780@us.ibm.com>
References: <20130810174831.GA15551@us.ibm.com>
 <20130810175153.GF15551@us.ibm.com>
 <alpine.DEB.2.02.1308102232120.4119@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1308102232120.4119@pianoman.cluster.toy>
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

Vince Weaver [vince@deater.net] wrote:
| On Sat, 10 Aug 2013, Sukadev Bhattiprolu wrote:
| 
| > 
| >  include/uapi/linux/perf_event.h |   55 +++++++++++++++++++++++++++++++++++++++
| >  1 files changed, 55 insertions(+), 0 deletions(-)
| 
| > +#define __PERF_LE	1234
| > +#define __PERF_BE	4321
| > +
| > +#if defined(__KERNEL__)
| 
| I could be wrong, but I thought files under uapi weren't supposed to 
| contain __KERNEL__ code.  Wasn't that the whole point of uapi?
| 
| Also having the perf_event interface depend on endianess just seems like a 
| complicated mess.  Can't we just declare the interface to be a certain 
| endianess and have the kernel byte-swap as necessary?

Except for the __KERNEL__ check, it looked like this approach would keep
the kernel and user code same. Would it complicate user space ?

I tried to avoid the __KERNEL__ check hack, but like I tried to explain
in the patch, user space and kernel do the endian check differently. 
And, there are about ~300 sites in the kernel with __*ENDIAN checks

Sukadev
