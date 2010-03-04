Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 362CEB7D2E
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 03:34:29 +1100 (EST)
Subject: Re: [PATCH] gianfar: Fix TX ring processing on SMP machines
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100304.004157.18721737.davem@davemloft.net>
Date: Thu, 4 Mar 2010 10:34:15 -0600
Message-Id: <DF5053B4-DCD0-4B90-B9D7-E80D0C76CFAE@kernel.crashing.org>
References: <20100303181858.GA458@oksana.dev.rtsoft.ru>
	<20100304.004157.18721737.davem@davemloft.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>, Martyn Welch <martyn.welch@ge.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 4, 2010, at 2:41 AM, David Miller wrote:

> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: Wed, 3 Mar 2010 21:18:58 +0300
>=20
>> Starting with commit a3bc1f11e9b867a4f49505 ("gianfar: Revive SKB
>> recycling") gianfar driver sooner or later stops transmitting any
>> packets on SMP machines.
>>=20
>> start_xmit() prepares new skb for transmitting, generally it does
>> three things:
>>=20
>> 1. sets up all BDs (marks them ready to send), except the first one.
>> 2. stores skb into tx_queue->tx_skbuff so that clean_tx_ring()
>>   would cleanup it later.
>> 3. sets up the first BD, i.e. marks it ready.
>>=20
>> Here is what clean_tx_ring() does:
>>=20
>> 1. reads skbs from tx_queue->tx_skbuff
>> 2. checks if the *last* BD is ready. If it's still ready [to send]
>>   then it it isn't transmitted, so clean_tx_ring() returns.
>>   Otherwise it actually cleanups BDs. All is OK.
>>=20
>> Now, if there is just one BD, code flow:
>>=20
>> - start_xmit(): stores skb into tx_skbuff. Note that the first BD
>>  (which is also the last one) isn't marked as ready, yet.
>> - clean_tx_ring(): sees that skb is not null, *and* its lstatus
>>  says that it is NOT ready (like if BD was sent), so it cleans
>>  it up (bad!)
>> - start_xmit(): marks BD as ready [to send], but it's too late.
>>=20
>> We can fix this simply by reordering lstatus/tx_skbuff writes.
>>=20
>> Reported-by: Martyn Welch <martyn.welch@ge.com>
>> Bisected-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Tested-by: Martyn Welch <martyn.welch@ge.com>
>=20
> Applied.

Anton,

Once this makes it into Linus's tree can you make sure we get it added =
to -stable.

- k=
