Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBB2D679F8
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2005 08:29:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <e9d0cf12aef70d985053ec7eafb0a9db@embeddededge.com>
References: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
	<1116575115.5153.115.camel@gaston>
	<e9d0cf12aef70d985053ec7eafb0a9db@embeddededge.com>
Content-Type: text/plain
Date: Sat, 21 May 2005 08:27:32 +1000
Message-Id: <1116628052.5153.123.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu type explicitly, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-05-20 at 10:30 -0400, Dan Malek wrote:
> On May 20, 2005, at 3:45 AM, Benjamin Herrenschmidt wrote:
> 
> > The problem is the same as ppc64 isn't it ?, -maltivec doesn't work 
> > with
> > -mcpu=power4 on gcc 3.4 does it ? That would mean no RAID6...
> 
> I don't understand "doesn't work."  Does power4 imply altivec?
> Do we need to add -maltivec based on the configuration option?

No, -mcpu=970 is equivalent in a way to -mcpu=power4 and -maltivec,
howevever, there is a bug in gcc 3.4 which makes -maltivec cause an
error if you have -mcpu=power4. The RAID6 code needs -maltivec. So on
gcc 3.4, we need to use -mcpu=970 instead of -mcpu=power4. However, we
must _NOT_ do that on gcc-4.0 as that causes it to implicitely generate
altivec code all over the place. (Fortunately, the bug is also fixed
there, so with gcc-4.0, we just need -mcpu=power4 and -maltivec only on
the RAID6 code)

Messy ? Yeah !

Ben.
