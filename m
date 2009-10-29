Return-Path: <akinobu.mita@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 7674DB7BF9
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 19:53:31 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 8so372698qwh.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 01:53:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091028131141.523854cb.akpm@linux-foundation.org>
References: <1256719397-4258-1-git-send-email-akinobu.mita@gmail.com>
	<20091028131141.523854cb.akpm@linux-foundation.org>
Date: Thu, 29 Oct 2009 17:53:29 +0900
Message-ID: <961aa3350910290153n70c3d982w10699ac28be63b6c@mail.gmail.com>
Subject: Re: [PATCH 1/7] bitmap: Introduce bitmap_set, bitmap_clear,
	bitmap_find_next_zero_area
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Lothar Wassmann <LW@karo-electronics.de>, x86@kernel.org,
	linux-altix@sgi.com, Ingo Molnar <mingo@redhat.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/10/29 Andrew Morton <akpm@linux-foundation.org>:
>
> Why were these patches resent? =A0What changed?
>
> Everybody who is going to review these patches has already reviewed
> them and now they need to review them all again?

I resent the patches because the iommu-helper change was not correct
and I introduced serious bug in bitmap_find_next_zero_area()
if align_mask !=3D 0 in follow-up patch then those were dropped from
the -mm tree.

Only [PATCH 1/7] and [PATCH 2/7] have changes since the first submission of
this patch set.

* [PATCH 1/7]
- Rewrite bitmap_set() and bitmap_clear()
- Let bitmap_find_next_zero_area() check the last bit of the limit
- Add kerneldoc for bitmap_find_next_zero_area()

* [PATCH 2/7]
- Convert find_next_zero_area() to use bitmap_find_next_zero_area() correct=
ly
  iommu-helper doesn't want to search the last bit of the limist in bitmap

* [PATCH 3/7] - [PATCH 7/7]
- No changes
