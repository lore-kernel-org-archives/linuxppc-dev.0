Date: Sat, 13 Feb 1999 18:50:09 +0100
To: Paul Mackerras <paulus@cs.anu.edu.au>,
        Cort Dougan <cort@ladron.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Message-Id: <19990213185009.020602@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I would like your point of view about the following:

The kernel entry code starts playing with BATs as soon as it is entered.
Isn't that dangerous ? I mean, you must have enough luck for this BAT not
to be used at this specific time, or not overlapping another BAT setup by
MacOS (overlapping BATs causes undefined behaviour according to the PPC
manual) ?

I have made a test bootx that I'll upload to
ftp.linuxppc.org/developement/users/benh later today (the archive will
probably be called BootX_phys_test.sit). This version of BootX doesn't
jump directly to the kernel but goes to a small piece of PPC asm that
will cause the kernel to be entered with MMU (and interrupts) disabled. I
beleive this should get rid of potential problems with TLB misses during
boot too. Of course, all addresses passed to the kernel are turned into
physical addresses (frame buffer, stack, boot_infos).

This version works on my desktop G3, I didn't have time to test it on
other machines yet.
The bootstrap code is simple (it's entered with the same parameters as
the kernel, but with physical addresses and with the kernel physical
entry in r6) :

    /* switch interrupts off */
    mfmsr   r0;
    ori     r31,r31,MSR_EE;
    andc    r0,r0,r31;
    sync;
    mtmsr   r0;
    sync;

    /* put kernel entry (phys) in ssr0 */
    mtspr   SSR0, r6;

    /* Setup ssr1 (kernel entry MSR) */
    ori     r31,r31,(MSR_IR|MSR_DR);
    andc    r0,r0,r31;
    mtspr   SSR1, r0;

    /* Branch to the kernel */
    rfi;

Note: I wrote this little piece of asm with CodeWarrior. Since I would
like to make a C boostrap that takes place between this and the kernel, I
still need to figure out how to build code for this with egcs. If I could
find the correct MakeFile options to get an output like prom.c
(PC-relative branches, datas accessed thru a RELOC macro), I think it
would be just fine. A better approach would be to store datas relative to
a register that I can setup before entering the boostrap, but that means
parsing enough of the ELF to extract the offset of the datas. I would
appreciate if someone could give me some tips about what is usually done
in those cases or some pointers to infos/samples.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
