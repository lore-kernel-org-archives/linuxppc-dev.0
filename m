From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Use of several CFI flash chips physically mapped in memory 
Date: Thu, 4 Dec 2003 11:12:24 +0100
Message-ID: <000001c3ba4f$214be2f0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20031203181613.75859C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I work on a custom 8250 board with a 2.4.18 Linux kernel.
This board provides two AMD CFI flash devices.

Nowaday I only use the first chip which I map in the physical memory.
I create several partitions with RW or RO accesses and I use
CRAMFS and/or JFFS2 images. This works fine.

Now I would want to use the following functionalities :

1) I want to protect the first partition of the first device
that contains a firmware which does not belong to the Linux system.
Can I mislead Linux and provide the first sector address after
the firware as the start address of the device. I don't know
how the gen_probe process will react. So as Linux does not know
the firware space and it can't erase the firmware sectors.

2) I want to use the two devices as a virtual one with many
partitions splitted at will. The two chips are physically mapped in
sequence. In my kernel, I have the following variables
CONFIG_ELINOS_NR_MTD_DEVICES "Maximum number of MTD devices" and
CONFIG_MTD_CONCAT MTD "Concatenating support". But they seem to be unused.

3) I want to use two 16 bits access chips physically mounted in parallel
to make a virtual 32 bits access chip. Do solutions exist for this case ?

4) Finally, what about flash fast programming issues ?
Nowaday it is very slow to erase or program many sectors with
the character access driver.
In my kernel, I have the following message
if (cfi->fast_prog) {
    /* In cfi_amdstd_write() we frob the protection stuff
       without paying any attention to the state machine.
       This upsets in-progress erases. So we turn this flag
       off for now till the code gets fixed. */
    printk(KERN_NOTICE "cfi_cmdset_0002: Disabling fast programming due to c
ode brokenness.\n");
    cfi->fast_prog = 0;
}

Thanks
Special thanks to Gary Thomas for his reply about File system boot strategy.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
