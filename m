Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0545606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1OeYKnh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRyf20DdPz2xly;
	Sun, 15 Nov 2026 15:27:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794716873;
	cv=none; b=eLtiqyNxcRvyIOWgtnswtVDVeyCBxoNEyIt5uN0IEE7g5up104RsmwkBLXcw43o1McJegXD8ramI9Fi2hDyqEEz7tr/Mps/q2F5oYLtUdgIrSJr4kmMjx2mGluXpOIenXu/zNnlJNyYTYxQlyx4eiSAa1D+OGgLjyhhqcpo0NGISUvOKYMJ6Mnskj5lYHHF9kkTDu0EgpR8Ierw0YK7M5lnNAzounb9S1BATHMPfvwmFpzMrXM+FgCJtbhYxH8l2mZGd3BlIb6SUfzRyTwufJ4xa+FkQAeEC1wVr0jxfJVBiNOLC/ZQAZsRCcNFHcYxIV9tEsgTK0nwlmo9BEUrDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794716873; c=relaxed/relaxed;
	bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XB1GEQ0+NTfCcqacJyq2sDwFS3NHV/XYWTdUeG28Ypzxpf9DUsOqb2aDCcaq9djf2fRMwtRKEsmegyBOrJ5KHoapNHZGdZJYa1rQ98xM5svzkWZCeKC2mI5NRYjLQOPRtnPSFF7+ZIw7S9YZgQd+bBBYwEM3Qir7QPhZu3cQSYPTymZCAvAqZWK7C0SdwqrR+2+G8djsZ3lX+J2JKkJu46y54DTxssV/f+cDGKrbZor9cFJNuoA/KgOnIWHkfD2qokMpPtnlqJR0pb11EkQdwT0bm5Be4Y6loZ6Jne8z74WLYsrPk8PN4c6scDQbmjM6SCcmKNJ45JRX821UD6l6IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1OeYKnh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1OeYKnh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRyf10V51z2xKv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 15:27:52 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2863300c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 20:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716870; x=1795321670; darn=lists.ozlabs.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=I1OeYKnhS+q/UlZiPXALO6TgNknVVAMx3Af8m2atyyxnd7BMmLOcTfnWyH0XDPl2dp
         6C5j8sc6O10W8makxLX2iHfvzhZeKGWK+cU6RuLT7EQN3AV7HzYDjooiIahJltuWf547
         UrP8BYIMq3wa5ME6An+M9oIWwOUelEBC7Lt0dbU/lSFybgNy/vObLjIZdCzeS6ZlsDzo
         CRXK4YWNm4FyfLyd5HjuAqesz2jgk2BhaA4gRgTcQujYW4VugBzpeNchGJUIenorc3zI
         dh7Wi7P900/rdHEwBqKdlQB+oJIhhnUovANpxyBW8zhA44H6ds+p4HmLx137CKp0Pv5F
         C9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716870; x=1795321670;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=siQ1ngJwjifW5xdD084y2dpDTG2vzM0Xym25TG0D9PGT59ltWuSTBn/AAft2fFo9vT
         LRkKYECZRQIM5FH4PlV4jOIHphPWv6nrj/auMuGJnRZxQ49w+tZUFfQ9rg6A4HvdkUQS
         H28wpg94rxYdQfLOVdbyH0z2KMozCfoLCOudIxy69RwAKELx6GKdGEChjPFrw8tWXPZm
         J6Nq7GPomTVs/xwCqeL1E5M/Yg3OG3J5a3psDyTs6Qoufxv0gNknFzDhMMje8CS4rEuB
         93Yy7yXzxWDFo6RAHJ83jDSTYi9X4Gvy9EILnQS45SzDRO1y7LFOmpIJ6p7yP0XVQTua
         yrhQ==
X-Forwarded-Encrypted: i=1; AL+hErGMzEp+0CvCashzzinPy4tnY7r5VDHonjeAc65nA0acbYA8vZ4bxhfUrGXR/YBYNY2J1bTMGRiHkHEtvoo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Rqiq4ms/qdsfH7x8i8/r3cltw952LS7qDCUjpyxDv5UQte2Uw
	S14qMAT+qUP4DFwFW9Mr7R1HChrY9WR5Y9GdHY8r1tOTzjA8MxsRs1CY
X-Gm-Gg: AYBFou1pSCxoDCqOPYhLZspPVcS1JplZ+rk97JQUT68J0vbIV3s+x46/a5yz1T+tnqz
	A+qmHK6xTNmmyKcrM+kICi+Dy5LRG5+/zp7hFPnvKPBuefWnKDtASsPiTsct9LTn58Y1trWHU0v
	8oljZLc+WKOsMCLlikgFtXnTNy6ZMurn/w/r06hYTKh6ApwTPPChmgg2HDVvR2cuj2dH32CpmAc
	kHpFDb0h+uNPckF0TJtnY1He4Hl3Au/LGfVpwxgI6612nDEzx/rjgpPqJDKBZc4Y9Xdl0KvaCnv
	vmmQWTUg4Amyl7U5qk5NXetAwQA/dEL3gL99O0e/vd7TRryJF4zHJ/tUPQGeSoWvSzPyQPDBROz
	/dGRBWmy0gHzaqSFcb7pJhkkSPbnzve8lY1/JyEepJ5jHR6CgFBP2Uv9DMwQ8hsIYcpG7HTKCQl
	xhpolBs5+H+sNrD3qJKGOSZaBRJYNfYJUh+xRdsQjkMmRh9gHb6sWXdzA918tdVOr9adEA+MDyk
	dqaeJ1eWInifuF82HewN7S4bq0GWtnYtZZ5nEHuTJS8y1RZaSWOnU1G52Cw3Vk7szHID84eO12V
	9IaGElrqGFL3NCh47LqGOgH6YAs=
X-Received: by 2002:a05:7300:ff46:b0:37b:c89d:1d56 with SMTP id 5a478bee46e88-37bc89d354bmr1627673eec.12.1794716870280;
        Sat, 14 Nov 2026 20:27:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm20640706eec.6.2026.11.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:27:49 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying
 Huang <ying.huang@linux.alibaba.com>, Alistair Popple
 <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro
 Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park
 <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes
 <rientjes@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
In-Reply-To: <au-DXpEi4wHwsz0r@gremlin>
Date: Sun, 15 Nov 2026 09:50:28 +0530
Message-ID: <7bie914j.ritesh.list@gmail.com>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org> <au3r0-geuwtRYPiC@gremlin> <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org> <au-DXpEi4wHwsz0r@gremlin>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Lorenzo Stoakes (ARM)" <ljs@kernel.org> writes:


>> > It's not really all over the place, it's converting vm_flags_t to
>> > vma_flags_t across madvise.c, which involves changing a few function
>> > signatures, whose callers must be updated.
>>
>> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(
>
> Yeah it's quite worrying that... :)
>

Thanks David & Lorenzo, for pointing this out. I have changed this to
use ksm_disable() instead [1], which then also removes vm_flags_t usage
from there.

Please take a look at it whenever you can. Since it also removes the
EXPORT of ksm_madvise(), I think we will anyways need an Acked-by there.
(note that: looking at those changes, it seems like it should go via
powerpc tree)

[1]: https://lore.kernel.org/linuxppc-dev/0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com/

-ritesh

