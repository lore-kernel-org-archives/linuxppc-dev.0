Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4073jV56yHzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 00:07:26 +1100 (AEDT)
Date: Fri, 23 Mar 2018 05:48:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
 fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
 jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
 dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
 viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
 deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com,
 akpm@linux-foundation.org, steve.capper@arm.com,
 punit.agrawal@arm.com, paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
 nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
 dan.j.williams@intel.com, jack@suse.cz,
 ross.zwisler@linux.intel.com, jglisse@redhat.com,
 aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180323124806.GA5624@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> Current implementation doesn't randomize address returned by mmap.
> All the entropy ends with choosing mmap_base_addr at the process
> creation. After that mmap build very predictable layout of address
> space. It allows to bypass ASLR in many cases. This patch make
> randomization of address on any mmap call.

Why should this be done in the kernel rather than libc?  libc is perfectly
capable of specifying random numbers in the first argument of mmap.
