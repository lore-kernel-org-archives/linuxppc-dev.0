Return-Path: <linuxppc-dev+bounces-20996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C325CD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 May 2026 00:43:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHQL16tkTz2yS4;
	Sat, 16 May 2026 10:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.209.10.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778864284;
	cv=none; b=OiguQn8iR2NJI8Z7jAXu2EAlMD+jMTsnvlcAfn2vBvnQpBrnCAkvnN5JMOfFgznX7B2ox3w5S+1PC051AixeAX9GVbRrsYB1D3Vj2TMYv5k8EAy1v90IH8nyEnbLNTGjznmBdC7fwOnl5m3yT7CJ3XbnsaezTcGp8flQX3ICGjhC85GYTnObdyk12rvXWvICctGGQZLteRFXB9Fe5A13lYnQ5qhyt5D+konIn3UqWRV2k5ICmTjjcu9Pk7Y2vtu/JzZiJBh2tJlcQNpdrPamu3lDqyJQstfAGuwJ0oMFlGD9umNq5TdZuXwTUgsqA6iQv/76Y1a0pcgHirKcX/04OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778864284; c=relaxed/relaxed;
	bh=9WdAPwKSp54bIXm01Oq6LbLaPfYtCmuqhvark2IMT2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN55Ws0o40jAtm33NVyNNUifQhWTP0IRgQ8J4AWykJq3hl3BuvYkFw/eMVdWQ/00e2BNi6YV3m9iAGV+dNN+NNhPi0Gm0OTgS26d6Kndb0vkD3flPQd4Tyo7oYYznmIL4ZQognYxhDQtGvzguZM6L4sxRknoYIW5JK1sVT8xBnLaCmn4QC7kdOzu72ZlP4NZFKrzXXEPVO3lxfOJ5w7+gymThhKQB/tgUVT7ql6Q/Psksltsunqfgf6Yqtro4hr2JszHr0qI6yavk7jPheows7Qyq7NO4Dz++5D/4hcO/UnHp6taZ+35D/waqStBkqmJ1v+1qXM7Jxl4KZku4iLs8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; dkim=pass (2048-bit key; unprotected) header.d=inwind.it header.i=@inwind.it header.a=rsa-sha256 header.s=s2014 header.b=m+g/qCp4; dkim-atps=neutral; spf=pass (client-ip=213.209.10.16; helo=libero.it; envelope-from=kreijack@inwind.it; receiver=lists.ozlabs.org) smtp.mailfrom=inwind.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=inwind.it header.i=@inwind.it header.a=rsa-sha256 header.s=s2014 header.b=m+g/qCp4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inwind.it (client-ip=213.209.10.16; helo=libero.it; envelope-from=kreijack@inwind.it; receiver=lists.ozlabs.org)
