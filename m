In-Reply-To: <20040312045451.GA25876@gate.ebshome.net>
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com> <20040312030502.GA25644@gate.ebshome.net> <24019-11838@sneakemail.com> <20040312045451.GA25876@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	Stephen Williams <612dlag102@sneakemail.com>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
Date: Fri, 12 Mar 2004 08:25:23 -0600
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Look in u-boot.  They have some user commands that allow
reading/writing dcr's.  These commands are written with self modifying
code, I would recommend that we reuse that.

Also, it begs the question of should this be extended to SPRs, not that
I have come across a case with SPRs that I need to iterate over a large
list.

- kumar

On Mar 11, 2004, at 10:54 PM, Eugene Surovegin wrote:

>
> On Thu, Mar 11, 2004 at 08:44:09PM -0800, Stephen Williams wrote:
>>>> I think you should just write it as self modifying code :-)
>>>> Write the instruction with the DCR number and just execute it.
>>>
>>>
>>> And deal with locking and icache/dcache coherency ?
>>>
>>> No, thanks :)
>>
>>
>> Actually, I recall that there is a code fixup mechanism that
>> is invoked early in kernel init that does exactly that: it
>> manages some machine specific differences by editing the code
>> in place in a safe way.
>
> Yes, you are correct, but this is done only once during startup and
> nobody cares how fast it is. BTW, there is no locking issues at this
> stage.
>
> I'm not saying that it's impossible :). It's just not very efficient
> to do such stuff on run-time (lock a spinlock, change memory, dcache
> flush, icache invalidate, isync...)
>
> Eugene.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
