Return-Path: <till.smejkal@googlemail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk6x648ClzDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 10:18:50 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id u132so7038608wmg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 16:18:50 -0700 (PDT)
From: Till Smejkal <till.smejkal@googlemail.com>
Date: Wed, 15 Mar 2017 16:18:43 -0700
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>,
 Till Smejkal <till.smejkal@googlemail.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Richard Kuo <rkuo@codeaurora.org>, Fenghua Yu <fenghua.yu@intel.com>,
 James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Felipe Balbi <balbi@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Benjamin LaHaise <bcrl@kvack.org>,
 Nadia Yvette Chambers <nyc@holomorphy.com>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, arcml <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net, linux-hexagon@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-metag@vger.kernel.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 linux-mtd@lists.infradead.org, USB list <linux-usb@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
Message-ID: <20170315231843.sgxzg6qj34anyirs@arch-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315220952.GA1435@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 15 Mar 2017, Luck, Tony wrote:
> On Wed, Mar 15, 2017 at 03:02:34PM -0700, Till Smejkal wrote:
> > I don't agree here. VAS segments are basically in-memory files that are handled by
> > the kernel directly without using a file system. Hence, if an application uses a VAS
> > segment to store data the same rules apply as if it uses a file. Everything that it
> > saves in the VAS segment might be accessible by other applications. An application
> > using VAS segments should be aware of this fact. In addition, the resources that are
> > represented by a VAS segment are not leaked. As I said, VAS segments are much like
> > files. Hence, if you don't want to use them any more, delete them. But as with files,
> > the kernel will not delete them for you (although something like this can be added).
> 
> So how do they differ from shmget(2), shmat(2), shmdt(2), shmctl(2)?
> 
> Apart from VAS having better names, instead of silly "key_t key" ones.

Unfortunately, I have to admit that the VAS segments don't differ from shm* a lot.
The implementation is differently, but the functionality that you can achieve with it
is very similar. I am sorry. We should have looked more closely at the whole
functionality that is provided by the shmem subsystem before working on VAS segments.

However, VAS segments are not the key part of this patch set. The more interesting
functionality in our opinion is the introduction of first class virtual address
spaces and what they can be used for. VAS segments were just another logical step for
us (from first class virtual address spaces to first class virtual address space
segments) but since their functionality can be achieved with various other already
existing features of the Linux kernel, I will probably drop them in future versions
of the patchset.

Thanks
Till
