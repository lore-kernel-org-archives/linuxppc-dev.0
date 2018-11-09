Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE94C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:36:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB132086C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB132086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s9Pr3TJ8zF3YB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 06:36:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=angband.pl
 (client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=angband.pl
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s91J32jPzF3dW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 06:18:44 +1100 (AEDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
 (envelope-from <kilobyte@angband.pl>)
 id 1gLC0X-000503-84; Fri, 09 Nov 2018 19:59:53 +0100
Date: Fri, 9 Nov 2018 19:59:53 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 linux-mips@linux-mips.org, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Subject: [PATCH 0/17] Kernel compression: add ZSTD, remove LZMA1 and BZIP2
Message-ID: <20181109185953.xwyelyqnygbskkxk@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!
As new compressors get invented, they tend to find their way into the
kernel, yet we never prune superseded ones.  It's time to do so.

In particular, BZIP2 is drastically slower than other compressors we
have, even when they achieve smaller sizes.  It takes more memory, too.
And, BZIP2 is not used anywhere else in the kernel -- just for booting
the kernel itself and the initrd.  Thus, we can drop it from the tree
completely, making Linus happier by around 900 lines.

LZMA1 is redundant with XZ (LZMA2), and unlike the latter, it uses its own
copy of code that's not shared with anything else (some drivers use XZ).
Let's drop it as well.  Some bootloaders can use it thus let's keep the
Kconfig option, but I left no piece of code inside the kernel itself.

On the other hand, Nick Terrell has a couple of patches adding ZSTD support
(using code already in use in multiple pieces around the kernel).  ZSTD is
strong and fast, obsoleting all mid-range compressors.  As the removal of
BZIP2 and LZMA1 would be hopelessly entangled with this addition, I'm
resending Nick's patches here.  I've been booting using them since Oct'17
on amd64 (kernel+initrd), armhf and arm64 (initrd) without issues, other
folks tested various other architectures as well.

Thus, I'd recommend people to use:
* XZ for most machines
* ZSTD where speed is important
* maaaaybe LZ4 is some special cases
(grub and u-boot are ridiculously slow at reading, making fast but weak
decompressors a net loss.  On the other hand, XZ decompresses pretty fast
but is very slow at compress time, making ZSTD preferred for rapid devel
cycles.)

* we can't get rid of GZIP in foreseable future
* LZO is obsolete but is used elsewhere in the kernel

Total:
 69 files changed, 518 insertions(+), 1785 deletions(-)

Not sure whose tree this patchset should go through.  I'm also not sure
how finely split into commits you want the arch bits be; I included
defconfig bits all together, yet separated code changes per-arch.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
