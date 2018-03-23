Return-Path: <blackzert@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407B6M0gbdzF0wy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 04:55:54 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id o102-v6so19500470lfg.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 10:55:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180323124806.GA5624@bombadil.infradead.org>
Date: Fri, 23 Mar 2018 20:55:49 +0300
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
 fenghua.yu@intel.com, ralf@linux-mips.org, jejb@parisc-linux.org,
 Helge Deller <deller@gmx.de>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
 gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
 kstewart@linuxfoundation.org, pombredanne@nexb.com,
 Andrew Morton <akpm@linux-foundation.org>, steve.capper@arm.com,
 punit.agrawal@arm.com, aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Kees Cook <keescook@chromium.org>, bhsharma@redhat.com, riel@redhat.com,
 nitin.m.gupta@oracle.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 ross.zwisler@linux.intel.com, Jerome Glisse <jglisse@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Message-Id: <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases. This patch make
>> randomization of address on any mmap call.
>=20
> Why should this be done in the kernel rather than libc?  libc is =
perfectly
> capable of specifying random numbers in the first argument of mmap.
Well, there is following reasons:
1. It should be done in any libc implementation, what is not possible =
IMO;
2. User mode is not that layer which should be responsible for choosing
random address or handling entropy;
3. Memory fragmentation is unpredictable in this case

Off course user mode could use random =E2=80=98hint=E2=80=99 address, =
but kernel may
discard this address if it is occupied for example and allocate just =
before
closest vma. So this solution doesn=E2=80=99t give that much security =
like=20
randomization address inside kernel.=
