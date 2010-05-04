Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 83C6EB7D1E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 01:03:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
	offset macro
Date: Tue, 4 May 2010 17:03:00 +0200
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220500.7695cd66.takuya.yoshikawa@gmail.com>
In-Reply-To: <20100504220500.7695cd66.takuya.yoshikawa@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005041703.00549.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	kvm-ia64@vger.kernel.org, fernando@oss.ntt.co.jp,
	mtosatti@redhat.com, agraf@suse.de, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yoshikawa.takuya@oss.ntt.co.jp,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, paulus@samba.org,
	avi@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 04 May 2010, Takuya Yoshikawa wrote:
> 
> Although we can use *_le_bit() helpers to treat bitmaps le arranged,
> having le bit offset calculation as a seperate macro gives us more freedom.
> 
> For example, KVM has le arranged dirty bitmaps for VGA, live-migration
> and they are used in user space too. To avoid bitmap copies between kernel
> and user space, we want to update the bitmaps in user space directly.
> To achive this, le bit offset with *_user() functions help us a lot.
> 
> So let us use the le bit offset calculation part by defining it as a new
> macro: generic_le_bit_offset() .

Does this work correctly if your user space is 32 bits (i.e. unsigned long
is different size in user space and kernel) in both big- and little-endian
systems?

I'm not sure about all the details, but I think you cannot in general share
bitmaps between user space and kernel because of this.

	Arnd
