Date: Fri, 14 Mar 2003 13:21:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@linuxppc.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ppc: Update to ppc specific makefiles
Message-ID: <20030314202148.GA7230@ip68-0-152-218.tc.ph.cox.net>
References: <20030314194427.GA18790@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030314194427.GA18790@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 14, 2003 at 08:44:27PM +0100, Sam Ravnborg wrote:

> Made on top of ppc.bkbits.net/linuxppc-2.5

Looks good:

[snip]
> 5) Deleted rules for find_name
>         -> I could not see it referenced anywhere,
>            but find_name.c is still present

Yeah, that's gone.

[snip]
> The kernel builds and when a rebuild is made no files are compiled again.
> arch/ppc/boot/{openfirmware,prep,simple}/Makefile could use more
> attention - but wanted to see this applied first.

I'm open to ideas for how to clean those up.  Please CC me with those
(I'll read it quicker, most likley :)

[snip]
> ===== arch/ppc/boot/utils/Makefile 1.5 vs edited =====
> --- 1.5/arch/ppc/boot/utils/Makefile	Sat Dec 14 13:38:56 2002
> +++ edited/arch/ppc/boot/utils/Makefile	Fri Mar 14 19:16:28 2003
> @@ -5,16 +5,10 @@
>  # License.  See the file "COPYING" in the main directory of this archive
>  # for more details.
>
> -HOSTCFLAGS += -I$(TOPDIR)/arch/$(ARCH)/boot/include
>
> -all: FORCE
> +HOST_EXTRACFLAGS += -Iarch/$(ARCH)/boot/include
>
> -# Simple programs with 1 file and no extra CFLAGS
> -UTILS = addnote hack-coff mkprep mknote mkbugboot mktree \
> -	addSystemMap addRamdDisk
> +host-progs	:=	addnote hack-coff mkprep mknote mkbugboot mktree \
> +			addSystemMap addRamdDisk
>
> -$(UTILS):
> -	$(HOSTCC) $(HOSTCFLAGS) -o $@ $@.c
> -
> -clean:
> -	rm -f $(UTILS)
> +build-targets	:= $(host-progs)

Maybe I'm missing something, but won't this cause all of host-progs to
be compiled on any build?  They're small / quick enough to build that I
suppose it wouldn't kill anyone to build extra tools they don't need,
but in that case, the tools- stuff could die in arch/ppc/boot/Makefile,
right?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
