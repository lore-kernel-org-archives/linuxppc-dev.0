Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A5562C007B
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Jun 2013 19:59:30 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 15:24:47 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 72F721258051
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Jun 2013 15:28:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q9xLQ428246224
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Jun 2013 15:29:21 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q9xNqH011536
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Jun 2013 19:59:24 +1000
Message-ID: <51CABB56.9010105@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 15:28:46 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] powerpc/perf: Add power8 EBB support
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -117,6 +117,7 @@
>  	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
>  	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
>  	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
> +	 (1ull		       << EVENT_CONFIG_EBB_SHIFT)	|	\

We should define this macro like EVENT_MARKED_MASK

#define EVENT_EBB_MASK       0x1

Numeric value of "1ull" stands out odd in the scheme.


>  	  EVENT_PSEL_MASK)
> 
> + *              EBB -*    |                     |
> + *                        |                     |      Count of events for each PMC.
> + *      L1 I/D qualifier -*                     |        p1, p2, p3, p4, p5, p6.
>   *                     nc - number of counters -*
>   *
>   * The PMC fields P1..P6, and NC, are adder fields. As we accumulate constraints
> @@ -159,6 +160,9 @@
>  #define CNST_THRESH_VAL(v)	(((v) & EVENT_THRESH_MASK) << 32)
>  #define CNST_THRESH_MASK	CNST_THRESH_VAL(EVENT_THRESH_MASK)
> 
> +#define CNST_EBB_VAL(v)		(((v) & 1) << 24)

EVENT_EBB_MASK can be used here as well.
