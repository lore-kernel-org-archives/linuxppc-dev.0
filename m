Message-Id: <200006262005.WAA00763@piglet.grunz.lu>
Date: Mon, 26 Jun 2000 22:04:58 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: ide_delay_50ms() freezing on PPC?
To: andre@linux-ide.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10006252228210.22378-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Andre,

On  25 Jun, this message from Andre Hedrick echoed through cyberspace:
> Then we need braoder stubs.
> Got a suggestion?

No... before suggesting anything, I'd like to understand why the loop
doesn't work on PPC (only on PPC?), and why the use of
schedule_timeout() depends on PCMCIA ide devices....

Michel

> On Sun, 25 Jun 2000, Michel Lanners wrote:
>
>> Hi all,
>>
>> The latest 2.4.0 kernels don't boot on my machine anymore. They just
>> freeze in detecting the Promise Ultra66 IDE controller, specifically in
>> ide_delay_50ms(). Here is the code:
>>
>> void ide_delay_50ms (void)
>> {
>> #ifndef CONFIG_BLK_DEV_IDECS
>>         unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
>>         while (0 < (signed long)(timeout - jiffies));
>> #else
>>         __set_current_state(TASK_UNINTERRUPTIBLE);
>>         schedule_timeout(HZ/20);
>> #endif /* CONFIG_BLK_DEV_IDECS */
>> }
>>
>> CONFIG_BLK_DEV_IDECS is support for PCMCIA IDE devices, which is not
>> configured in my kernel. So that function hangs if using the 'manual'
>> delay. Everything is OK if I force it to use schedule_timeout(), which
>> by the way was always the case until a few kernels ago.
>>
>> So, why does the 'manual' way hang? (I suppose interrupts are not
>> disabled at this point, are they?)
>>
>> And why can we only use schedule_timeout() if compiling with
>> CONFIG_BLK_DEV_IDECS?
>>
>> Thanks
>>
>> Michel
>>
>> -------------------------------------------------------------------------
>> Michel Lanners                 |  " Read Philosophy.  Study Art.
>> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
>> L-1710 Luxembourg              |
>> email   mlan@cpu.lu            |
>> http://www.cpu.lu/~mlan        |                     Learn Always. "
>>
>
> Andre Hedrick
> The Linux ATA/IDE guy
>


-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
