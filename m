Message-ID: <3F03158B.7090706@mvista.com>
Date: Wed, 02 Jul 2003 10:25:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Michael J. Accetta" <mja@laurelnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc755, sandpoint port and 1Gb of ram
References: <31237.1057112468@mja-pc-linux.dhcp.pit.laurelnetworks.com>
In-Reply-To: <31237.1057112468@mja-pc-linux.dhcp.pit.laurelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael J. Accetta wrote:

>Hello all,
>
>We have a custom board built around the mpc755 and patterned after the
>Sandpoint reference design using the MontaVista Pro 3.0 distribution.
>This is a base 2.4.18 kernel which, according to the MV web, page includes the
>2.4.17 linuxppc code.  When 1Gb ram is used, CONFIG_HIGHMEM is required
>to access the top 256Mb.  However, the sandpoint port does
>
>   io_block_mapping(0xfe000000, 0xfe000000, 0x02000000, _PAGE_IO);
>
>whichs maps all of virtual 0xfexxxxxx to physical 0xfexxxxxx.  This call
>ends up using BAT#0 to map the entire block.  However, the CONFIG_HIGHMEM
>support in the base ppc port sets PKMAP_BASE to 0xfe000000 and expects
>these virtual addresses to be available for dynamic mapping via kmap()
>of high memory.  The conflicting mapping in the BAT takes precedence,
>wreaking havoc with any accesses to high memory.  In our case NFS mounts
>of the root file system was the first high memory user and init could
>not be found.
>
>I've made a stab at fixing this by configuring PKMAP_BASE down to 0xfc000000
>and things now seem to work fine.  Is this a correct solution?  Are there
>likely to be any negative side effects of this approach?  Are there
>better solutions?
>
>
>
You have basically 2 choices:

a) change the mapping such that the io_block_mapping doesn't cover the
default PKMAP_BASE area
b) change PKMAP_BASE--which is what you did--however, if you didn't, you
should use the config facility that allows you to do this (look at 'Code
maturity level options'/'Prompt for advanced kernel configuration options').

Its probably just a personal preference but I think changing the mapping
and leaving PKMAP_BASE alone is a better way.  Someday I will do that
for the sandpoint port.

In short, what you did, assuming you did it properly, should work fine.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
