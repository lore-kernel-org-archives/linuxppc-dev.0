Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9FF22C007D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 05:51:02 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 25 Jul 2012 01:20:57 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6OJotDk21823742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 01:20:56 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6OJotwJ004800
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 05:50:55 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
In-Reply-To: <87boj5o70h.fsf@skywalker.in.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723093951.GB29264@bloggs.ozlabs.ibm.com>
 <87txwyhj5e.fsf@skywalker.in.ibm.com>
 <20120723110654.GC29264@bloggs.ozlabs.ibm.com>
 <87eho1o8pv.fsf@skywalker.in.ibm.com> <87boj5o70h.fsf@skywalker.in.ibm.com>
Date: Wed, 25 Jul 2012 01:20:51 +0530
Message-ID: <87pq7laqg4.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

......

>  /* Returns the segment size indicator for a user address */
> @@ -534,11 +544,17 @@ static inline int user_segment_size(unsigned long addr)
>  static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
>  				     int ssize)
>  {
> -	if (ssize == MMU_SEGSIZE_256M)
> -		return vsid_scramble((context << USER_ESID_BITS)
> -				     | (ea >> SID_SHIFT), 256M);
> -	return vsid_scramble((context << USER_ESID_BITS_1T)
> -			     | (ea >> SID_SHIFT_1T), 1T);
> +	unsigned long proto_vsid;
> +	if (ssize == MMU_SEGSIZE_256M) {
> +		proto_vsid = ((context << USER_ESID_BITS) |(ea >> SID_SHIFT));
> +		/* truncate this to 37 bits */
> +		proto_vsid &= (1UL << (CONTEXT_BITS + USER_ESID_BITS)) - 1;
> +		return vsid_scramble(proto_vsid, 256M);
> +	}
> +	proto_vsid = ((context << USER_ESID_BITS_1T) | (ea >> SID_SHIFT_1T));
> +	/* truncate this to 25 bits */
> +	proto_vsid &= (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T)) - 1;
> +	return vsid_scramble( proto_vsid, 1T);
>  }

I guess we can drop this hunk and related asm, because context is
guaranteed to be  <= CONTEXT_BITS (via MAX_CONTEXTS )

-aneesh
