From: "Chris Hallinan" <clh@net1plus.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ppc_4xx-gdb and modules
Date: Mon, 22 Oct 2001 13:27:06 -0400
Message-ID: <NEBBKJPFOLJNBMFNKBIIKEDICJAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are having a problem displaying variables from a loadable module
using gdb.  The short description of the problem is this:
configuration: Linux version 2.4.2-mvista_010303, gdb version 5.0
(from MV distribution) configured as powerpc-hardhat-linux, custom
h/w platform.

In order to break/step/etc in module code using gdb, one loads the
module symbol file with an offset, determined in a number of ways,
like this:
add-sym module.o OFFSET, where offset is the module load address,
i.e. THIS_MODULE.  This tells gdb where the module ended up when
loaded with insmod.

However, when we try to access data variables (ours are located in
the initialized data section according to the output of ppc_4xx-nm),
gdb apparently uses only the OFFSET given on the add-sym command
line to evaluate the address of the variable, and does not apply the
offset of the 'text' section.  The result is garbage, essentially
the offset of the variable in the initialized data section added to
the value passed on the add-sym command, usually right in the middle
of the text (code) section.

Is this a bug in gdb, or are we using it wrong?  Is there a way to
tell gdb that this data variable is in the initialized data section,
and it must add not only the OFFSET given on the add-sym command
line, but also an offset determined by it's actual location in the
module beyond the text section?

I hope this appreviated description proves useful...

-Chris Hallinan
DS4.COM, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
