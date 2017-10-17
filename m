Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGdMY2PXwzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 01:47:36 +1100 (AEDT)
Date: Tue, 17 Oct 2017 16:47:33 +0200
From: Torsten Duwe <duwe@lst.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171017144733.GB2136@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 06, 2017 at 11:27:42AM +0530, Kamalesh Babulal wrote:
>
> Consider the livepatch sequence[1]. Where function A calls B, B is the
> function which has been livepatched and the call to function B is
> redirected to patched version P. P calls the function C in M2, whereas
> C was local to the function B and have became SHN_UNDEF in function P.
> Local call becoming global.
>
>   +--------+            +--------+    +--------+      +--------+
>   |        |   +--------+--------+--->|        |  +-->|        |
>   |  A     |   |        |  B     |    |  F     |  |   |  P     |
>   |        |   |        |        |    |        +--+   |        |
>   |        +---+        |        |    |        |<-+   |        |
>   |        |<--+   +----+   C    |    |        |  |   |        |
>   |        |   |   | +->|        |    |        |  |   |        |<---+
>   | K / M1 |   |   | |  | K / M2 |  +-+ Kernel |  +---+ Mod3   +--+ |
>   +--------+   |   | |  +--------+  | +--------+      +--------+  | |
>                |   | |              |                             | |
>                +---+-+--------------+                             | |
>                    | |                                            | |
>                    | +--------------------------------------------+ |
>                    +------------------------------------------------+
>
>
> Handling such call with regular stub, triggers another error:
>
> module_64: kpatch_meminfo: Expect noop after relocate, got 3d220000
>
> Every branch to SHN_UNDEF is followed by a nop instruction, that gets
> overwritten by an instruction to restore TOC with r2 value that get
> stored onto the stack, before calling the function via global entry
> point.
>
> Given that C was local to function B, it does not store/restore TOC as
> they are not expected to be clobbered for functions called via local
> entry point.

Can you please provide example source code of Mod3 and C? If P calls C, this
is a regular global call, the TOC is saved by the stub and restored after the
call instruction. Why do you think this is not the case? 

	Torsten
