Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17682.34922.240565.233215@cargo.ozlabs.ibm.com>
Date: Thu, 21 Sep 2006 22:41:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: powerpc: clarify use of twi/isync in io macros
In-Reply-To: <20060919193020.GN29167@austin.ibm.com>
References: <20060919193020.GN29167@austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> + * A data-dependent branch followed by an isync ensures that no
> + * instructions after the isync in program order will be
> + * (speculatively) executed, so the load that the twi depends
> + * on has to complete before anything else is executed; in

While the statement about branches is true, it's not especially
relevant when it comes to twi.  What's happening is that isync has to
prevent any following instructions from starting execution until all
previous instructions have completed, meaning that they have got to
the point of knowing whether they will generate an exception or not.
In general the processor doesn't know whether twi will generate an
exception until the data it depends on is available, and that's why
the isync has to wait for the previous load to have returned the
data.

> + * particular, it's a barrier to keep MMIO reads ordered before
> + * main-storage accesses.

Yes.

Paul.
