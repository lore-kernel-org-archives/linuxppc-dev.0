Date: Wed, 12 Jan 2000 10:31:45 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jesper Skov <jskov@cygnus.co.uk>
cc: iweiny@pacbell.net, linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: User level Macros for Endianess
In-Reply-To: <othfgj64ew.fsf@thinktwice.zoftcorp.dk>
Message-ID: <Pine.HPX.4.10.10001121021250.20852-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 12 Jan 2000, Jesper Skov wrote:

> #include <asm/byteorder.h>
> 
> then use __le32_to_cpu and friends (see
> /usr/include/linux/byteorder/generic.h)
> 
> I'm not sure if that's the Proper Way(TM) to do it from user land
> though.

No, it's very different between application and kernel code (unfortunately
since this forced me to write 2 very different vme.h include files for VME
systems, it's not only a simple cp). Under Linux, asm/byteorder.h is the
right way to get the correct macros, and either LITTLE_ENDIAN or
BIG_ENDIAN is defined.

>From userland both are defined and then BYTE_ORDER is set to one of these
(strange architecture might even have a byte order which is neither like
the PDP) so the check is #if __BYTE_ORDER==__BIG_ENDIAN ...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
