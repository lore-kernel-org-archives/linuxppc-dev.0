Date: Wed, 29 Nov 2000 19:50:14 +0200 (EET)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Rainer Kloud <rainer.kloud@siemens.at>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading a elf binary
In-Reply-To: <3A1BECC8.DB736163@siemens.at>
Message-ID: <Pine.GSO.4.30.0011291946240.29386-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 22 Nov 2000, Rainer Kloud wrote:

>(mapped) correctly into the RAM. But in the further process of loading
>the
>binary (search_binary_handler and load_elf_binary) I can't find the
>place
>where the rest of the binary is loaded?!
>(the correct loaded part of the executable resides from 0xc0252000 to
>0xc0252fff in the kernel and from 0x10000000 to 0x10000fff in user
>space)
>
>When then the kernel executes the binary, everything works correct
>until the first executed instruction is outside of the first page (4k)
>of the executable.
>Then the processor will load a wrong instruction which results at the
>end in a page fault.

Rainer,
I think the thing here you described, could be the ultimate symptom for us
Sandpoint owners. The problem was and is, more or less, that when the
kernel tries to run /sbin/init at the startup time, it always results in a
kernel oops with illegal instructions. Then, if it is so, why the heck
doesn't the CPU execute the right instructions when running out from the 4K
boundary??? There's something in the sandpoints that sucks big time.

OK, so I don't have a JTAG debugger, so I can't tell you exact details, but
I'll try to do some hacking with a KGDB in the meantime...

BTW, I have a PPC7400 (it's a sandpoint with the Altimus board)

 -topi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
