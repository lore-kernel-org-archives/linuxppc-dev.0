Return-Path: <glaubitz@physik.fu-berlin.de>
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408lGv27WBzF1y3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 17:53:43 +1100 (AEDT)
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
 linux-mips <linux-mips@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>,
 the arch/x86 maintainers <x86@kernel.org>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
 <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
Date: Mon, 26 Mar 2018 15:44:18 +0900
MIME-Version: 1.0
In-Reply-To: <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus!

On 03/26/2018 03:15 PM, Linus Torvalds wrote:
> Secretly, I was hoping to kill x32, because it's not being used afaik.
FWIW, we are maintaining an x32 port in Debian and there are some people
actually using it [1]. There is one build instance running on VMWare that
I am hosting [2] and around 10800 out of 12900 source packages build fine
on x32 (12900 being the number for x86_64).

The port is mostly stable but the fact that it's a 32-bit target with a
64-bit kernel API often blows up in people's faces because they don't
expect things like a 64-bit time_t on a 32-bit system.

The port also has some issues with software unaware of the x32 and builds
fail when they just test for __x86_64__ but not for __ILP32__, but overall
it's usable and stable and has some performance advantages over x86_64.

Adrian

> [1] http://debian-x32.org/
> [2] https://buildd.debian.org/status/architecture.php?a=x32&suite=sid

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
