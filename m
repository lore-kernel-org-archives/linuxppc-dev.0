Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC57C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Mar 2022 12:12:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDnxN5kRWz3bWw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Mar 2022 23:12:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=YPXOwpjR;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDnwh0Rshz2yxW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2022 23:11:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YPXOwpjR; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KDnwg3sqFz4xLV;
 Thu, 10 Mar 2022 23:11:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1646914291;
 bh=GBRd8YJKb3OnktFjwi8q5B6pu5AWUowYszeQTm5tAYw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YPXOwpjRlM4rb5MbPSJhGPsmZOiU8kdmAiyO6dSeZTZginhacKfCH+QdjGUYNHKVr
 abQIIKqrzKH3j69DrFDgoYnUprXzvYWc3UcM+Vl2+MuuNFC1ruKFEYlYAT1CAZvPWH
 n8rAKTHmq7erX4GNIilSh4m5H0OiFOtvKi4K57B/goiVTw1H4VFrZhQk7XgvxJPE4a
 YhIa+kC0GFZYJrDicih7mr5npkBu2IRTrGeOJC37j1cEh7eAsos6pnsSOK83nj9K2A
 eFfkj3z1paD3oOBWKIxspmOOaVtTehVxe0ieWVEroYXo7kEkRmL1GJWrsKhTW8QBG9
 J82+Q0Eg8JYRg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Kajol Jain
 <kjain@linux.ibm.com>
Subject: Re: [PATCH 16/20] selftest/powerpc/pmu/: Add selftest for mmcr1
 pmcxsel/unit/cache fields
In-Reply-To: <4c7785cf-3b92-c273-35ea-fc95131fac46@csgroup.eu>
References: <20220127072012.662451-1-kjain@linux.ibm.com>
 <20220127072012.662451-17-kjain@linux.ibm.com>
 <4c7785cf-3b92-c273-35ea-fc95131fac46@csgroup.eu>
Date: Thu, 10 Mar 2022 23:11:30 +1100
Message-ID: <87czium2h9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "atrajeev@linux.vnet.ibm.com" <atrajeev@linux.vnet.ibm.com>,
 "maddy@linux.vnet.ibm.com" <maddy@linux.vnet.ibm.com>,
 "rnsastry@linux.ibm.com" <rnsastry@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 27/01/2022 =C3=A0 08:20, Kajol Jain a =C3=A9crit=C2=A0:
>> From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>=20
>> The testcase uses event code "0x1340000001c040" to verify
>> the settings for different fields in Monitor Mode Control
>> Register 1 (MMCR1). The fields include PMCxSEL, PMCXCOMB
>> PMCxUNIT, cache. Checks if these fields are translated
>> correctly via perf interface to MMCR1
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>
> I see the series has been accepted but this patch has been left over.
>
> Any reason ?

Yeah it's flakey. It counts cache loads but the workload it runs doesn't
necessarily cause any, so it sometimes fails. I've reported that
privately to Kajol.

cheers
