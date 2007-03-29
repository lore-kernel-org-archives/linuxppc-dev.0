Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 62355DDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 05:29:34 +1000 (EST)
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Avoid using libm in rootfs 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Mar 2007 12:39:11 +0200."
	<F1F6EC0C8B75034F9E3A79FC85122E8E71CD4A@aquib01a>
Date: Thu, 29 Mar 2007 21:29:32 +0200
Sender: wd@denx.de
Message-Id: <20070329192932.98FBD353A6C@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <F1F6EC0C8B75034F9E3A79FC85122E8E71CD4A@aquib01a> you wrote:
> 
> Is it possible to avoid using libm in my roofs? Why a simple application

Yes, this is possible.

> always need it? Is it needed by libc or libstdc++?

Simple applications don't need no libm. Neither  libc  nor  libstdc++
per se require libm.

It is your code and the library functions you call which causes such
dependencies. Note that you have to be aware that even innocent
looking calls like a

	printf ("Hello World\n");

may be the culprits

Example:

-> cat foo.c
#include <unistd.h>

int main (void)
{
        (void)write (1, "Hello World\n", 12);
        return 0;
}
-> export CROSS_COMPILE=ppc_6xx-
-> ppc_6xx-gcc -Wall -pedantic -o foo foo.c
-> ppc_6xx-ldd foo
        libc.so.6 => /opt/eldk/ppc_6xx/lib/libc.so.6
        ld.so.1 => /opt/eldk/ppc_6xx/lib/ld.so.1

You see: no libm needed.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Too much of anything, even love, isn't necessarily a good thing.
	-- Kirk, "The Trouble with Tribbles", stardate 4525.6
