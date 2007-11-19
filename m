Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18241.3066.346441.180033@cargo.ozlabs.ibm.com>
Date: Mon, 19 Nov 2007 15:07:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] [POWERPC] vdso: Fixes for cache block sizes
In-Reply-To: <20071114212823.GA3044@lixom.net>
References: <20071114192405.GA1637@lixom.net>
	<1195072102.28865.41.camel@pasglop>
	<20071114212823.GA3044@lixom.net>
Cc: dwmw2@infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> [POWERPC] vdso: Fixes for cache line sizes
> 
> Current VDSO implementation is hardcoded to 128 byte cache blocks,
> which are only used on IBM's 64-bit processors.
> 
> Convert it to get the  blocks sizes out of vdso_data instead, similar
> to how the ppc64 in-kernel cache flush does it.

OK, but you have removed a "crclr cr0*4+so" instruction in a couple of
places.  They are there so that the functions follow the convention
for system calls, where cr0.SO set on return indicates an error, and
clear indicates no error.  Was there any special reason why you
removed them?  If not, please put them back (after the last cmp or
dot-form instruction).

Paul.
