Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: get program exception in early setup
Date: Mon, 28 Apr 2003 18:26:59 -0400
Message-ID: <EGEGIJHKDKJGAJMGIDPNIEINCLAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <EGEGIJHKDKJGAJMGIDPNKEEBCJAA.jwalden@digitalatlantic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I just built a brand new kernel(2.4.18) for the PPC 405Gp, and I discovered
something that does
not make sense to me.

In setup.c / early_setup:

	/* First zero the BSS -- use memset, some arches don't have
	 * caches on yet */
	memset_io(PTRRELOC(&__bss_start), 0, &_end - &__bss_start);


>From System.map:

c0113000 A __bss_start
c0113000 A __chrp_begin
c0113000 A __chrp_end
c0113000 A __init_end
c0113000 A __openfirmware_begin
c0113000 A __openfirmware_end
c0113000 A __pmac_begin
c0113000 A __pmac_end
c0113000 A __prep_begin
c0113000 A __prep_end
     |
     |
     |
     V
c013bc40 B ipv4_config
c013bc4c B unix_socket_table
c013c050 A _end

The symbol _end does not come after the bss - it is at the end of the
kernel, so the memset gets an exception.

It also looks like there is no _bss at all -

Help?
Do I hack the heck out of the file, or is there a better way?


I did a:

make mrproper
make dep
make pImage

Thanks

Jerry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
