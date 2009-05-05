Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B48EBDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 23:45:15 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate4.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n45Dj74t166086
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 13:45:07 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n45Dj7iZ725112
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 14:45:07 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n45Dj67p007815
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 14:45:07 +0100
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2.6.30-rc5] ehea: fix invalid pointer access
Date: Tue, 5 May 2009 15:45:05 +0200
References: <200905051319.05806.hannes.hering@linux.vnet.ibm.com>
	<25628.1241514687@redhat.com> <26110.1241525994@redhat.com>
In-Reply-To: <26110.1241525994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905051545.05877.hannes.hering@linux.vnet.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, ossthema@de.ibm.com, osstklei@de.ibm.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 May 2009 14:19:54 David Howells wrote:
> In that case, you might want to move the prefetchw() calls in the following:
> 
> 		pref = skb_array[x];
> 	-	prefetchw(pref);
> 	-	prefetchw(pref + EHEA_CACHE_LINE);
> 	+	if (pref) {
> 	+		prefetchw(pref);
> 	+		prefetchw(pref + EHEA_CACHE_LINE);
> 
> to before the if-statement.  That way the CPU can be attempting the prefetch
> whilst it's chewing over the test and branch.  prefetching shouldn't fault on
> a bad address.
> 
> David
Hi David,

you are right so far, but actually the prefetch calls on POWER also contain
an if statement to check if the address is valid (i. e. non-zero). We never
have the case that the pref != NULL and pref->data == NULL. And the situation
of pref==NULL is very rare. This means there is no benefit moving our if
statement down from performance perspective if we assume that our if does not
take longer then the if in the prefetch command. We can add an
if(likely(pref) if you like. In fact doing the if statement as we do it now
we actually save the prefetch if statements in case we hit the situation of
pref==NULL.

Regards

Hannes
