MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16161.42260.92733.393949@cargo.ozlabs.ibm.com>
Date: Fri, 25 Jul 2003 17:45:56 -0400
From: Paul Mackerras <paulus@samba.org>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IO, ANSI vs GCC structs
In-Reply-To: <20030725134734.J29161@borg.org>
References: <Pine.LNX.4.44.0307251038370.22864-100000@spider.ancor.com>
	<20030725161940.41FDEC602D@atlas.denx.de>
	<20030725134734.J29161@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg writes:

> How important is it to the kernel coding style that hardware be
> accessed through a structure?  Is it acceptable to do:
>
>   #define MYHW  (MY_MBAR+42)
>
>   ...
>
>   out_be32(MYHW, 0xco1df00d);

Hmmm.  You should be using a value returned from ioremap() (or
equivalent) rather than a hard-coded constant.  Yes I know that people
set up 1-1 mappings with io_block_mapping and then do out_be32 to
hard-coded constant addresses but that is deprecated.

My preference is to define the offsets for individual registers as
constants rather than using a structure.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
