Date: Mon, 18 Nov 2002 10:13:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: Cort Dougan <cort@fsmlabs.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd
Message-ID: <20021118171358.GA17957@opus.bloom.county>
References: <3DD3C747.8B7EE5CD@opensource.se> <20021114174807.GC605@opus.bloom.county> <3DD4E271.16FA374A@opensource.se> <20021115100857.H9673@duath.fsmlabs.com> <3DD8A28C.E8EABFF@opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DD8A28C.E8EABFF@opensource.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 18, 2002 at 09:19:24AM +0100, Magnus Damm wrote:
> > This would be a good opportunity to switch-over to allowing the bootloader
> > stick the initrd where it wants and just pass the physical pointer in via
> > bi_record in all cases.  It would certainly simplify these cases.
>
> So, the following registers passed to the kernel could change from
>
>  *   r3: ptr to board info data
>  *   r4: initrd_start or if no initrd then 0
>  *   r5: initrd_end - unused if r4 is 0
>  *   r6: Start of command line string
>  *   r7: End of command line string

In arch/ppc/boot, only r3 is used now, FWIW.

> to
>
>  *   r3: ptr to bi_record

Or so, yes.  Look at the archives for discussions / flamewars about
bi_records.

> If the initrd is going to be passed with the bi_record, and the command line
> already is there, then it's just the board info left. (for the 8xx anyhow)

The initrd already is, right now.  And yes, the bd_t would be passed, or
phased out, see the above mentioned discussions / flamewars.

> Or maybe there are zillions of applications booting the kernel directly
> without the bootloader..

Something _always_ loads the kernel someplace.  Call it what you will,
but the thing moving the kernel to 0 and pressing go is the bootloader.
Oh, and see the above mentioned discissions / flamewars :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
