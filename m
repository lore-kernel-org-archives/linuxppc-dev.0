Message-ID: <29987-51510@sneakemail.com>
Date: Wed, 03 Mar 2004 12:16:03 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel hangs in early_init
References: <20040302085159.1174CC0655@atlas.denx.de> <4522-80798@sneakemail.com> <4045A8FC.1090303@ru.mvista.com>
In-Reply-To: <4045A8FC.1090303@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrei Konovalov akonovalov-at-ru.mvista.com |PPC Linux Embedded| wrote:
> Stephen Williams wrote:

>> Humm... The MMU comment makes me think. U-Boot is running with the
>> MMU off. The head_4xx.S entry code sets up a temporary MMU mapping
>> that includes the linked kernel address space, but that is only 32meg.
>> The stack at the time is still where U-Boot left it, near the end of
>> the 128Meg memory. Is this something I should address (pardon the pun)?
>>
>
> Just a suggestion. Check that the whole data cache is invalidated.
> The kernel often relies on the bootloader to initialize dcache properly.
> And there is a chance that the bootloader was written for 405GP, but
> 405GPr's data cache is two times bigger.

BINGO!

I am using U-Boot, and in my JSE.h I had mis-set the CFG_DCACHE_SIZE
to 8K, as it was copied from another config file that I used as a
starting point. U-Boot does some cache management, but obviously
made a mess when it was told the wrong thing:-)

I set it properly, and I'm farther along.
--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
