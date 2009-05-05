Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B884DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 21:19:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.14.3/8.13.8) with ESMTP id n45BJ8wZ241634
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 11:19:08 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n45BJ7g43694608
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 13:19:07 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n45BJ6C2023620
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 13:19:06 +0200
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2.6.30-rc5] ehea: fix invalid pointer access
Date: Tue, 5 May 2009 13:19:05 +0200
References: <200905041802.30527.hannes.hering@linux.vnet.ibm.com>
	<25628.1241514687@redhat.com>
In-Reply-To: <25628.1241514687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905051319.05806.hannes.hering@linux.vnet.ibm.com>
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

On Tuesday 05 May 2009 11:11:27 David Howells wrote:
> Hannes Hering <hannes.hering@linux.vnet.ibm.com> wrote:
> 
> >  	pref = skb_array[x];
> > -	prefetchw(pref);
> > -	prefetchw(pref + EHEA_CACHE_LINE);
> > +	if (pref) {
> > +		prefetchw(pref);
> > +		prefetchw(pref + EHEA_CACHE_LINE);
> 
> Ummm...  Is prefetch() or prefetchw() faulting?
> 
> David
Hi David,

this is an ehea driver problem, which is occuring when the receive queue runs
empty. The faulting code is more specifically the following line:

	pref = (skb_array[x]->data);

Here the access to the struct element data would cause an exception.We could
have made the if block a little smaller.

Regards

Hannes
