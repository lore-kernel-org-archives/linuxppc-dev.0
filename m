Return-Path: <dhowells@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 40082DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 19:46:24 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200905041802.30527.hannes.hering@linux.vnet.ibm.com>
References: <200905041802.30527.hannes.hering@linux.vnet.ibm.com>
To: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.30-rc5] ehea: fix invalid pointer access
Date: Tue, 05 May 2009 10:11:27 +0100
Message-ID: <25628.1241514687@redhat.com>
Sender: dhowells@redhat.com
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

Hannes Hering <hannes.hering@linux.vnet.ibm.com> wrote:

>  	pref = skb_array[x];
> -	prefetchw(pref);
> -	prefetchw(pref + EHEA_CACHE_LINE);
> +	if (pref) {
> +		prefetchw(pref);
> +		prefetchw(pref + EHEA_CACHE_LINE);

Ummm...  Is prefetch() or prefetchw() faulting?

David
