Date: Tue, 20 Apr 1999 22:43:24 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Current egcs, binutils and kernel (fwd) 
In-Reply-To: <9904201705.AA28388@marc.watson.ibm.com>
Message-ID: <Pine.HPP.3.96.990420223651.20020P-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 20 Apr 1999, David Edelsohn wrote:

> 
> 	The original POWER architecture with the MQ register allowed a
> short sequence to provide this 64-bit functionality.  The PowerPC
> instruction set does not provide the necessary building blocks, so GCC
> falls back to the C implementation in libgcc2.c producing the assembly
> code shown in the later posting.

Yes, but the kernel is not linked with libgcc2. Anyway I've posted a patch
to correctly implement this. And then I've noticed just after that people
do more work than necessary in the cvt_df and cvt_fd routines: floating
point loads and stores never affect or depend on the FPSCR contents, so
there is no point at all in manipulating it (except adding bloat for the
sake of adding bloat).

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
