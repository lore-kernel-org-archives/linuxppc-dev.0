From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Porter <porter@cox.net>
Cc: <mlan@cpu.lu>, <acurtis@onz.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI enlightenment follow-up
Date: Thu, 8 Aug 2002 10:25:41 +0200
Message-Id: <20020808082541.15450@smtp.wanadoo.fr>
In-Reply-To: <20020807153401.A20123@home.com>
References: <20020807153401.A20123@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> >> sym53c8xx: np->base2_ba = 0x07ffc000
>> >> /* 1-to-1 BAT mapping */
>> >> sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)
>> >
>> >This looks good indeed.
>
>Except he's got the 1:1 BAT in the middle of default user task space.
>Unless he's used an advanced kernel option tweak to shrink TASK_SIZE,
>this will cause problems.

Good spot. Well... I hate those BATs used to map IOs, they just
confuse things a bit more. I've gotten rid of them on pmac
for a long time.

>> >> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
>> >> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
>> >> sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0)
>> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >Nope, reversed address. That will not work. Don't touch the address,
>> >touch the data if necessary. What needs to be swapped is data going
>> >_over_ the little-endian PCI bus. Addreses don't go _over_ the bus, they
>> >address resources _on_ the bus.
>>
>> Sure of that ? First let's look at what the driver actually does in that
>> routine. I know that the NCR chips are have bus-masterers ;)
>
>This is definitely correct. The script engine expects everything little
>endian and so on a BE system you see it defined as cpu_to_le32.
>
>It still feels like an address translation issue despite things
>looking good from the data we have.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
