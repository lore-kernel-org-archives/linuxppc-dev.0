Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28C14DDF33
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 12:04:07 +1000 (EST)
Subject: Re: [PATCH 2.6.26?] Raise the upper limit of NR_CPUS.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20080418053349.GE20457@bakeyournoodle.com>
References: <20080418053349.GE20457@bakeyournoodle.com>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 12:03:47 +1000
Message-Id: <1208743427.10486.2.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-18 at 15:33 +1000, Tony Breeds wrote:
> As the pacas are statically initialised increasing NR_CPUS beyond 128,
> means that any additional pacas will be empty  ... which is bad.
> 
> This patch adds the required functionality to fill in any excess pacas
> at runtime.
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> I know it's late, but can this be considered for 2.6.26?

NAK.

You must NEVER manipulate kernel globals from prom_init.c. The fact that
prom_init is linked with the kernel is an "accident" which may change.

Your scheme would break among others with kexec or non-OF bootloaders

Ben.
