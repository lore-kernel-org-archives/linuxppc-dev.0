Message-ID: <001901c0d7b5$426f0b80$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Zehetbauer Thomas" <TZ@link.topcall.co.at>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <41EA756DBC9FD0118CFC0020AFDB5C5A188DC9@tcint1ntsrv>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Date: Tue, 8 May 2001 19:51:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I stumbled into the same problem a while ago.
>
> While I did not use a hardware debugger I used the sample demonstrating
> serial output to find that the Montavista kernel stops at the rfi
> instruction which is used to simultanoeusly turn on instruction and data
> address translation and to set the instruction pointer to the (remapped)
> start_here label. Unfortunately I lost my PPC hardware (405GP Walnut
> board) before I could find any solution.

Yes, this is also exactly what i meet now.
I find that "turn_on_mmu" use SYNC as following:
turn_on_mmu:
    .....
    SYNC
    RFI

here SYNC may do nothing according to your .config(CONFIG_PPC601_SYNC_FIX)
if you look into arch/ppc/kernel/ppc_asm.h.
Will this be a problem? I use linux-2.4.2 .

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
