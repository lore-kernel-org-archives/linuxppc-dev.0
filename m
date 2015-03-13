Return-Path: <linuxram@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB17A1A084B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 18:11:05 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40722140119
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2015 18:11:05 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 13 Mar 2015 01:11:03 -0600
Date: Fri, 13 Mar 2015 00:10:55 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] selftests/powerpc: Add a test of the switch_endian()
 syscall
Message-ID: <20150313071054.GA5064@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
 <1426221564-15086-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426221564-15086-2-git-send-email-mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 13, 2015 at 03:39:24PM +1100, Michael Ellerman wrote:
> This adds a test of the switch_endian() syscall we added in the previous
> commit.
> 
> We test it by calling the endian switch syscall, and then executing some
> code in the other endian to check everything went as expected. That code
> checks registers we expect to be maintained are, and then writes to
> stdout and then does exit(0).
> 
> If the endian switch failed to happen that code sequence will be illegal
> and cause the test to abort.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
..snip..
> +	.long 0x04000038
> +	# li      r3,1
> +	.long 0x01006038
> +	# mr      r4,r14
> +	.long 0x7873c47d
> +	# li      r5,21
> +	.long 0x1500a038
> +	# sc
> +	.long 0x02000044
> +	# li      r3,0
> +	.long 0x00006038
> +	# 1:
> +	# li      r0, __NR_exit

Would it make sense to toggle the endianness here,
checking for the same register sanity before exiting?

That way endian switching is tested both ways?

RP
