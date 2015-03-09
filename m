Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C10891A10D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 02:15:46 +1100 (AEDT)
Date: Mon, 9 Mar 2015 15:15:26 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150309151526.GQ8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 02, 2015 at 04:19:43PM -0800, Kees Cook wrote:
> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

I've run this on one of my ARM platforms, and it looks fine.

2a05e000-2a05f000 r-xp 00000000 00:10 7750376    /root/offset2lib/get_offset2lib
2a066000-2a067000 r--p 00000000 00:10 7750376    /root/offset2lib/get_offset2lib
2a067000-2a068000 rw-p 00001000 00:10 7750376    /root/offset2lib/get_offset2lib
b6dfd000-b6ed3000 r-xp 00000000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6ed3000-b6eda000 ---p 000d6000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6eda000-b6edc000 r--p 000d5000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6edc000-b6edd000 rw-p 000d7000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6edd000-b6ee0000 rw-p 00000000 00:00 0
b6ef9000-b6f10000 r-xp 00000000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
b6f13000-b6f17000 rw-p 00000000 00:00 0
b6f17000-b6f18000 r--p 00016000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
b6f18000-b6f19000 rw-p 00017000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
bea3b000-bea5c000 rw-p 00000000 00:00 0          [stack]
bec22000-bec23000 r-xp 00000000 00:00 0          [sigpage]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]

And offset2lib shows a random offset:

Offset2lib (libc): 0xffffffff73261000
Offset2lib (libc): 0xffffffff732ce000
Offset2lib (libc): 0xffffffff731b1000
Offset2lib (libc): 0xffffffff73252000

So, for ARM:

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
