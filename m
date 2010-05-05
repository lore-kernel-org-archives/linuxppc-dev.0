Return-Path: <takuya.yoshikawa@gmail.com>
Received: from mail-pz0-f185.google.com (mail-pz0-f185.google.com
	[209.85.222.185]) by ozlabs.org (Postfix) with ESMTP id D4E9CB7D11
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 12:59:30 +1000 (EST)
Received: by pzk15 with SMTP id 15so1308918pzk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 May 2010 19:59:30 -0700 (PDT)
Date: Wed, 5 May 2010 11:59:24 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
	offset macro
Message-Id: <20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
In-Reply-To: <4BE04677.4060608@redhat.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220500.7695cd66.takuya.yoshikawa@gmail.com>
	<201005041703.00549.arnd@arndb.de> <4BE04677.4060608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com, agraf@suse.de,
	kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
	yoshikawa.takuya@oss.ntt.co.jp, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, hpa@zytor.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 04 May 2010 19:08:23 +0300
Avi Kivity <avi@redhat.com> wrote:

> On 05/04/2010 06:03 PM, Arnd Bergmann wrote:
> > On Tuesday 04 May 2010, Takuya Yoshikawa wrote:
...
> >> So let us use the le bit offset calculation part by defining it as a new
> >> macro: generic_le_bit_offset() .
> >>      
> > Does this work correctly if your user space is 32 bits (i.e. unsigned long
> > is different size in user space and kernel) in both big- and little-endian
> > systems?
> >
> > I'm not sure about all the details, but I think you cannot in general share
> > bitmaps between user space and kernel because of this.
> >    
> 
> That's why the bitmaps are defined as little endian u64 aligned, even on 
> big endian 32-bit systems.  Little endian bitmaps are wordsize agnostic, 
> and u64 alignment ensures we can use long-sized bitops on mixed size 
> systems.

There was a suggestion to propose set_le_bit_user() kind of macros.
But what I thought was these have a constraint you two explained and seemed to be
a little bit specific to some area, like KVM.

So I decided to propose just the offset calculation macro.

  Thanks, Takuya
