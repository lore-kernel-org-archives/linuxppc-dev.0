Return-Path: <till.smejkal@googlemail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk4XV547gzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 08:30:50 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id u48so3602422wrc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 14:30:50 -0700 (PDT)
From: Till Smejkal <till.smejkal@googlemail.com>
Date: Wed, 15 Mar 2017 14:30:43 -0700
To: Rich Felker <dalias@libc.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>,
 Till Smejkal <till.smejkal@googlemail.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
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
Message-ID: <20170315213042.e5q6daqkqoam2iun@arch-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315194723.GJ1693@brightrain.aerifal.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 15 Mar 2017, Rich Felker wrote:
> On Wed, Mar 15, 2017 at 12:44:47PM -0700, Till Smejkal wrote:
> > On Wed, 15 Mar 2017, Andy Lutomirski wrote:
> > > > One advantage of VAS segments is that they can be globally queried by user programs
> > > > which means that VAS segments can be shared by applications that not necessarily have
> > > > to be related. If I am not mistaken, MAP_SHARED of pure in memory data will only work
> > > > if the tasks that share the memory region are related (aka. have a common parent that
> > > > initialized the shared mapping). Otherwise, the shared mapping have to be backed by a
> > > > file.
> > > 
> > > What's wrong with memfd_create()?
> > > 
> > > > VAS segments on the other side allow sharing of pure in memory data by
> > > > arbitrary related tasks without the need of a file. This becomes especially
> > > > interesting if one combines VAS segments with non-volatile memory since one can keep
> > > > data structures in the NVM and still be able to share them between multiple tasks.
> > > 
> > > What's wrong with regular mmap?
> > 
> > I never wanted to say that there is something wrong with regular mmap. We just
> > figured that with VAS segments you could remove the need to mmap your shared data but
> > instead can keep everything purely in memory.
> > 
> > Unfortunately, I am not at full speed with memfds. Is my understanding correct that
> > if the last user of such a file descriptor closes it, the corresponding memory is
> > freed? Accordingly, memfd cannot be used to keep data in memory while no program is
> > currently using it, can it? To be able to do this you need again some representation
> 
> I have a name for application-allocated kernel resources that persist
> without a process holding a reference to them or a node in the
> filesystem: a bug. See: sysvipc.

VAS segments are first class citizens of the OS similar to processes. Accordingly, I
would not see this behavior as a bug. VAS segments are a kernel handle to
"persistent" memory (in the sense that they are independent of the lifetime of the
application that created them). That means the memory that is described by VAS
segments can be reused by other applications even if the VAS segment was not used by
any application in between. It is very much like a pure in-memory file. An
application creates a VAS segment, fills it with content and if it does not delete it
again, can reuse/open it again later. This also means, that if you know that you
never want to use this memory again you have to remove it explicitly, like you have
to remove a file, if you don't want to use it anymore.

I think it really might be better to implement VAS segments (if I should keep this
feature at all) with a special purpose filesystem. The way I've designed it seams to
be very misleading.

Till
