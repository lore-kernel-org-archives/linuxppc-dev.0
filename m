To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Hymod board support and related changes ... 
In-Reply-To: Message from Tom Rini <trini@kernel.crashing.org>
   of "Tue, 28 May 2002 13:19:57 MST." <20020528201957.GB5997@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 May 2002 12:07:16 +1000
Message-ID: <23587.1022638036@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 28 May 2002 13:19:57 -0700, Tom Rini <trini@kernel.crashing.org> writes:
>On Tue, May 28, 2002 at 01:18:10PM -0700, Tom Rini wrote:
>>
>> On Tue, May 28, 2002 at 03:48:35PM +1000, Murray Jensen wrote:
>>
>> > - Hymod board support
>>
>> For the m8260_gorom() call, try using spin_lock_irqsave() instead of
>> save_flags();cli() ... restore_flags();
>
>Nevermind, spoke too soon here.  But did you really need to add in what
>you did or is it just a cleanup?

I needed to add it. When I executed a "halt" on my Hymod board, at the point
where it jumped to the ROM (in my case, this is ppcboot) things went crazy -
it caught an exception and tried to print a message on the console, but it was
really wierd, with only a few of the characters legible, others being
substituted with wierd umlauts or punctuation etc. I couln't see any pattern,
but when I turned off interrupts before executing the "gorom" function it
stopped. Note that this only started happening recently, so something changed
somewhere else which caused this problem.

The idea behind this fix is "correct" anyway. We do not want to take any
exceptions once we have jumped to the boot ROM code. With the code the way it is,
it is possible for interrupts to be enabled at the time the "gorom" function is
executed.

Maybe the proper fix is for "gorom" to ensure interrupts are disabled? Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