X-Greylist: delayed 288 seconds by postgrey-1.37 at boromir; Sat, 16 May 2026 02:58:01 AEST
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHD0T1HJlz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 02:58:00 +1000 (AEST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id NvkWw93JTwuJmNvkWwUGk9; Fri, 15 May 2026 18:51:04 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1778863864; bh=9WdAPwKSp54bIXm01Oq6LbLaPfYtCmuqhvark2IMT2k=;
	h=From;
	b=m+g/qCp4tzbt0bfLHz2HXIh1xSUujGy9ADLjjh657vY4gNP4lbZYMwcDvTDqGmJHn
	 guKy97+1kM74qxw7PyF+I/NFPIVb8cWlfUtHTVz4VHnD4oSGB3HweAfU7uZKlSx86x
	 Vyk8KrD9zr0HMhRMr7f5y9sIjd4bHO5srzzWxOOO5kKtztzC545W0ulDGpkTzcPfcI
	 DPxCb1vHX2wC8W5Sj1nVM4xgQ9uISn+3FrOWzYFTg6LAcHL3zl6P6sTT7UInpTlL5L
	 zdnAK2M5Uwlx5YpksdXUvJQT7Ni0sawoxU1CvZY8rV+cXe1DIy1fUI/vZzSzY1teva
	 BHCuKc3H/tYsg==
X-CNFS-Analysis: v=2.4 cv=OKAXGyaB c=1 sm=1 tr=0 ts=6a074ef8 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=5UzOym4Vq6aNC_X-wu4A:9 a=QEXdDO2ut3YA:10
Message-ID: <ae5e68e5-06a8-45d1-a8a9-59c619d32db6@inwind.it>
Date: Fri, 15 May 2026 18:50:56 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
To: Christoph Hellwig <hch@lst.de>
Cc: David Sterba <dsterba@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
 Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-raid@vger.kernel.org
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz>
 <20260513054742.GA1018@lst.de>
 <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
 <20260515043705.GA3855@lst.de>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <20260515043705.GA3855@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIRcSTt5STXgccljMnCIz2eHZSPUpoG6zdkAW/1BRn9L53xyO+P3wQrbMMLVbxJHW+N8sp0yzakc3MR2cCcFMo1dlAl8gvSc/SDOWCHxfinPvWCytcjr
 E2ajSvp2CIF9Ys2QWNCM2YCTOuPJ18kbaVkxxmFRnVsIOb0ucyjN9KNL3BFkk7Ud+bru2koUwvlDAPKrMAw63A+BOuJVVDbieCPNq4YxJvtCma8dYpiqD09G
 sCh5JNMMXuGgnTgfqUUJ+Qbzsqdtto0je5KdmrGMW40aotZ/+S/kJn4sCFnf5g1gapE4BKz75kSmw6JFXPdxmZFJdOFG7z5fdUrA1Dwsb6umoqal7VDvdbma
 DiZm9XRnZCDhNNF+ZPkLQZb1TofZUdq6d7ug1o+src70lE6+LihoJsyM0ZbmxVgrTjewmbztqjnQJoYArZ4QqbywD5Sd3TiEGsl9lWWu5eyiQTebAIVRFeC8
 nEqFAs21qZrxPF6Uq/SnJv8qagoxXJRfWwNn66R+K3YiI6mOSG16+ZHThNqvJU3/bHi683USl3wE7UhRu5VlqQEZ6WoE/qj+eUN839hKRWt7YLcOTrEGd/uO
 +pqymzrMyy9izoH0Srz7Zk/PSTaid7BTCeO82xYw+Mzv4uwzhc/nYaOUlTLtPwW9T43BOc5MH2JAKYVnn9cO2AqtXKYykFg4x9FPEOR9cuMRTVbENtjdWpps
 Bq5zTF+AXkoWW6W61ZuXitS+tT5vlt/ELS+pUxVBCkm5yUJSSkqICuZHNRnhM3gKHDVhh4Ns6Swhs8GpYekFjqnPHq7KrOecxDq4JL82hLJZf8uClKDfY/3Q
 YHJVueku5+JW2Kx+xEEIQJUzojSwxWIVlFgz4S6a7t1jEw/PMDrQxkW28BP8BmfQ2L51hNvmCWAwFJZVe9DOoBKat2mMwYNyTMLCbQPOK8IepgFN3Xh5J9Yr
 zsELdIh47mqn+n9m1dJHl8pdLI16lbpd7JPS+rkT+X/VBpGWYSg1SizlQW7Zd6jRhZj+jugRLz8FW+5F6xSEi/1ryCr9UJ8Hnp8FeykJKC0csQa4tsyRBeQ7
 4+oDZCBNS8xIrFMYdp9mzmc5IPnpusyfFrNplemnIr8YCvMYHgimmAuUw7B+Z604HGNs7Ovl7kfpP19u/d989Txfb5lqbJA0NcloGgH+Za5UVq2UnfUCc3RG
 yQ6hJ/UHoxEGDfFw8Vjo0ZJLwPp9Fb5piSf6i8OG4nhtHPa9h6ifl2mQkomRIENZEoVPODly2pGPdGYQ8ofZVwl5dOxvxVdP8xHs/4FTnwWuYPn2oGuykHIe
 tZhMm58QeEehltvUobNgm0ZVAba57PviaUzaSzgaYIj4G5+83y9jvcY6E9AO6TnOWTIFW7iK62Oq25b2ClXNlm0KYceNhHqEH6EZrPkegcRv+/fMsmtDrqXG
 OY843VHWlpsPvVHxWqQzTl72N0dCPlXPWy8SLXM96jwzxecEP5uEeZQ5LKvFAEh2+TfNPdIksDMJ/PnhBFMdAGHk4SJJcNiBcsZTNHeSHvJlW/8TI23ooPzr
 23+SWyghG4+6P1hrYFbwUDsjIGhuuatpKNV34Vl6jEmPQg==

On 15/05/2026 06.37, Christoph Hellwig wrote:
> On Thu, May 14, 2026 at 09:51:59PM +0200, Goffredo Baroncelli wrote:
>> I think that the David concern is : "what happens for an already
>> existing btrfs raid6 3 disks filesystem when the user upgrade the kernel ?"
>> (I am thinking when a new BG needs to be allocated)...
> 
> Then it will cleanly fail to mount instead of constantly corrupting data
> and memory with every write, yes.  Which clearly suggest that such
> file systems don't exist in the wild.
> 
> But if btrfs wants to keep supporting this I'll just add a _unsafe
> version without the check in the core library.
> 

I am not arguing about this part. My point is that the change shouldn't have impacted the
BTRFS interface versus the user (as patch 01/19 does), but instead the change should
have modify the interface raid code <-> btrfs (e.g. doing a memcpy....), or at least the
cover letter should warn that the raid6 code requires a number of disk >= 4, pointing
to BTRFS as "client doing wrong things".

At least, the message was received: don't relay to the raid6 code when the number of disk is
less than 4.

BR
GB

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

