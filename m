Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Kv6n2FmJzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 05:18:41 +1000 (AEST)
Date: Tue, 3 Jul 2018 14:18:33 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: William Kennington <wak@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: GCC strcmp optimizations causing valgrind uninitialized
 conditional jumps
Message-ID: <20180703191833.GG16221@gate.crashing.org>
References: <CAPnigKnVTg5UiEfou=ABL2DH31rFyGZ_1qtqevJqPPw-V-E6-A@mail.gmail.com>
 <20180703184617.GF16221@gate.crashing.org>
 <CAPnigK=HP_F6a3EuM-G8XHH1G_SyLCscT72=yVwtFxDmBZ6WOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPnigK=HP_F6a3EuM-G8XHH1G_SyLCscT72=yVwtFxDmBZ6WOQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 03, 2018 at 11:59:14AM -0700, William Kennington wrote:
> Is there a bug tracking the issue?

https://bugs.kde.org/show_bug.cgi?id=386945

> Also, unless your malloc is
> guaranteed to be zeroing out the data or have a strcmp that is writing
> doubleworld aligned data to the string, the strcmp implementation is
> branching based on data existing after the null terminating character
> that may be uninitialized. Both sides of the branch do the right thing
> though, and locate the null terminator, throwing away the calculations
> done on the uninitialized data.

Yes, there is one branch that depends in part on irrelevant data, but
that is handled immediately afterwards.

> -fno-builtin-strcmp or -mstring-compare-inline-limit=0 do work fine
> but we don't control the binaries we are linking against in all cases
> and are seeing the issue pop up there.

Yeah, nasty.  I don't know what to do then (other than fix valgrind, which
isn't so easy either though!)


Segher
