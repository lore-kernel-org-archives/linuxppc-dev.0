From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Sat, 6 Apr 2002 23:52:36 +0100
Message-Id: <20020406225236.3768@smtp.wanadoo.fr>
In-Reply-To: <0204062139.AA17200@ivan.Harhan.ORG>
References: <0204062139.AA17200@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I haven't look at the patch yet, but is my understanding correct that
>> you have individual config options enabling the various board support
>> and that you allow more than one to be selected at one time ?
>
>Yes.
>
>> If that is the case, then that's great. It's also what the arm ach does
>> and I like it.

Hi Paul !

I've looked at the patch in the meantime and it makes much sense. I want
to do something around those lines:

 - Completely rip off CONFIG_ALL_PPC in favor of CONFIG_GENERIC_PPC32
 - Each board model has it's own CONFIG_xxx entry (like Michael patch),
   which means adding "back" CONFIG_PMAC, CONFIG_CHRP, CONFIG_PREP, but
   those will only control which set of .c file will get in the makefile
   and the toplevel switch/case on platform_init. That is you will be able
   to select an arbitrary set of boards.
 - bi_recs are found in r4 when r3 contains "birc" (please, Michael, adapt
   to this so we stay consistent which what BootX does). Older way of finding
   them & cmdline & initrd still used when r3 doesn't contain that magic
   value. r5 still contains the OF PROM pointer, at least until we have
   the OF interface in a wrapper.

I think this patch will not be that invasive, and it will be fully backward
compatible, so I do intend to push it to _2_4_devel though I want your
ack first. I don't plan to include Michael boards in it, I want to rework
our ground to match what Michael does and then let him drop in his new
boards.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
