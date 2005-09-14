Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Wed, 14 Sep 2005 04:35:21 +0200
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
In-Reply-To: <1126644202.11056.59.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509140435.21916.arnd@arndb.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dinsdag 13 September 2005 22:43, Jon Loeliger wrote:
> Here is a patch to merge asm-ppc*/sections.h.
> 
> If anyone knows if we can do better here,
> please feel free to abuse, er, let me know!

Ok, I don't like this patch. IMHO for the architecture merge, we should
have a common implementation of this, either always using per-platform
sections or never using them, meaning that we get rid of this file.

At the very least, the __*func() macros should go away, they are completely
bogus.

Using the sections in arch/powerpc has the obvious advantage that it
reduces the size of the running kernel, but also has a certain amount
of bug-potential or at least makes the code slightly more ugly.
It is also easier to remove the feature in ppc than adding it in ppc64.

The users of the ppc64 function in_kernel_text() can probably be converted
to the generic is_kernel_text() function.

	Arnd <><
