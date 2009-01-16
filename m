Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D570EDE1CC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 22:51:45 +1100 (EST)
Date: Fri, 16 Jan 2009 14:51:42 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <498243073.20090116145142@emcraft.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re[2]: [PATCH 03/11][v3] async_tx: add support for asynchronous RAID6
	recovery operations
In-Reply-To: <e9c3a7c20901141706v17215220s22d973f81369be72@mail.gmail.com>
References: <200901130343.14016.yur@emcraft.com>
	<e9c3a7c20901141706v17215220s22d973f81369be72@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AOn Thursday, January 15, 2009 Dan Williams wrote:

> On Mon, Jan 12, 2009 at 5:43 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>> +       /* (2) Calculate Q+Qxy */
>> +       lptrs[0] =3D ptrs[failb];
>> +       lptrs[1] =3D ptrs[disks-1];
>> +       lptrs[2] =3D NULL;
>> +       tx =3D async_pq(lptrs, NULL, 0, 1, bytes, ASYNC_TX_DEP_ACK,
>> +                     tx, NULL, NULL);
>> +
>> +       /* (3) Calculate P+Pxy */
>> +       lptrs[0] =3D ptrs[faila];
>> +       lptrs[1] =3D ptrs[disks-2];
>> +       lptrs[2] =3D NULL;
>> +       tx =3D async_pq(lptrs, NULL, 0, 1, bytes, ASYNC_TX_DEP_ACK,
>> +                     tx, NULL, NULL);
>> +

> These two calls convinced me that ASYNC_TX_PQ_ZERO_{P,Q} need to go.
> A 1-source async_pq operation does not make sense.

 Another source is hidden under not-set ASYNC_TX_PQ_ZERO_{P,Q} :)=20
Though, I agree, this looks rather misleading.

>   These should be:

>        /* (2) Calculate Q+Qxy */
>        lptrs[0] =3D ptrs[disks-1];
>        lptrs[1] =3D ptrs[failb];
>        tx =3D async_xor(lptrs[0], lptrs, 0, 2, bytes,
>                       ASYNC_TX_XOR_DROP_DST|ASYNC_TX_DEP_ACK, tx, NULL, N=
ULL);

>         /* (3) Calculate P+Pxy */
>        lptrs[0] =3D ptrs[disks-2];
>        lptrs[1] =3D ptrs[faila];
>        tx =3D async_xor(lptrs[0], lptrs, 0, 2, bytes,
>                       ASYNC_TX_XOR_DROP_DST|ASYNC_TX_DEP_ACK, tx, NULL, N=
ULL);


 The reason why I preferred to use async_pq() instead of async_xor()=20
here is to maximize the chance that the whole D+D recovery operation=20
will be handled in one ADMA device, i.e. without channels switch and=20
the latency introduced because of that.

 So, if we'll decide to stay with ASYNC_TX_PQ_ZERO_{P,Q}, then this=20
should be probably kept unchanged, but if we'll get rid of=20
ASYNC_TX_PQ_ZERO_{P,Q}, then, obviously, we'll have to use=20
async_xor()s here as you suggest.


 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
