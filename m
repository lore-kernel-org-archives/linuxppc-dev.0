Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17545.16696.195276.334774@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 19:36:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: mel@csn.ul.ie (Mel Gorman)
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
	attempt)
In-Reply-To: <20060529190515.GA17608@skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
	<20060526094924.10efc515.akpm@osdl.org>
	<20060529154923.GA9025@skynet.ie>
	<2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
	<Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
	<c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org>
	<20060529190515.GA17608@skynet.ie>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, vgoyal@in.ibm.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman writes:

> +	res->end = -(-res->end & ~(unsigned long)mask); \
> +	res->end += mask; \

I think this is equivalent to

	res->end = (res->end + mask) | mask;

and I have to say the latter seems more understandable to me (and
doesn't need a cast) ...

Regards,
Paul.
