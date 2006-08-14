Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 857E067BED
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:59:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7EGxow8003292
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 12:59:50 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7EGxo5Z289800
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 12:59:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7EGxork018899
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 12:59:50 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/6] ehea: interface to network stack
Date: Mon, 14 Aug 2006 18:59:47 +0200
References: <44D99EFC.3000105@de.ibm.com> <20060814143842.GM479@krispykreme>
	<44E09A19.9050205@de.ibm.com>
In-Reply-To: <44E09A19.9050205@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608141859.48868.arnd.bergmann@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, Anton Blanchard <anton@samba.org>,
	=?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 August 2006 17:43, Jan-Bernd Themann wrote:
> as our queue size is always a power of 2, we simply use:
> i++;
> i &= (ringbufferlength - 1)
> 
> So we can get along without the if.
> 

The recommended (by Linus) way for dealing with ring buffers
like that is to always read the counter through an accessor
and don't care about the overflow when updating it.

You can write small access functions for that:

struct my_struct {
	...
	unsigned rbuf_index;
	unsigned rbuf_mask;
	...
};

static inline unsigned int my_index(struct my_struct *p)
{
	return p->rb_index & p->rb_mask;
}

static inline unsigned int my_index_next(struct my_struct *p)
{
	return (++p->rb_index) & p->rb_mask;
}

	Arnd <><
