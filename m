Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 445EADDFD2
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 09:06:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
Date: Tue, 4 Dec 2007 23:05:56 +0100
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<200712042036.00785.arnd@arndb.de>
	<1196800273.13230.333.camel@pasglop>
In-Reply-To: <1196800273.13230.333.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712042305.56881.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Benjamin Herrenschmidt wrote:
> > 2. The call to firmware_has_feature() turns into a compile-time check
> > in
> > many cases, so if the kernel does not contain support for any firmware
> > with the given feature, all the code referenced it can get optimized
> > away by the compiler.
> 
> The machine init stuff will soon get rid of whatever test is in it too,
> as soon as I get to do the ELF magic.

Section magic is often painful and causes a number of problems. Moreover, it
won't do the same thing as what the compiler can do. Consider

static int x __attribute__((section("some_platform.data"))) = 1;
static int f(void) __attribute__((section("some_platform.text")));
{
	if (firmware_has_feature(FOO))
		return x;
	return 0;
}

When firmware_has_feature(FOO) statically evaluates to false, f becomes an
empty function and x is left out from the object file.
If you turn it into a platform_is() check and discard all "some_platform"
sections, you need to have both in the vmlinux file and can discard them
at run time, which is something completely different. You can also
discard them in the linker script, but that's a lot more work than having
the compiler do the right thing.

	Arnd <><
