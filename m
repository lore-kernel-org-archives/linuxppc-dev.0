From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15985.793.339541.402592@nanango.paulus.ozlabs.org>
Date: Fri, 14 Mar 2003 09:15:53 +1100 (EST)
To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: accessing immap_t * variable in mpc8260
In-Reply-To: <3E70A2C3.8090305@tataelxsi.co.in>
References: <3E70A2C3.8090305@tataelxsi.co.in>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Omanakuttan writes:

> In FCC code, eldk/ppc_82xx/usr/src/linux/arch/ppc/8260_io/fcc_enet.c,
> immap_t * immap is simply typecasted to IMAP_ADDR, which is
> ((uint)0xf0000000).
> Now, after assigning this physical address, fcc_enet code continues the
> immap_t variable without doing any __va macro.

The __va macro is only applicable to addresses in system RAM.  If you
are using "HIGHMEM" support (unlikely on an 82xx) you can only use
__va on "low" memory addresses, i.e. those that are mapped
contiguously starting at KERNELBASE.

> I am confused at this point, that how can kernel code access a physical
> address as if it were virtual address ? how does the page frame -> page
> conversion (and vice versa) happens on this front?

The 8xx and 82xx ports map several things at the same virtual address
as their physical address.  That simplifies some things but has the
disadvantage that it tends to clutter up the kernel virtual address
space.  If you have no more than 512MB of RAM or so, that isn't a big
problem.  On powermac/CHRP/PReP machines we no longer map anything at
fixed virtual addresses, because those machines can have a gigabyte or
more of RAM.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
