Message-ID: <3D47395D.8080805@broadon.com>
Date: Tue, 30 Jul 2002 18:11:57 -0700
From: David Blythe <blythe@broadon.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: __cli on 4xx - MSR:CE?
References: <1028054814.13540.131.camel@granite.austin.ibm.com> <3D46E96B.1020504@dslextreme.com> <20020731005244.GA27711@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Exactly.  I hacked something up (badly) to use the watchdog critical
interrupt as a low-overhead interrupt for kernel profiling including
profiling normal interrupt routines.  It would take a lot of mucking
around to support critical interrupts well, but it would be nice support
to have and should be independent of regular interrupts.  When you say
2.5 should handle it, are you suggesting someone should make it so or
asserting that it already does?

	david

David Gibson wrote:
> On Tue, Jul 30, 2002 at 12:30:51PM -0700, akuster wrote:
>
>>Hollis Blanchard wrote:
>>
>>>Shouldn't __cli on 4xx disable the MSR CE bit as well as EE?
>>>
>>>-Hollis
>>>
>>It should.  Critical interrupts are currently not enabled in the kernel
>>
>>armin
>>
>
> No, that isn't clear.
>
> As Armin says, (external) critical interrupts are not supported at the
> moment in the 4xx kernel, so at the moment this is irrelevant.
>
> However if someone ever did implement the use of critical external
> interrupts on a board, this would surely be because interrupts from
> the relevant hardwware are, well, critical, and require extremely low
> latency processing.  It therefore seems sensible that such routines
> should run even when normal interrupts are disabled.  Obvioulsy the
> critical interrupt handlers would have to be written very carefully to
> avoid interfering with interrupted code.
>
> If critical interrupts are disabled everywhere that normal interrupts
> are disabled, there seems little point in having them.
>
> I believe the interrupt handling code (head_4xx.S and entry.S) in 2.5
> should be able to cope with critical external interrupts.  When
> transferring to a critical interrupt handler critical interrupts will
> remain disabled until the handler has completed.
>
> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.
> http://www.ozlabs.org/people/dgibson
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
