Date: Sun, 25 Jul 2004 15:37:54 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Tom Rini <trini@kernel.crashing.org>, Olaf Hering <olh@suse.de>,
	Stef Simoens <stefaan.simoens@coditel.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040725060754.GE7099@bubble.modra.org>
References: <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <40E75DC7.7070601@coditel.net> <20040704024149.GB2146@smtp.west.cox.net> <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be> <E2EB9906-CDD7-11D8-92C8-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E2EB9906-CDD7-11D8-92C8-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 04, 2004 at 11:33:31AM -0500, Hollis Blanchard wrote:
> On Jul 4, 2004, at 3:32 AM, Geert Uytterhoeven wrote:
> >
> >Perhaps it makes sense to add a directive to the assembler to switch
> >on the
> >fly, cfr. the `.chip' directive on m68k? E.g. using
> >
> >    .chip 68040
> >
> >we switch to 68040 mode, and using
> >
> >    .chip 68k
> >
> >we switch back to generic mode. That way we can have instructions for
> >different
> >CPU types in the same kernel, while the assembler still checks the
> >validity
> >depending on the selected CPU type.
>
> That's come up before, and iirc Alan Modra said the support isn't there
> now for PPC and is relatively low on the priority list (but is on it).

Implemented 2003-11-22 for ppc.  Even documented.  :-)

@item .machine "string"
This directive allows you to change the machine for which code is
generated.  @code{"string"} may be any of the -m cpu selection options
(without the -m) enclosed in double quotes, @code{"push"}, or
@code{"pop"}.  @code{.machine "push"} saves the currently selected
cpu, which may be restored with @code{.machine "pop"}.

--
Alan Modra
IBM OzLabs - Linux Technology Centre

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
