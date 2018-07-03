Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KtPb5wdvzF1QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 04:46:27 +1000 (AEST)
Date: Tue, 3 Jul 2018 13:46:18 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: William Kennington <wak@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: GCC strcmp optimizations causing valgrind uninitialized
 conditional jumps
Message-ID: <20180703184617.GF16221@gate.crashing.org>
References: <CAPnigKnVTg5UiEfou=ABL2DH31rFyGZ_1qtqevJqPPw-V-E6-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPnigKnVTg5UiEfou=ABL2DH31rFyGZ_1qtqevJqPPw-V-E6-A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Tue, Jul 03, 2018 at 11:26:55AM -0700, William Kennington wrote:
> I've noticed while trying to do some valgrind testing on code linked
> against system libraries that have inlined strcmps that valgrind is
> unhappy about branches depending on uninitialized memory. I've read

The branches here do *not* depend on uninitialised memory.  Valgrind
does not realise that however.  The valgrind people are aware of this
problem.

> Any ideas on how to workaround / fix this?

Does -fno-builtin-strcmp do the trick?


Segher
