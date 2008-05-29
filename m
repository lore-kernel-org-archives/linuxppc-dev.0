Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11B57DDFFE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:33:51 +1000 (EST)
Subject: Re: [PATCH 3/6] Make create_branch() return errors if the branch
	target is too large
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <d56f8a1ddf5d2653ffb547a580695a73615b0c1a.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<d56f8a1ddf5d2653ffb547a580695a73615b0c1a.1212042061.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 29 May 2008 16:33:40 +1000
Message-Id: <1212042820.8888.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-29 at 16:20 +1000, Michael Ellerman wrote:
> If you pass a target value to create_branch() which is more than 32MB - 4,
> or - 32MB away from the branch site, then it's impossible to create an
> immediate branch. The current code doesn't check, which will lead to us
> creating a branch to somewhere else - which is bad.
> 
> For code that cares to check we return 0, which is easy to check for, and
> for code that doesn't at least we'll be creating an illegal instruction,
> rather than a branch to some random address.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
