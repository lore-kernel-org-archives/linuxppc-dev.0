Return-Path: <linuxppc-dev+bounces-19904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB2F8FA9E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 17:07:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0TLB3nkQz30M6;
	Wed, 22 Apr 2026 03:07:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776791234;
	cv=none; b=gM6L6NopVBkSrz30AuvAfNYzHMaQvkWTndFXrgp2nZIznYrvUu0Ccncsy7i5l8SSEVhfpzQqBkecfSbENihhabbnX1oaQuyDU6bfU7rbfTh1fuUH0CpBywKxbo1G3mbb0Q1ulU6eKc83Vmut1n0TMfTpjzqoOIsVfx7wOEJCA11vg+139IpxmxCcj1ZT3URRhHCgmpV+Eq1OX939FX3R0N94Q2ceAsoJ260EPoYuWEtbeiXzTMapqi53uaXTupo5MHmch9Tac6wJvH7Y0hfeKJcHFRIl1w62T0Mjyllo05XyHBkImoGb33muDcZhMhj+84AcJaLa9MddaBzkUcwGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776791234; c=relaxed/relaxed;
	bh=Uai57GDlZcmmVdn4r45IDOgQLlipLIc0UogQeSIxjz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXFGmAyvv036O2KZgx5gMdHXk9zdRxJ4eOi8W0h2w2M42sX/QQw5q5u/UrL2zlpMJBoKsM7K/DVCW10P9wbkJyqjzckvJpoehFxzWusW2kDodYfTA/cYvi8FYtgj/1ngJQX7JbIu7MgSlrPP6ovx1cSD/uYhy426RjKXfGptlcQTprk9A1UhEnhwP8Ft/uyXs1pfTUtUwqXQeV4A3o/UFk7qvkyFBm0D9UoAySds9XENg/JnBWkSVznfZNL/lgZ4I73+z1b9Fo2pbw0Vi5kWAa48vgd2IskuWC581u5nx7LDdCZk9evzMj9gHF3VV/xdgdNQXBEDi4Nsca6MU7Q//Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0TL81rCTz302b
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 03:07:11 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63LH4FuA3771909;
	Tue, 21 Apr 2026 12:04:15 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63LH47sR3771903;
	Tue, 21 Apr 2026 12:04:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 21 Apr 2026 12:04:06 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Geoff Levand <geoff@infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Anatolij Gustschin <agust@denx.de>,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Thomas Huth <thuth@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Paul Moore <paul@paul-moore.com>, Nam Cao <namcao@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Kees Cook <kees@kernel.org>, Stephen Rothwell <sfr@cab.auug.org.au>,
        Xichao Zhao <zhao.xichao@vivo.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Guangshuo Li <lgs201920130244@gmail.com>,
        Li Chen <chenl311@chinatelecom.cn>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Feng Tang <feng.tang@linux.alibaba.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yeoreum Yun <yeoreum.yun@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Chen Ni <nichen@iscas.ac.cn>, Haren Myneni <haren@linux.ibm.com>,
        Jonathan Greental <yonatan02greental@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
        Gaurav Batra <gbatra@linux.ibm.com>,
        Nilay Shroff <nilay@linux.ibm.com>,
        Vivian Wang <wangruikang@iscas.ac.cn>,
        Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>, Yury Norov <ynorov@nvidia.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Ruben Wauters <rubenru09@aol.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 2/2] powerpc: Run typos -w
Message-ID: <aeeuBnjhRN7G9gYK@gate>
References: <20260421121420.26079-1-linkmauve@linkmauve.fr>
 <20260421121420.26079-3-linkmauve@linkmauve.fr>
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
In-Reply-To: <20260421121420.26079-3-linkmauve@linkmauve.fr>

Hi!

On Tue, Apr 21, 2026 at 02:14:14PM +0200, Link Mauve wrote:
> diff --git a/arch/powerpc/boot/dts/fsl/ppa8548.dts b/arch/powerpc/boot/dts/fsl/ppa8548.dts
> index f39838d93994..32558104b3a9 100644
> --- a/arch/powerpc/boot/dts/fsl/ppa8548.dts
> +++ b/arch/powerpc/boot/dts/fsl/ppa8548.dts
> @@ -95,7 +95,7 @@ i2c@3100 {
>  
>  	/*
>  	 * Only ethernet controller @25000 and @26000 are used.
> -	 * Use alias enet2 and enet3 for the remainig controllers,
> +	 * Use alias enet2 and enet3 for the remaining controllers,

Aliases.

> diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
> index 41f917f97dab..48a98449ecbb 100644
> --- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
> +++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
> @@ -90,14 +90,14 @@ can@1,0 {
>  			compatible = "nxp,sja1000";
>  			reg = <0x1 0x0 0x80>;
>  			interrupts = <18 0x8>;
> -			interrups-parent = <&ipic>;
> +			interrupts-parent = <&ipic>;
>  		};

interrupt-parent .

All the names of properties have a meaning!  Just as you cannot change
a function name in C without changing all calls to it as well, you
really should never change a property name (if you want stuff to keep
on working, that is ;-) ).

In this case, the property was never actually used (because of the
typo).  Maybe it wasn't needed?  If you make changes to a DTS, post it
*separately* from the rest of this series, and test it *thoroughly*.
Just a "does it boot" test is certainly not enough.

It could well be that fixing the typo (so that the property name becomes
"interrupt-parent") makes the kernel no longer boot on the systems
affected, or less obvious problems can show up.

It will need to be tested and evaluated by whoever maintains the DTSes
in question, really :-/  And you cannot test it works for one DTS and
then conclude it will work everywhere, heh.


Segher

