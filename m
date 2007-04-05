Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2B940DDE39
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 06:37:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Questions about porting perfmon2 to powerpc
Date: Thu, 5 Apr 2007 22:37:01 +0200
References: <200704051455.34600.kevcorry@us.ibm.com>
	<200704052208.01753.arnd@arndb.de>
	<200704051532.08775.kevcorry@us.ibm.com>
In-Reply-To: <200704051532.08775.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704052237.02547.arnd@arndb.de>
Cc: Carl Love <carll@us.ibm.com>, Kevin Corry <kevcorry@us.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 April 2007, Kevin Corry wrote:
> For the moment, I made the change to topology_init() since it was the simplest 
> fix to get things working. I have considered switching the perfmon2 
> initialization to __initcall(), but there are apparently some timing issues 
> with ensuring that the perfmon2 core code is initialized before any of its 
> sub-modules. Since they could all be compiled statically in the kernel, I'm 
> not sure if there's a way to ensure the ordering of calls within a single 
> initcall level. I'll need to ask Stephane if there were any other reasons why 
> subsys_initcall() was used for perfmon2.

If they all come from the same directory, you can simply order them in
the Makefile. If a module in arch/ needs to be initialized after one in
drivers/, that's not possible though, and changing topology_init() should
be the best option.

	Arnd <><
