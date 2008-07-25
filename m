Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA4FFDE2F7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 18:28:15 +1000 (EST)
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1216972177.7257.351.camel@twins>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
	<20080724141839.477de30b@bull.net>  <1216972177.7257.351.camel@twins>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 18:27:20 +1000
Message-Id: <1216974440.11188.100.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Tim Chavez <tinytim@us.ibm.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Paul Mackerras <paulus@samba.org>, Gilles Carry <Gilles.Carry@ext.bull.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 09:49 +0200, Peter Zijlstra wrote:
> 
> 
> The only advantage of the concurrent radix tree over this model is that
> it can potentially do multiple modification operations at the same time.

Yup, we do not need that for the irq revmap... concurrent lookup is all we need.

Cheers,
Ben.
