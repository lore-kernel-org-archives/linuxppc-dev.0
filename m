Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3F606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:37:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVVgD5hkDz2xlk;
	Thu, 19 Nov 2026 18:37:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795073864;
	cv=none; b=moqIbz63KmK8j9erP1A296Wk+z8fbS42/EWcJyoUMn5eNUX8Bz0DjdPn99BmyLcE9kCHeihlV4qBjDRE3rXrYdun+oVbVdMoemv1ibVJvL3AHNMIin4H7m0JoqRY5q3nNyN1lqMHo7ONhiH4QlLeEwttiZBoCu0UhmvDwnj5/fnwwrI7pI182FEI2e5+1R4h874WmK+hyDZVwB6Hufnsl4nS8SuBqwJn49BVCUV35m45KnW/3dL0BHdn/5+9EM6MT6RcNME7e1bRcJg3T+QhkeJmaYic7oLF8dPcldK9J9yROsdwXWp1BN1CXjEtbY+ZQtiIzg5e9psu9WzbHQqtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795073864; c=relaxed/relaxed;
	bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIEoH2U+mvk0/aEBOzPVzyFA9olbSC0p5mEanBHo/be/laUg/Ev0QmjDxz4f+dWjM/cGpYUY6PIg3rJ1sCb9SpDQ71poFTQUeCYxE4Th4bs6pHiczFJiRf6Xy81vuXwPqpNrMJZlcmFYnbic05kdZN5ObelkzTammTV7x/wtS58zCEJGO+dvhz0Ez6SvbAG52pxTaGo+GVsPT0DQ/46yJHer08RE0/MPepy6egpwOumpSR49BglCjdFLFO4C6sqltVoTncNWZavu61C2580PU8dRoljCw65QYgKSPeg0HzhF9AHn5RKQLZMZr/6HoerNyzth3jgTxJ9fiJotlyxc2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.161.44; helo=mail-oo1-f44.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.161.44; helo=mail-oo1-f44.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVVgC4rVYz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 18:37:42 +1100 (AEDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-7190d9bdb2cso1338302eaf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 23:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073859; x=1795678659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
        b=EjFJa0TiZl6fiPjY47ZkC7uZ/A0Z/QaOnEVS881p2Y9+OKsDdpIKr2fRc1a+YJCu1a
         6/K15uSOV/6zaeMXB2jx0dH1U9IiLi0QivUXlLonCwXERnbXW82umucIDRm38BiVnGv0
         dMpHDF97V8fObMgsNHih41mGj4noFDEMhy9HMmD81dPnnZC+bCe6/Y9P3V0OasXkMZIJ
         EsGuU/YBmd9DcP8F0XGv8Qfw0/8pHlPszZo+5+TbOb6ndvFRJg9hilFm9m8vLyeCGrks
         P/6ZIHI5UdRyKq6NvbkElolLvc/6JFgZsI5EYwCfuHjKgn11FNzdX3vWmONjT2SKhG6C
         R11Q==
X-Forwarded-Encrypted: i=1; AL+hErGHX/X5/m4ooZhotP61hTFCl/ccFIZl/0CXtE2kHh72C3YUUn+kn48aLoX3I3HOlfRfhUL6I5J9o7lpbL0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/WFo05lL/e/tA1bDV6ufeVFprBbZmSf0ygWVFTBzjq2JJLOJNE
	wqloFc0S6y/DUbh/berChIUJRcYBxS2MQl9KqiCDnaGXpKMhKrS43o94hFOOvzt3
X-Gm-Gg: AYBFou3y9NYPTW5ZwSBQpIZMUp7i/DA9t67pXAPAQpKgFAPsVRTCOKf+P9x0SSJG5lD
	3tr3jqQyUn5hV1qgoN2Z7hcQxl8Dies0+M4HS10C8SoB9WN3Ur8rCzfoU3iMogNI+oP5qFIdt6m
	eppxh20OtMLfKHnkiN7wsT6FDKiKTTT5S28X1AWaiWLBm+M7R7gHLxdshazorbzeAjjH2a5c36T
	JHPwpw5izeHLiX5Uecs6mX+/z5kTCOp/RfCSqmdolJQTnCjUBJVVRrdGE8b+rnMX9MzSkzyI2/r
	JEoVxwnuCQx/Imz9cgty9RTqaHwjDH10V6hfsSjuYWSdIaEq6g8JBXBTNnR9CU806h29PKyqRhx
	mBwCCt7TRK1LVvyn+grfKxLMsHWjE+qWKAXgFQqWs3T/c2AEYGIRPFVU/1CFtQ3sxzDzVfbJ0uX
	6VZ303d3VJnB2gjs59uN8Y9Y+cMKyxGlgT2DC8hzQXswLWYBmp+kpt2UWT22UeTqMXA0VyGcEUJ
	X8hArF9aChok291LqpHnzUSbAP9qzXiL6FO7uvD5BeniIUsXFqTtDk7k+Yt1h7HAzE78xhnWQg6
	cFTrjkv89VnhnF7vz+asHWWknwYREa4gYWOAzb9hUYFjbE393UOyelZ2vdHVfPO9aig=
X-Received: by 2002:a05:6820:2ad8:b0:717:da:ba40 with SMTP id 006d021491bc7-71b185657acmr3138700eaf.26.1795073859019;
        Wed, 18 Nov 2026 23:37:39 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b19450af7sm4056823eaf.4.2026.11.18.23.37.38
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:37:38 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8629c7cc36eso1118282a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 23:37:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHt5xfPENPLwyxy3BpCn0J4r4fx9l9zy1PZN5RmM9JNQKaP04qkevWDzSUkMlPI/Ufn+W68pGCGZJG2wh8=@lists.ozlabs.org
X-Received: by 2002:a05:6102:e0c:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d6ba35b7d8mr1806982137.13.1795073401089; Wed, 18 Nov 2026
 23:30:01 -0800 (PST)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 08:29:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
X-Gm-Features: Aa3M54rf5ygj8ORK3fy8Y6Bg5UcrfzvYekQ-eoJmIgxSYs0ZeBrecHV4-2jERSw
Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 07:17, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # sh

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

