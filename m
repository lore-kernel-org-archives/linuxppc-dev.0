Return-Path: <ben@codiert.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B57DB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 23:39:37 +1000 (EST)
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9DE61DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 23:39:36 +1000 (EST)
Date: Thu, 16 Jul 2009 15:12:46 +0200
From: Benjamin Krill <ben@codiert.org>
To: enjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <michael@ellerman.id.au>
Subject: rtas instantiation when commandline contains mem
Message-ID: <20090716131246.GB22901@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

the rtas instantiation (prom_init.c) doesn't work correctly if the
kernel parameter "mem=" is used. The current code doesn't evaluate
the kernel parameter which causes the issue that alloc_down
allocates somewhere in the "real" memory space. So it can
happen that the allocation space is above "mem=".

Commit 2babf5c2ec2f2d5de3e38d20f7df7fd815fd10c9 removes the
evaluation of "mem=".

cheers
 ben
