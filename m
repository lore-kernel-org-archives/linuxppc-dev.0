Return-Path: <annamaya@yahoo.com>
Received: from web53803.mail.yahoo.com (web53803.mail.yahoo.com
	[206.190.36.198]) by ozlabs.org (Postfix) with SMTP id 08A412BDB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 04:38:30 +1000 (EST)
Message-ID: <20041011183828.93046.qmail@web53803.mail.yahoo.com>
Date: Mon, 11 Oct 2004 11:38:28 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041011181553.GC6871@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Oops! Thanks for pointing that blooper. I am so used
to dealing with the U-Boot header of 64 bytes that I
misread the ELF header size as 64 bytes instead of 64
KBytes. 

Anyways, it looks like I am much farther that I have
ever been before. Now, I see that the PC is stuck at
some address that I am not sure what to make off. Is
this before the MMU has been turned on? Also, it looks
like my BDI is not showing the "Debug entry cause"
correctly.

BDI>info
    Target CPU        : MPC8280/8220/5200 (Zeppo)
    Target state      : debug mode
    Debug entry cause : <reserved 0>
    Current PC        : 0x00401890
    Current CR        : 0x20002024
    Current MSR       : 0x00002040
    Current LR        : 0x0040084c

I am not sure how I can map this address to some
address in the kernel. Could this be due to the
unavailability of bdinfo? Do I have to put in support
in the kernel to pass bdinfo? Thanks much.

--- Tom Rini <trini@kernel.crashing.org> wrote:

> On Mon, Oct 11, 2004 at 10:50:54AM -0700, annamaya
> wrote:
> 
> > I loaded a zImage into address 0x100000 in RAM and
> > verified that this was indeed an ELF file. I then
> said
> > "go 0x100040" which would start executing the code
> > after skipping the 64 bytes of ELF header. But
> this is
> > what I see happen. 
> 
> It's 64Kilobytes, so you'd want 0x00110000.  You
> also might be loading
> yourself a bit too low.  The default link address is
> (assuming this is
> 2.4 and I'm still recalling right) 0x00200000, so
> you might as well load
> things there.
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
