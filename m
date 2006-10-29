Return-Path: <ssshayagriva@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 4C14967CAC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Oct 2006 18:59:16 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id x4so1696604nfb
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Oct 2006 00:59:14 -0700 (PDT)
Message-ID: <513a5e60610290059o34fc8a1aod0e757c0fc806be@mail.gmail.com>
Date: Sun, 29 Oct 2006 01:59:14 -0600
From: "Madhu Saravana Sibi Govindan" <ssshayagriva@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: External Bus on 440GP
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I have a question about linux on 440gp and a custom board.

We use the Universal boot-loader, U-boot, to initialize the board and
then, boot linux. The flash chip on the board is 4 MB in size.

I'm trying to access the flash chip (attached to the External Bus
Interface) in a custom device driver running in linux.  The behavior
I'm seeing is this: when the EBC0_B0CR (Bank Configuration register 0)
is set to 0xffc5800 (Base address: 0xffc, size = 4 MB, usage: RW and
width = 8 bits) and when do an ioremap64 to map the physical space of
the flash chip into the virtual address, all accesses to the flash chip
are successful.  Please note that the virtual address returned by
ioremap64 is different from
0xffc00000.

But, when I do an ioremap first and use the virtual address (the most
significant 12  bits) to program the EBC0_B0CR, all accesses to the
flash chip result in a timeout error on the bus.
The IBM 440GP documentation clearly says that the bits in the EBC0_B0CR
is used to enable the correct chip select signal. Why am I seeing the
above behavior?

I'm actually trying to access a custom chip on the EBI bus using the
same method. I got the same error, so I tried the flash chip....

I'd be thankful if someone could point me to what might be going wrong.
I'd be glad to provide as much information as necessary.

Thanks in advance,
G.Sibi

PS: My apologies if this question doesn't belong here....
