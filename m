Return-Path: <linuxppc-dev+bounces-23943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45826C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:22:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx0bl4YH6z3c9w;
	Fri, 10 Jul 2026 02:22:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783614131;
	cv=none; b=bqnj9D5KkJ8NIeay0wkuCRcLsmel407uRx3M5k0+mg/j/bMitzFqrCvz/FbGF91qvOtNle7wIShrMsWytaPQKNLhOen5G3Y1ZyPFRDMSAAgxDM2i79nUkWUSrxbodYCU2t1g0QspdL7zFHDVUOBjvsC8nlYW7r9OCNPvComLzjG1Eckl6RlDxM10sDzey3b7dJv/U7DTmzP3ZRXf3TYMtjwYSqLJ6H31tlibKJu+vpAkatc4shT0Sz7CIdZgObzPjQIIhE62h5/tQfzJ6ApaNySZzP/8r0+buZVsTD92WaWhdnoTgyYWkBIJ5y3QhncUM8ZGN2x3exnI5OwmPIq4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783614131; c=relaxed/relaxed;
	bh=E3GKiVGCG/M7FltpcGzY43WO5HnNe5q++QmCFGBnpG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcf+sXbRPcYMJXhr6rkARFcw2quEU1iMZ25WFI2kGHzGGrdEVS2DFWmaPfIemw+VYu/D6TUUNLdc4bc0cCA/uswNgxhFZW1pMsCLwzGW1nVzURDd8gNgD0TVkq+X/MdQLV8l0ovX3zyraXXZi3zuqI9xdpZM72N+mJOgBnwG4JIUxgO8R7z1NUy5TIIW2Ax4k86ENMw0zjIKgZWYgf3gFr+oMLOq0J+oNUIVtP3FmUcRK7h9f6+X6EOWn42CgtInNuaXB62sbIqSKagIqpEjPNzh+OOpGPbWTM7O5WSjNwf85RPqxsry3fO+1IA/MRyYX8zfEYcgG82zH+nW2yVE9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/Uien6v; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/Uien6v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx0bk0nb1z3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 02:22:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EECAA600C3;
	Thu,  9 Jul 2026 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FB1F000E9;
	Thu,  9 Jul 2026 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614126;
	bh=E3GKiVGCG/M7FltpcGzY43WO5HnNe5q++QmCFGBnpG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/Uien6vGeymdukHshCIRbD/qQirZnmNv1fkPyrZGO6+K+ckkFdEYSDwlnKFpi2BF
	 tuyJKBhR0dyYdYiHulLx/LgusylN0RPtbaGzeJM/aCdOjZzg650pi7YEBbg+JGqSHR
	 64dXPeQbq2evJa22r52hBC05ICSGISNW2xikw530YpQ+nCbruCjZdneQ5mim5aCUCw
	 Xf0AYTbfJ+wFGM1bNULmUZblGmQ7iYYE8zwgMJIETdC1+LLXgejWycDXueD9QUnxdI
	 F83JV94XXQwp5V/iZ2sAm+8m4as7p5Y/PmHH5g0nCXnFS05/jmhxEmyZJZGFezfdfB
	 UQzRtgW6GQfPA==
Date: Thu, 9 Jul 2026 09:22:06 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
Message-ID: <202607090921.ABE4BB4A@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.230735780@kernel.org>

On Tue, Jul 07, 2026 at 09:06:40PM +0200, Thomas Gleixner wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The return value of __secure_computing() currently uses 0 to indicate
> that a system call should be allowed, and -1 to indicate that it should
> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
> check function and makes the control flow at the call sites less readable.

Conceptually, I'm good with this. Just make sure that the
tools/testing/selftests/seccomp/seccomp_bpf tests still passes. :)

-- 
Kees Cook

