Message-ID: <408788E5.4020602@246tNt.com>
Date: Thu, 22 Apr 2004 10:57:09 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about process/kernel address space
References: <1082616231.4760.14.camel@lucy.pep-kaufbeuren.de>
In-Reply-To: <1082616231.4760.14.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nickl wrote:

>Hi,
>
>in some elderly code for a VME-supporting 824x-board from
>our company I found the following line in ppc_md.setup_io_mappings():
>
>io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
>
>This is obviously meant to map a window of VME IO memory into
>virtual address space. What puzzles me is that the mapping is
>located below PAGE_OFFSET (0xc0000000), which, from my general
>understanding, is bad :(
>
>
>But since apparently nobody had a problem with this for years,
>(and ranges above PAGE_OFFSET are tight) I'd like to know what
>the actual implications are.
>Ok, should a process ever access this range, it would fail
>(since the BATs go first and allow only supervisor access(?)),
>but a user process ever using such a high address seems highly unlikely.
>
>
>
On my PPC kernel, TASK_SIZE is 0x80000000, so that should be OK. ( linux
2.6.5 )
I think the area between TASK_SIZE and PAGE_OFFSET can also be used to
map stuff as long as you take care not to map two things at the same
place. IIRC, in ARM, the modules are loaded in that space, but I don't
know for PPC.


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
