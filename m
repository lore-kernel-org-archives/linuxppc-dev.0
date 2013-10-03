Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 748A92C00CE
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Oct 2013 01:27:49 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 3 Oct 2013 11:27:46 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D5EC86E803C
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 11:27:43 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r93FRiWA9044458
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 15:27:44 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r93FRf1b024202
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 12:27:44 -0300
Date: Thu, 3 Oct 2013 08:27:25 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 6/9][v5] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20131003152725.GA1383@us.ibm.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003053944.GD17237@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003053944.GD17237@concordia>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| On Tue, Oct 01, 2013 at 05:15:07PM -0700, Sukadev Bhattiprolu wrote:
| > perf_mem_data_src is an union that is initialized via the ->val field
| > and accessed via the bitmap fields. For this to work on big endian
| > platforms, we also need a big-endian represenation of perf_mem_data_src.
| > 
| > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
| > index ca1d90b..846f399 100644
| > --- a/include/uapi/linux/perf_event.h
| > +++ b/include/uapi/linux/perf_event.h
| > @@ -19,6 +19,50 @@
| >  #include <asm/byteorder.h>
| >  
| >  /*
| > + * Kernel and userspace check for endianness in incompatible ways.
| > + * In user space, <endian.h> defines both __BIG_ENDIAN and __LITTLE_ENDIAN
| > + * but sets __BYTE_ORDER to one or the other. So user space uses checks are:
| 
| 
| Why can't you use __BIG_ENDIAN_BITFIELD ?

BTW, any clues on why there are so many different ways of checking endianness ?

Any standards related stuff or just evolution ?

Sukadev
