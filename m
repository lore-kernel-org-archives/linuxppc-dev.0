Date: Mon, 7 Jun 2004 17:45:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newest "bk pull" of 8xx tree still builds a kernel that hangs
Message-ID: <20040608004537.GB14242@smtp.west.cox.net>
References: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain> <20040607200811.GD12823@smtp.west.cox.net> <Pine.LNX.4.58.0406071950460.3449@localhost.localdomain> <20040608002527.GA14242@smtp.west.cox.net> <Pine.LNX.4.58.0406072026220.15060@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0406072026220.15060@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 07, 2004 at 08:28:26PM -0400, Robert P. J. Day wrote:

>
>
> On Mon, 7 Jun 2004, Tom Rini wrote:
>
> ...
> > I haven't had time to look into this yet, in part because I just don't
> > know how well to trust my h/w, but to get SMC1 console working (RPX
> > Lite) I need to enable both SCC1 and SMC1.  For your board, I would
> > recommend enabling all of the consoles.
>
> ok, i just turned them all on, it's compiling as we speak.  i'll let you
> know what happens.  my .config file now looks like (in part):
>
> ...
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> ...
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> ...
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_CPM=y
> CONFIG_SERIAL_CPM_CONSOLE=y
> CONFIG_SERIAL_CPM_SCC1=y
> CONFIG_SERIAL_CPM_SCC2=y
> CONFIG_SERIAL_CPM_SCC3=y
> CONFIG_SERIAL_CPM_SCC4=y
> CONFIG_SERIAL_CPM_SMC1=y
> CONFIG_SERIAL_CPM_SMC2=y
> CONFIG_UNIX98_PTYS=y

Then don't forget a console=ttySX (or ttyCPMX) if you have CONFIG_VT
set.  This early on, I'd turn off 8250 myself (and VT and INPUT).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
