Return-Path: <adobriyan@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 285D167B6A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 23:47:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so886606ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 06:47:40 -0700 (PDT)
Date: Fri, 18 Aug 2006 17:47:28 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Message-ID: <20060818134728.GB5201@martell.zuzino.mipt.ru>
References: <200608181329.02042.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608181329.02042.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 01:29:01PM +0200, Jan-Bernd Themann wrote:

Was there noticeable performance difference when explicit prefetching is
removed? At some (invisible) point CPUs will become smarter about prefetching
than programmers and this code will be slower than possible.

> +static inline struct sk_buff *get_skb_by_index(struct sk_buff **skb_array,
> +					       int arr_len,
> +					       struct ehea_cqe *cqe)
> +{
> +	struct sk_buff *skb;
> +	void *pref;
> +	int x;
> +	int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX, cqe->wr_id);
> +
> +	x = skb_index + 1;
> +	x &= (arr_len - 1);
> +
> +	pref = (void*)skb_array[x];
> +	prefetchw(pref);
> +	prefetchw(pref + EHEA_CACHE_LINE);
> +
> +	pref = (void*)(skb_array[x]->data);
> +	prefetch(pref);
> +	prefetch(pref + EHEA_CACHE_LINE);
> +	prefetch(pref + EHEA_CACHE_LINE * 2);
> +	prefetch(pref + EHEA_CACHE_LINE * 3);
> +	skb = skb_array[skb_index];
> +	skb_array[skb_index] = NULL;
> +	return skb;
> +}
> +
> +static inline struct sk_buff *get_skb_by_index_ll(struct sk_buff **skb_array,
> +						  int arr_len, int wqe_index)
> +{
> +	struct sk_buff *skb;
> +	void *pref;
> +	int x;
> +
> +	x = wqe_index + 1;
> +	x &= (arr_len - 1);
> +
> +	pref = (void*)skb_array[x];
> +	prefetchw(pref);
> +	prefetchw(pref + EHEA_CACHE_LINE);
> +
> +	pref = (void*)(skb_array[x]->data);
> +	prefetchw(pref);
> +	prefetchw(pref + EHEA_CACHE_LINE);
> +
> +	skb = skb_array[wqe_index];
> +	skb_array[wqe_index] = NULL;
> +	return skb;
> +}
