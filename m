Subject: Re: Bizarre initrd problem on CLLF860T
To: dan@netx4.com (Dan Malek)
Date: Tue, 18 Apr 2000 17:57:04 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <38FB0DA0.DDE9098C@embeddededge.com> from "Dan Malek" at Apr 17, 2000 09:12:00 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000418075704.C3E833C970@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone,

Thanks to all your suggestions, I have found the culprit...

Dan Malek writes:
> So, what's different in your configuration?  Is this the same kernel
> and ramdisk?  Like I requested in a previous message, the the sources
> from MontaVista.  They are the most recent.

I am using the MontaVista kernel, with a few trivial local tweaks; namely the
patches I've posted here over the last few weeks. My initrd problem lies in
the CPU6 workaround in set_dec in arch/ppc/kernel/head.S, which does, err,
interesting things to the command line!:

        .globl  set_dec
set_dec:
        mfmsr   r5              /* Disable interrupts */
        li      r4,0
        ori     r4,r4,MSR_EE
        andc    r6,r5,r4
        SYNC                    /* Some chip revs need this... */
        mtmsr   r6
        SYNC
        lis     r7, cmd_line@h			###
        ori     r7, r7, cmd_line@l		###
        li      r4, 0x2c00			###
        stw     r4, 12(r7)			###
        lwz     r4, 12(r7)			###
        mtspr   22, r3          /* Update Decrementer */
        SYNC
        mtmsr   r5
        SYNC
        blr

The lines marked ### look like debug code that shouldn't have made it out to
the world. It's causing my boot command line "root=/dev/ram" to turn into
"root=/dev/ra", and triggering the initrd code that tries to remount the real
root filesystem. If you're using the CPU6 workarounds, I suggest you nuke
those lines.

Turns out I'm not going crazy after all.

Thanks again for all your suggestions,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
