Message-ID: <3A9576FC.6F4B1FAB@mvista.com>
Date: Thu, 22 Feb 2001 15:30:52 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: "tsombakos, mark" <tsombakos_mark@emc.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Booting Sandpoint 8240??
References: <276737EB1EC5D311AB950090273BEFDD01F4DB3F@elway.lss.emc.com> <20010222083031.A21599@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> You don't need to do a thing, all is well. :)

Ummmm....I think this should work, but those addresses weren't my
original intention.  The original "design" was to use 0x00800000
as the link address, and 0x00900000 as the load address.  The code
will copy itself down to the 8 Meg location, then uncompress as you
describe.  I don't know if this is still the case, but the uncompress
code used to make some assumptions (take some liberties) about using
the space between the load address and execute address for temporary
storage.  If you load below the execute address, this address
arithmetic is screwed up and I'm not sure what would happen.

With the 2.4 kernel you have to allow almost 1.5 Mbytes of space
from the start of RAM for the kernel to do its work, and not write
over some boot information (command line or initrd info) that the
initial bootloader may have dropped into magical memory locations.
Trying to run a bootloader under the 2M boundary is risky, and it
won't run in under the 1.5 M boundary.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
