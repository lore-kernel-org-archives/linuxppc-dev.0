Return-Path: <ben@codiert.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 524FCB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 16:36:32 +1000 (EST)
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A26CCDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 16:36:31 +1000 (EST)
Date: Fri, 17 Jul 2009 08:36:20 +0200
From: Benjamin Krill <ben@codiert.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: rtas instantiation when commandline contains mem
Message-ID: <20090717063620.GC22901@codiert.org>
References: <20090716131246.GB22901@codiert.org>
	<1247783770.27937.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1247783770.27937.61.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> the rtas instantiation (prom_init.c) doesn't work correctly if the
>> kernel parameter "mem=" is used. The current code doesn't evaluate
>> the kernel parameter which causes the issue that alloc_down
>> allocates somewhere in the "real" memory space. So it can
>> happen that the allocation space is above "mem=".
>> 
>> Commit 2babf5c2ec2f2d5de3e38d20f7df7fd815fd10c9 removes the
>> evaluation of "mem=".
>
>Ah yes, we don't constraint prom_init.c to mem=, only the kernel

Is that with intent? Or should I provide a patch to include it again?

cheers
 ben
>
>
