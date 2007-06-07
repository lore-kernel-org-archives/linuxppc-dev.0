Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A0A25DDF17
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:19:18 +1000 (EST)
Message-ID: <46682FFB.7000000@am.sony.com>
Date: Thu, 07 Jun 2007 09:19:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
References: <25445.1180941825@neuling.org>	<8f5d8a214e9042b0c556ac7256928a52@bga.com>	<26608.1180950136@neuling.org>
	<10188.1181179162@neuling.org>
In-Reply-To: <10188.1181179162@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: dwmw2@infradead.org, kexec@lists.infradead.org,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.  Also, if there was no /chosen/bootargs
> previously, we'd never add a new one. 
> 
> This ignores the bootargs while parsing the tree and inserts it later. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Hi.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>

I tested this with PS3 and it works as expected.  I added it to my
ps3-kexec-tools.git.  With this patch mainline kexec will work
with the PS3.

I still have a work-in-progress patch started by David Woodhouse
to support building a 32 bit kexec executable for PPC64 platforms.
I don't have any definite plan to work on it though.

-Geoff
