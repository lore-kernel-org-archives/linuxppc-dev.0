Message-ID: <XFMail.991201105013.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <m11tCut-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 01 Dec 1999 10:50:13 -0700 (MST)
From: Gary Thomas <gdt@linuxppc.org>
To: VALETTE Eric <valette@crf.canon.fr>
Subject: Re: PPC Compiler Problem?
Cc: linuxppc-dev@lists.linuxppc.org, alois_fertl@muenchen.europe.mcd.mot.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 01-Dec-99 VALETTE Eric wrote:
> 
>>>>>> "Alois" == Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com> writes:
> 
> Alois> Given the following lines of C, I'd expect that the 4th argument
> Alois> is placed into register 6 and 7. As the assembler listing tells,
> Alois> register 6 is omitted and the argument goes into r7/r8.
> 
> I indeed checked the "PowerPC Processor ABI Supplement" dated September 95
> (SVR4 PowerPC ABI) and on 3-18 I see :
> 
> For PowerPC, up to eight words are passed in general purpose registers, loaded
> sequentially into general purpose registers r3 through r10.
> 
> It is clear that this breaks the SVR4 ABI... So you can probably open a bug
> report...
> 

If you read carefully, on page 3-18 of the SYSV ABI report, for a long long
argument being placed in register 'gr':
  " if gr is even, set gr to gr+1.  Load the lower addressed word into gr and
    the higher addressed word into gr+1."

Thus, the implementation _is_ correct.  long long arguments always occupy
an odd/even pair of registers.


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
