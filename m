Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id AB10E67B62
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 00:40:40 +1000 (EST)
Date: Fri, 18 Aug 2006 16:40:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Message-ID: <20060818144034.GD6393@wohnheim.fh-wedel.de>
References: <200608181331.19501.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200608181331.19501.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, 18 August 2006 13:31:19 +0200, Jan-Bernd Themann wrote:
>
> +	if (queue->current_q_offset > queue->queue_length) {
> +		queue->current_q_offset -= queue->pagesize;
> +		retvalue = NULL;
> +	}
> +	else if ((((u64) retvalue) & (EHEA_PAGESIZE-1)) != 0) {

	} else if (((u64) retvalue) & (EHEA_PAGESIZE-1)) {

> +		if (hret < H_SUCCESS) {

Do you have a reason to keep H_SUCCESS?

> +   	if(qp_attr->rq_count > 1)
> +		hw_queue_dtor(&qp->hw_rqueue2);
> +   	if(qp_attr->rq_count > 2)

Small amount of whitespace damage.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface.
-- Doug MacIlroy
