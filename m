Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D361DDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 05:48:03 +1000 (EST)
Date: Wed, 22 Aug 2007 12:47:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.23-rc3-mm1: kgdb build failure on powerpc
Message-Id: <20070822124743.fc316963.akpm@linux-foundation.org>
In-Reply-To: <200708222104.29432.m.kozlowski@tuxland.pl>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
	<200708222104.29432.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kgdb-bugreport@lists.sourceforge.net, amitkale@linsyssoft.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Aug 2007 21:04:28 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	Got that on imac g3.
> 
>   CC      kernel/kgdb.o
> kernel/kgdb.c: In function 'kgdb_handle_exception':
> kernel/kgdb.c:940: error: invalid lvalue in unary '&'
> kernel/kgdb.c:940: warning: type defaults to 'int' in declaration of '_o_'
> kernel/kgdb.c:940: error: invalid lvalue in unary '&'
> kernel/kgdb.c:940: warning: type defaults to 'int' in declaration of '_n_'
> kernel/kgdb.c:940: error: invalid lvalue in unary '&'
> kernel/kgdb.c:940: error: invalid lvalue in unary '&'
> kernel/kgdb.c:940: error: invalid lvalue in unary '&'
> kernel/kgdb.c:940: warning: type defaults to 'int' in declaration of 'type name'
> make[1]: *** [kernel/kgdb.o] Blad 1
> make: *** [kernel] Blad 2
> 

I'm not surprised.

	while (cmpxchg(&atomic_read(&debugger_active), 0, (procid + 1)) != 0) {

a) cmpxchg isn't available on all architectures

b) we can't just go and take the address of atomic_read()'s return value!

c) that's pretty ugly-looking stuff anyway.
