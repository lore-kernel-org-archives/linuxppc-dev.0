Message-ID: <40C6F3C0.8010208@fh-landshut.de>
Date: Wed, 09 Jun 2004 13:25:52 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VME driver patch for PowerPC
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com> <40C48A1C.30602@fh-landshut.de>
In-Reply-To: <40C48A1C.30602@fh-landshut.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I tried dereferencing the pointer in kernel space like this:

unsigned long int *virtaddr = 0;

// [...]

// After the Universe register were written in
// __create_master_window()
virtaddr = ioremap_nocache(window->phys_base, window->size);
printk(KERN_INFO "Dereferenced pointer 0x%08X.\n", *virtaddr);


Guess what that produced: A single-beat transaction producing the date within
the expected time constraints without a cache burst or any other "bad stuff".

So kernel space pages are fine, correctly set to cache-inhibited and guarded (no
reordering of accesses).

The culprit could be the vme_mmap_phys() function, because it introduces another
mapping of pages, and with mmap you cannot control caching behaviour.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
