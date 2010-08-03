Return-Path: <anton@ozlabs.org>
Date: Wed, 4 Aug 2010 09:11:14 +1000
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: Optimise 64bit csum_partial
Message-ID: <20100803231114.GP29316@kryten>
References: <20100803060834.GK29316@kryten>
	<1C2B156C-E6C9-47CC-B5BF-6AA603581EC3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1C2B156C-E6C9-47CC-B5BF-6AA603581EC3@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Segher,

> Not really.  Do you know how many 16/32-bit words you can add before a
> 64-bit register can overflow? :-)

Thats a very good point. I thought about using 32bit adds when writing
the copy and checksum routine, but came to the conclusion that it wouldn't go
any faster than one using addes. The checksum only routine was the same loop
without the stores.

We rarely use csum_partial now we have copy and checksum to and from user
now, but I'll take a look at speeding it up in a follow on patch. Thanks!

Anton
