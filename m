Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA3472C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:25:46 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 13:55:36 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6N8PWls21299328
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 13:55:32 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6N8PViO016478
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:25:31 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 10/11] arch/powerpc: Use 32bit array for slb cache
In-Reply-To: <20120723002738.GK17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723002738.GK17790@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 13:55:31 +0530
Message-ID: <87zk6qhojo.fsf@skywalker.in.ibm.com>
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

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 09, 2012 at 06:43:40PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> With larger vsid we need to track more bits of ESID in slb cache
>> for slb invalidate.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Minor comment below, but apart from that...
>
> Reviewed-by: Paul Mackerras <paulus@samba.org>
>
>> -	sldi	r11,r3,1		/* r11 = offset * sizeof(u16) */
>> -	rldicl	r10,r10,36,28		/* get low 16 bits of the ESID */
>> -	add	r11,r11,r13		/* r11 = (u16 *)paca + offset */
>> -	sth	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
>> +	sldi	r11,r3,2		/* r11 = offset * sizeof(u32) */
>> +	rldicl	r10,r10,36,28		/* get the 36 bits of the ESID */
>
> You're correct that the rldicl instruction produces 36 bits of result,
> and in fact it is equivalent to srdi r10,r10,28.  If you're changing
> the line you might as well change the instruction to the simpler form
> too.

done.

-aneesh
