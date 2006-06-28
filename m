Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17569.56937.308576.848377@cargo.ozlabs.ibm.com>
Date: Wed, 28 Jun 2006 11:42:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Assume we're on cpu 0 in early boot
In-Reply-To: <20060627040036.469B767B28@ozlabs.org>
References: <787248AD-2E47-454E-9F56-7E5350A9F184@watson.ibm.com>
	<20060627040036.469B767B28@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> There's a small period early in boot where we don't know which cpu we're
> running on. That's ok, except that it means we have no paca, or more
> correctly that our paca pointer points somewhere random.
> 
> So that we can safely call things like smp_processor_id(), we need a paca,
> so just assume we're on cpu 0. No code should _write_ to the paca before
> we've set the correct one up.

OK, but why not just do a setup_paca(0) at the start of early_setup(),
in C code?  You can also remove the redundant paca setting in
start_here_common() in head_64.S.

Paul.
