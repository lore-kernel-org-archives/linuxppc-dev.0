From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15298.34193.467121.221740@cargo.ozlabs.ibm.com>
Date: Tue, 9 Oct 2001 15:05:21 +1000 (EST)
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: do we need -fPIC for X11R6 modules
In-Reply-To: <20011009005252.QEEA29786.tomts9-srv.bellnexxia.net@there>
References: <Pine.BSF.4.32.0110061833480.59459-100000@shell.unixbox.com>
	<20011009005252.QEEA29786.tomts9-srv.bellnexxia.net@there>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin B. Hendricks writes:

> Quick question.  Should we be building X11R6 modules with -fPIC?  When I
> try, the resulting modules generate lots of unresolved symbols (like
> "fixup", etc).

I assume you mean XFree86 modules?

> What exactly are X11R6 modules?  Are they shared libraries?  If so, they
> should be built using -fPIC?  If they are not shared libraries, how are
> they "loaded" and "linked" in?

No, they are ordinary object files, which get loaded and linked into
the running XFree86 server process using linker code that is included
in the XFree86 server.  That is, the server mallocs some memory, reads
in the text and data and other stuff, processes the relocations, and
puts the symbols into its internal symbol table.

That means that for code in XFree86 to call a procedure in a module,
it has to do an explicit "lookup symbol" function call to get the
address of the procedure and then an indirect function call.

So no, we don't want -fPIC.  That introduces a whole new and different
set of relocations into the object file and I would be surprised if
the XFree86 loader knew how to deal with them.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
