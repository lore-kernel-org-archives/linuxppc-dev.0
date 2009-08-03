Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EF611B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 07:04:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49F9BDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 07:04:08 +1000 (EST)
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1249265010.5516.31.camel@concordia>
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
	<1249079342.1509.99.camel@pasglop> <1249265010.5516.31.camel@concordia>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 07:03:54 +1000
Message-Id: <1249333434.18245.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> for (cpu = cpu_first_thread_in_core(cpu);
>      cpu <= cpu_last_thread_in_core(cpu); cpu++)
>         __clear_bit(id, stale_map[cpu]);
> 
> ==
> 
> cpu = cpu_first_thread_in_core(cpu);
> while (cpu <= cpu_last_thread_in_core(cpu)) {
> 	__clear_bit(id, stale_map[cpu]);
> 	cpu++;
> }
> 
> cpu = 0
> cpu <= 1
> cpu++ (1)
> cpu <= 1
> cpu++ (2)
> cpu <= 3
> ...

Ah right, /me takes snow out of his eyes... indeed, the
upper bound is fubar. Hrm. Allright, we'll use a temp.

Cheers,
Ben.
