Message-ID: <3C1A3814.3020701@gatekeeper.informatik.fh-dortmund.de>
Date: Fri, 14 Dec 2001 18:34:12 +0100
From: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre8-ben0: kernel oops using pcmcia services
References: <3C1A299D.8090402@gatekeeper.informatik.fh-dortmund.de> <20011214163939.1291@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It works ! Thanks Ben !! ;)

Ralf

Benjamin Herrenschmidt wrote:

> First make sure the memory resources you use are available
> in /proc/iomem
>
>
>>include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
>>
>
> Those should be ok
>
>
>>include memory 0xc0000-0xfffff
>>
>
> This one is wrong (this is in the middle of RAM !)
>
>
>>include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff
>>
>
> Hrm...  the second one is wrong at least.
>
> try
>
> include memory 0xa1000000-0xa1ffffff, I think this one is available
> on your machine.
>
>
>># First built-in serial port
>>exclude irq 4
>># Second built-in serial port
>>#exclude irq 3
>># First built-in parallel port
>>exclude irq 7
>>
>
> Remove the above exclude, they don't make sense on pmacs
>
> Ben.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
