Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
	by ozlabs.org (Postfix) with ESMTP id A8BC6B7D7E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 May 2010 20:08:03 +1000 (EST)
Message-ID: <4BE92D66.1050000@oss.ntt.co.jp>
Date: Tue, 11 May 2010 19:11:50 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC][PATCH 0/12] KVM, x86, ppc, asm-generic: moving dirty bitmaps
	to user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<4BE7F6D7.3060005@redhat.com> <4BE7FB7B.5010600@oss.ntt.co.jp>
In-Reply-To: <4BE7FB7B.5010600@oss.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
	kvm@vger.kernel.org, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com, agraf@suse.de,
	kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, paulus@samba.org,
	hpa@zytor.com, tglx@linutronix.de,
	Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>>
>>> In usual workload, the number of dirty pages varies a lot for each
>>> iteration
>>> and we should gain really a lot for relatively clean cases.
>>
>> Can you post such a test, for an idle large guest?
>
> OK, I'll do!


Result of "low workload test" (running top during migration) first,

4GB guest
picked up slots[1](len=3757047808) only
*****************************************
     get.org     get.opt    switch.opt

     1060875     310292     190335
     1076754     301295     188600
      655504     318284     196029
      529769     301471        325
      694796      70216     221172
      651868     353073     196184
      543339     312865     213236
     1061938      72785     203090
      689527     323901     249519
      621364     323881        473
     1063671      70703     192958
      915903     336318     174008
     1046462     332384        782
     1037942      72783     190655
      680122     318305     243544
      688156     314935     193526
      558658     265934     190550
      652454     372135     196270
      660140      68613        352
     1101947     378642     186575
         ...        ...        ...
*****************************************

As expected we've got the difference more clearly.

In this case, switch.opt reduced 1/3 (.1 msec) compared to get.opt
for each iteration.

And when the slot is cleaner, the ratio is bigger.




>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
