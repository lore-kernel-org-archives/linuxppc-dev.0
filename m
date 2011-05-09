Return-Path: <vapier.adi@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47452B6FCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  9 May 2011 12:39:06 +1000 (EST)
Received: by ywg4 with SMTP id 4so1937648ywg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 08 May 2011 19:39:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201105081133.50824.sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<20110508092403.GB27807@n2100.arm.linux.org.uk>
	<201105081133.50824.sven@narfation.org>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Sun, 8 May 2011 22:38:43 -0400
Message-ID: <BANLkTim+z0mv7oXZHr0YnoxtfnoDZTEr9Q@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
To: Sven Eckelmann <sven@narfation.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	David Howells <dhowells@redhat.com>,
	linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 8, 2011 at 05:33, Sven Eckelmann wrote:
> Russell King - ARM Linux wrote:
> [...]
>> Do we need atomic_dec_not_zero() et.al. in every arch header - is there =
no
>> generic header which it could be added to?
>
> Mike Frysinger already tried to answer it in
> <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>:
>> that's what asm-generic is for. =C2=A0if the arch isnt using it, it's
>> either because the arch needs to convert to it, or they're using SMP
>> and asm-generic doesnt yet support that for atomic.h.
>>
>> for example, the Blackfin port only needed updating for the SMP case.
>> in the non-SMP case, we're getting the def from asm-generic/atomic.h.
>
> Feel free to change that but I just followed the style used by all other
> macros and will not redesign the complete atomic*.h idea.

what you're doing is currently correct.  i think merging SMP support
into asm-generic for atomic* will take a bit of pondering first.
-mike
