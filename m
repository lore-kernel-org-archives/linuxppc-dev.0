From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup 
In-reply-to: Your message of "Sun, 26 Aug 2001 21:54:36 MST."
             <20010826215436.H1481@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 15:10:21 +1000
Message-ID: <23104.998889021@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Aug 2001 21:54:36 -0700,
Tom Rini <trini@kernel.crashing.org> wrote:
>I guess I should go get some sleep now... __archdata is 8 not 0, but the
>last section I see (insmod -nm ./r128.o > r128.out) is the .bss...

There is no __insmod_modname_S symbol for __archdata.  Use
  insmod -nm -O blob ./r128.o
so insmod writes the binary object to blob.  Because it also uses -n,
the address starts at an arbitrary 0x12340000.  Get the address of
__archdata from the start of the map, and
  objdump -b binary -s --adjust-vma=0x12340000 --start-addr=0x1234xxxx blob
0x1234xxxx is the start address of __archdata.  Alas if __archdata is
all zeroes, objdump dumps nothing, you might have to use a lower start
address to see an all zero section.  However __archdata should not be
zeroes, if it exists.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
