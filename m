Date: Fri, 21 May 2004 12:50:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 CPM DP ram free function
Message-ID: <20040521195055.GJ6763@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DADF@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DADF@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 21, 2004 at 02:34:08PM -0500, Rune Torgersen wrote:

>
> > First, when this has come up in the past, the first question
> > is why is this useful, given that with the hardware and
> > peripherals in question, loadable drivers aren't really
> > useful (and don't shoot the messenger please).
>
> Right now I mainly use it to debug a driver, which would run out of host
> ram when I reloaded it
>
> > Second, you removed the EXPORT_SYMBOL for the old alloc, but
> > I didn't see quickly how a module would make use of the new
> > infrastructure since there weren't any new EXPORT_SYMBOLs.
>
> This is because I did my patch against 2.6.5, and all the EXPORT sympols
> are in arch/ppc/kernel/ppc_ksyms.c
> and not in commprocs.c
>
> In ppc_ksyms.c I have:
> extern uint m8260_cpm_dpalloc(uint size, uint align);
> extern uint m8260_cpm_hostalloc(uint size, uint align);
> extern uint m8260_cpm_hostfree(uint ptr);
> extern uint m8260_cpm_dpfree(uint ptr);
>
> EXPORT_SYMBOL(m8260_cpm_dpalloc);
> EXPORT_SYMBOL(m8260_cpm_hostalloc);
> EXPORT_SYMBOL(m8260_cpm_dpfree);
> EXPORT_SYMBOL(m8260_cpm_hostfree);

Er?  Aren't dpfree/hostfree new functions?  I didn't see them added as
exports in your patch, and regardless they belong in comproc.c now.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
