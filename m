Message-ID: <3C3C7E23.4030309@embeddededge.com>
Date: Wed, 09 Jan 2002 12:30:11 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot ROM Responsibilities (and GDB)?
References: <20020109112508.B4902@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:


> it seems strange to make them have to know anything about details of
> assorted hardware other than to disable optional things and make very
> basic things (like RAM access) work.

Yes, and often these "optional things" are forgotten.
In the case of the 4xx, the MMU should be disabled, and the caches must
be coherent.  That is, if you copied the kernel into memory, you have to
ensure the caches are properly flushed and invalidated.  Many systems in
the past had simply disabled the caches, but more recently are discovering
the need for fast booting, so the are used.

The optional things often forgotten are to disable Ethernet controllers
or other I/O devices used to load the software.  These cause lots of
problems because of unexpected interrupts or DMA that can corrupt loaded
images.

It also helps to pass some system information to the piggyback loader that is
easily parsed into records the kernel needs.  Things like processor speeds,
memory size, MAC addresses, etc. are useful when you have them handy in the
boot rom.

Debug control registers need to be in a proper state before calling the
piggyback loader.  There has been some problems on some boards in the
past where this didn't get done.  The piggyback loader (and the kernel if
not configured for kgdb) don't mess with any of this so you can debug the
entire start up phases with a background (JTAG) debugger.  Modification of
debug control by the piggyback or kernel software would not allow this
debug to happen.

If you can properly get the piggyback loader running by placing the MMU and
caches in the proper state, everything else can be set up from there.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
