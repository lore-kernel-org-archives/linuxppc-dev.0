Message-ID: <3A37DC1E.28164741@mvista.com>
Date: Wed, 13 Dec 2000 15:29:18 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Hao Li <hli@wag.caltech.edu>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: vxhack and mvista kernel
References: <20001213121231.A26159@onetta.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hao Li wrote:

> % ./vxhack vmlinuz-sbc8260-2.4.0-test2-1.2.2-3
> Segmentation fault
>
> Could someone explain to me what the problem is?

The vxhack program has hard coded values for known sections in the
image file.  For some reason, the sections in the file have changed
since I wrote the program.

There is a loop:
	for (i=0; i<nsscns; i++) .......

in the program.  Add some code to print out the section number and
section size.  It will be obvious which section is the image, and
change the 'if (i == 5)' (or whatever the number is in the code you
have) in that loop to correspond to this number.  You can't use
objdump because the header numbers it prints do not match what you
find when you scan the file like vxhack does.

If you want to update the program to read the string/symbol tables
and to automatically locate sections by name, it would be useful.
This was just a quick five minute program to solve an immediate problem,
not something worth useful time.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
