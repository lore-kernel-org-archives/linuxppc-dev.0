From: jlquinn@us.ibm.com
To: Dan Malek <dan@netx4.com>
cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <852568D6.00723A5D.00@D51MTA03.pok.ibm.com>
Date: Fri, 5 May 2000 16:47:43 -0400
Subject: Re: Help with cross-endian bitfields?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The data is read from the device as a complete byte, so that aspect is OK.
However, the byte contains multiple pieces of information that can be
conveniently accessed using bitfields.  It's less convenient to write
macros that mask and shift the appropriate piece, although it will be
obviously portable.

Jerry


Dan Malek <dan@netx4.com>@lists.linuxppc.org on 05/05/2000 04:05:52 PM




jlquinn@us.ibm.com wrote:

> Hi, all.  I'm working on getting the Advansys driver working and what
> appears to be the final stumbling block is a difference in the layout of
> bitfields between little-endian and big-endian systems.

IMHO, bit fields are not normally a good thing to be using if this is
describing a real device register.  The compiler is able to read/write
in ways that may not be proper for hardware access.  For device registers
and when this is a data structure in memory, the cross-platform method
of using macros for reading writing 16- and 32-bit values and then 'C'
operators for testing/setting bits has worked pretty well in the past.....


     -- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
