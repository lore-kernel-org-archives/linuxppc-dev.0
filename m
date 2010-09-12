Return-Path: <ibr@radix50.net>
Received: from almaty.kz-easy.com (kz-easy.com [85.214.25.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DA901007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 07:14:03 +1000 (EST)
Received: from alatau.radix50.net (dslb-092-074-053-195.pools.arcor-ip.net
	[92.74.53.195]) (authenticated bits=0)
	by almaty.kz-easy.com (8.13.8/8.13.8/Debian-3) with ESMTP id
	o8CL8XRD027485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Sep 2010 23:08:35 +0200
Received: from medeu.radix50.net (root@medeu [192.168.0.3])
	by alatau.radix50.net (8.14.3/8.14.3/Debian-5) with ESMTP id
	o8CL8SpG002711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Sep 2010 23:08:28 +0200
Received: from medeu.radix50.net (ibr@localhost [127.0.0.1])
	by medeu.radix50.net (8.14.3/8.14.3/Debian-5) with ESMTP id
	o8CL8R1t013710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Sep 2010 23:08:27 +0200
Received: (from ibr@localhost)
	by medeu.radix50.net (8.14.3/8.14.3/Submit) id o8CL8RtE013709
	for linuxppc-dev@lists.ozlabs.org; Sun, 12 Sep 2010 23:08:27 +0200
Date: Sun, 12 Sep 2010 23:08:27 +0200
From: Baurzhan Ismagulov <ibr@radix50.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: how to understand powerpc's BRx ORx
Message-ID: <20100912210827.GB6825@radix50.net>
References: <201009101356067140460@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201009101356067140460@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 10, 2010 at 01:56:08PM +0800, hacklu wrote:
>  I didn't understand the address mask.
> it's said that: BR[BA] is the base address,the OR[AM] is the  address mask,
...
> for instance, if my BR0[BA]=0111_0000_0000_0000_0, OR0[AM]=1111_1111_1111
> if I want to access the 0x70000000 or the 0x71000001.what address calculate will be taken?

Assuming that BR0 is set to valid, the right chip select machine is
selected, etc., my understanding of MPC885RM is:

* 0x70000000 & OR0[AM] = 0x70000000
  0x70000000 == BR0[BA]
  => CS0 active, 0x0000 on the address bus (haven't checked the actual
  bus width).

* 0x71000001 & OR0[AM] = 0x71000000
  0x71000000 != BR0[BA]
  => CS0 inactive, will check the following BR/ORs

With kind regards,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
