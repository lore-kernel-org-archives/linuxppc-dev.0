Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAF9BB70A6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 01:06:46 +1000 (EST)
In-Reply-To: <20100803060834.GK29316@kryten>
References: <20100803060834.GK29316@kryten>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1C2B156C-E6C9-47CC-B5BF-6AA603581EC3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: Optimise 64bit csum_partial
Date: Tue, 3 Aug 2010 17:09:30 +0200
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On both POWER6 and POWER7 this should be as fast as we can go since
> we are limited by the latency of the adde instructions.

Not really.  Do you know how many 16/32-bit words you can add before a
64-bit register can overflow? :-)
If you ever have to call this with more than 16GB of data to sum, that's
easy to handle as well of course (just break it into pieces).


Segher
