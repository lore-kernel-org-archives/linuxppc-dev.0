Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F901A0190
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 08:48:00 +1100 (AEDT)
Date: Thu, 4 Feb 2016 22:47:56 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
In-Reply-To: <56B31A7C.2050803@linaro.org>
Message-ID: <alpine.LNX.2.00.1602042244430.22727@cbobk.fhfr.pm>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de> <56B1AAE5.10500@linaro.org>
 <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
 <20160203112449.GA27247@lst.de> <56B31A7C.2050803@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 4 Feb 2016, AKASHI Takahiro wrote:

> On arm/arm64, link register must be saved before any function call. So anyhow
> we will have to add something, 3 instructions at the minimum, like:
>    save lr
>    branch _mcount
>    restore lr
>    <prologue>
>    ...
>    <body>
>    ...

This means that we have at least two architectures that need one 
instruction before the mcount/mfentry call, and the rest of the prologue 
to follow afterwards. On x86, we don't need any "pre-prologue".

Persumably the corresponding opcodes have different sizes. This nicely 
demonstrates my point -- if this one-gcc-option-to-rule-them-all would 
exist, it needs to be generic enough to describe these kinds of 
constraints (who knows what other restrictions will pop up when exploring 
other, more exotic, architectures later).

Thanks,

-- 
Jiri Kosina
SUSE Labs
