Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 31D2B2BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 22:13:47 +1000 (EST)
Date: Tue, 21 Sep 2004 08:07:16 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040921112700.D1DF8C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409210741150.9337@dell.enoriver.com>
References: <20040921112700.D1DF8C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409210700390.9187@dell.enoriver.com> you wrote:
>>
>>> Why? As far as I understand the I2C/SPI patch has been obsolteted  by
>>> the I2C/SPI/SMC1 patch. So only the latter is needed.
>>
>> uh huh.  even though, as i've already pointed out, the code in
>> micropatch.c in *both* your source tree and the linuxppc-2.5 tree is
>> broken in that, if you applied the SMC patch, it would have (AFAICT)
>> caused a conflict because of an erroneously low value of RPBASE.
>>
>> it's a bit presumptuous to declare that a broken patch has obsoleted
>> one that actually works, don't you think?
>
> You are misinterpreting things. The patch is one thing - it  is  more
> or  less  a  black  box  suppied  with usage instructions by the chip
> manufacturer. micropatch.c is some code  in  the  Linux  kernel  that
> attempts  to  implement the instructions that come with the microcode
> patch. The fact that there may be errors in micropatch.c has  nothing
> to  do with the fact that one version of the microcode patch may have
> obsoleted other versions.
>
> These things have nothing to do with each other.

   ok, i was definitely unclear about the point i was trying to make, 
so let me rephrase.  i understand that the patch itself is independent 
from the code to copy/install it -- your point is well taken, and i 
accept that the ucode patch itself works just fine.  but, in this 
context, it's premature to say that it clearly "obsoletes" the older 
patch given that micropatch.c could never have installed it 
successfully in the first place.  in short, it could not possibly have 
been tested in the current situation.  that's all i meant.  anyone who 
took your advice and moved up to the newer patch and installed it 
would have been in for a rude awakening.

   and, besides, who's to say that the new I2C/SPI/SMC1 patch 
"obsoletes" the older I2C/SPI patch?  what if someone *wants* just the 
older relocation and has no need to move SMC1?  the older patch works. 
why shouldn't someone be allowed to choose it?  why should an older, 
simpler and proved-to-be-working patch be obsoleted by a newer, more 
complicated patch with additional functionality someone might not 
want?  why should you, or anyone else, make that decision for them?

   and, while i'm waiting for the caffeine to kick in, a more general 
observation.  i've been told, more than once, that my suggestions 
regarding applying microcode patches are not viable -- that it's "not 
that easy".  but no one seems prepared to explain exactly why.

   when i started out on this path, i asked some initial, fairly dumb 
questions.  then, after putting in the time to read the actual source 
code and the MPC850 manual, i got a much better understanding of how 
ucode patches were applied.  but there are still some mysterious 
corners that are not well documented, if they're documented at all. 
and when i ask questions about these corners, all i get is, "don't 
ask, it's all just magic, just accept it".

   in other words, the dialogue goes something like this:

me: "here's a suggestion to make ucode patches easier."
reply: "it's not that easy."
me: "why?"
reply: "we can't tell you, just take our word for it."

   i've proposed a simple, *workable* solution for selecting ucode 
patches from a short, established list.  if you don't think it will 
work, by all means, explain why, without resorting to "it's not that 
easy" or "it's just magic, don't ask."

rday
