Date: Thu, 15 Jul 2004 07:15:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040715141540.GQ21856@smtp.west.cox.net>
References: <20040712180321.GB16877@smtp.west.cox.net> <20040713134945.GA5104@suse.de> <20040713140127.GJ16877@smtp.west.cox.net> <20040713140220.GA20213@suse.de> <20040713142015.GK16877@smtp.west.cox.net> <20040713151854.GA7858@suse.de> <20040713152633.GL16877@smtp.west.cox.net> <20040713152950.GB7858@suse.de> <20040714232336.GO21856@smtp.west.cox.net> <20040715125032.GA20266@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040715125032.GA20266@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 15, 2004 at 02:50:32PM +0200, Olaf Hering wrote:

>  On Wed, Jul 14, Tom Rini wrote:
>
>
> > +BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null 2>/dev/null 2>&1 && echo 0 || echo 1)
> >
> > -ifneq ($(NEW_AS),0)
> >  checkbin:
> > +ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
>
> How is this supposed to work? You get either 0 or 1.

OK.  The intent was that GCC_VERSION is always run, which will give
'0304' on gcc-3.4 (tested) and if the binutils test also fails it will
always give '1'.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
