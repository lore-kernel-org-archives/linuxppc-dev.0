Date: Mon, 15 Feb 1999 15:18:01 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: your mail
In-Reply-To: <19990215122301.003056@mail.mipsys.com>
Message-ID: <Pine.HPP.3.96.990215145041.5352j-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 15 Feb 1999, Benjamin Herrenschmidt wrote:

> My bootstrap is now a two-step bootstrap too, written all in asm to avoid
> relocation problems. 

Well, -m relocate is quite powerful IMHO. And I tried to write as little
assembly as possible, as you can easily guess from the 5000 lines of
PPC assembly of the x86 emulator :-)

> Since the MMU is switched off by the boostrap, I beleive those TLB
> entries won't do any harm until the kernel switches the MMU back on,
> that's it ? (I just want to make sure I fully understand). So, basically,
> I could add to my bootstrap a piece of code that invalidates all BATs and
> flush the TLB (I'll look at your preploader code for that).

No, but I need to run the bootloader mostly with MMU on to initialize the
VGA boards by emulating the VGA ROM BIOS for 2 reasons:
- having correct memeory attributes and the caches enabled,
- emulating the 1Mb of Intel Mobo (640k RAM+128k VGA+ ROM BIOS...)

I found that if I did not invalidate the TLB before starting the kernel, I
was allowed to do strange things (specifically accessing I/O space before
it was even mapped by BATs or PTE) due to stale TLB entries.  This caused
the introduction of a few bugs in some versions of my PreP initialization
code which were extremely hard to find. I even was unlucky enough to fall
on the borderline case where adding or suppressing a single debug message
in the loader cause the critical TLB entry to be valid or invalid.

Note that my code to invalidate TLB is the hammer to kill flies method: it
is guaranteed to work for all PPC (except embedded) implementations from
the architectural handbook because I don't want to rely on any system info
(too often wrong), so I invalidate 65536 TLB entries. In a bootloader, I
obviously don't care about the couple of milliseconds it takes. 

> 
> >Wrong, what is in r31 before ? You may clear unwanted MSR bits: 
> 
> You are right. I already changed this to rlwinm approx. 5 minutes after
> sending the previous mail ;-)

Ok, better like this. Unfortunately for rlwinm and friends, gas allows you
to replace the last 2 parameters by a single value (bit mask), for
example: rlwinm r3,r4,0, 0x00ffff00, but it does not work if you have the
complementary mask (ones, zeros, ones) so you can't type rlwinm
r0,r0,0,~MSR_EE. Note that gcc/egcs would generate the code with the
rlwinm instruction. Anybody wants to tweak binutils to allow this ?

	Gabriel. 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
