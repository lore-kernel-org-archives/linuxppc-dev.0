Date: Wed, 27 Sep 2000 10:22:55 -0700
Subject: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
From: "Jon Erick Ween" <jween@som.llu.edu>
To: <linuxppc-dev@lists.linuxppc.org>
CC: <schmitz@opal.biophys.uni-duesseldorf.de>
Message-ID: <B5F77AFE.62A%jween@som.llu.edu>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Can anyone tell me if there are any problems with overlapping memory
>> assignments for the ATY Mach64 chip on a Lombard PB? I'm having trouble
>> getting my 4.0.1 Xserver to detect the device although the system seems to
>> detect the chip alright at bootup. I've been through the Xpert list at
>> XFree86 and we've groud to a halt.

>With a 2.2 kernel:
>You need to use yaboot, or fix up the overlapping PCI resources allocated
>by OF or MacOS yourself when using BootX. I've posted a diff to
>debian-powerpc that  remaps the MMIO region outside the VRAM region,
>without any sanity checks to make sure that region hadn't been mapped
>previously. It's a hack, and won't ever make it into the official kernel.
>
>With 2.3:
>Use Geert's PCI resource allocation patch, posted here a couple of months
>back. Might be in 2.4.0pre already. Or, again, use yaboot.

>BTW: in my case, the X server had no problem _detecting_ the chip, but
>helpfully removed the PCI mapping for the VRAM region. The resulting
>invalid access to MMIO registers aliased at the end of the VRAM region
>(that's where atyfb puts them) crashed the kernel hard. If you get away
>without a kernel crash, your problem might be different. Using yaboot
>instead of BootX is a good idea nonetheless.

OK, I've switched from BootX to Yboot using a stable 2.2.17 kernel and the
most recent XF86-4.0.1 and ati driver sources I can find. I seem to get
different PCI assignments to the ATI chip on boot-up (looking at dmesg
compared with using BootX) but the X-server still doesn't detect the chip
with "startx" or "XFree86" and exits with a "device not found" and "no
screens" error. Any further suggestions?

Thanks

Jon

--
Jon Erik Ween, MD

Cognitive and Cerebrovascular Neurology

Assistant Professor
Loma Linda University School of Medicine

Director, Stroke Program
Loma Linda University Medical Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
