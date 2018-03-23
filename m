Return-Path: <blackzert@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4079yY4g4SzF1V4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 04:49:09 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id y2-v6so19506150lfc.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 10:49:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 2/2] Architecture defined limit on memory region
 random shift.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
Date: Fri, 23 Mar 2018 20:49:03 +0300
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
 fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
 jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
 gregkh@linuxfoundation.org, deepa.kernel@gmail.com, mhocko@suse.com,
 hughd@google.com, kstewart@linuxfoundation.org, pombredanne@nexb.com,
 steve.capper@arm.com, punit.agrawal@arm.com, paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, keescook@chromium.org,
 bhsharma@redhat.com, riel@redhat.com, nitin.m.gupta@oracle.com,
 kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, jack@suse.cz,
 ross.zwisler@linux.intel.com, jglisse@redhat.com, willy@infradead.org,
 aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org
Message-Id: <548B6BB8-FD6F-4F8D-B67F-2809305C617D@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <1521736598-12812-3-git-send-email-blackzert@gmail.com>
 <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 22 Mar 2018, at 23:54, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
>=20
> Please add changelogs.  An explanation of what a "limit on memory
> region random shift" is would be nice ;) Why does it exist, why are we
> doing this, etc.  Surely there's something to be said - at present =
this
> is just a lump of random code?
>=20
>=20
>=20
Sorry, my bad. The main idea of this limit is to decrease possible =
memory=20
fragmentation. This is not so big problem on 64bit process, but really =
big for=20
32 bit processes since may cause failure memory allocation. To control =
memory=20
fragmentation and protect 32 bit systems (or architectures) this limit =
was=20
introduce by this patch. It could be also moved to CONFIG_ as well.=
