Return-Path: <vapier.adi@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19EF8B6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 18:33:47 +1000 (EST)
Received: by gwj17 with SMTP id 17so359838gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 04 May 2011 01:33:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 4 May 2011 04:33:24 -0400
Message-ID: <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
	David Howells <dhowells@redhat.com>,
	linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sven Eckelmann <sven@narfation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 4, 2011 at 04:05, David Laight wrote:
>> Introduce an *_dec_not_zero operation. =C2=A0Make this a special case of
>> *_add_unless because batman-adv uses atomic_dec_not_zero in different
>> places like re-broadcast queue or aggregation queue management. There
>> are other non-final patches which may also want to use this macro.
>
> Isn't there a place where a default definition of this can be
> defined? Instead of adding it separately to every architecture.

that's what asm-generic is for.  if the arch isnt using it, it's
either because the arch needs to convert to it, or they're using SMP
and asm-generic doesnt yet support that for atomic.h.

for example, the Blackfin port only needed updating for the SMP case.
in the non-SMP case, we're getting the def from asm-generic/atomic.h.
-mike
