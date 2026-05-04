Return-Path: <linuxppc-dev+bounces-20415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413A7CD3423
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 08:44:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8FZR5n5wz2yZ3;
	Mon, 04 May 2026 18:44:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777884287;
	cv=pass; b=Dm3iz7n+AFw/wEtfy/B2aFTzIgmyuuotk1WRQ9V5qHeS8iY9qFzZZKf6gzOl+xmtGYlTVeBswso2e0Ouf87saxZ+Qwg22Guc2bOe0vc1Ab/8Hw/vsZwmNXvrvdM9ixrRt0g+1AOFg4Ke0zwevj+8c0UEl45ETVuwT4BNJ+XmUCkOzCv/gBXV48/KDqigOPuBSAiSL1aZLpyHa8/SSx4T+fwz7XLsZtmb85hPUefRo6gdz9Vsqvo548+/wv0JGi7X5O8zk1UvklmcD76rUJFl1PI7AL2zeNJ54/Jn8DREhM6JLxq5TJlhsvkm2i/mpaTFZI920/vDYT1/WZzIRQL69Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777884287; c=relaxed/relaxed;
	bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9c35DETuRkiL1KImTDCefEe/EaP+yGeYijuTSsVfAm7YjRZijydiDmw/wh+SuDx/VWhKWlmBfd4M2fOVQP1dAvcLU82xzVGxT6SLpSCYDtjMmLSwuulbuyE0nJ/6wIf/bJ+bOXnx69iO1s30/VzJBXIOSJh6H2N2rOk8KWTwNAcE0kSdpzWE1ttFsEzb+weIgSLW53uaw3Uj43xkXXKpvzeev+gYZSfhdI2J5Xf03swszJd0/CHttZ3P0XfeQwnybP0ISXUrBHFFEt4/efhORUb5zh5IH90IqqrIJVXS0wCWxihUf1qPFdYxdBoaPoc55jgYK7GLJfgsk06IUReRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kLY2aEDD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=alexei.starovoitov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kLY2aEDD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=alexei.starovoitov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8FZQ0CPvz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 18:44:45 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso47580265e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 01:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777884281; cv=none;
        d=google.com; s=arc-20240605;
        b=czhM5/3Sz92wPrWU+ROAyvng8UTQQ2E3I+SpYugAhtUm8ApbpT4B5rAvbMpZ2L6GGw
         LQejiKc2Tzm9BNP31X0G2IQWBM/g2jJTiTeci+u4DjJfHinw4Ln6E4haatPLPN6bV0hJ
         DFCpE51HwsM18TCE1IbHZVFWoWYR53ggWqLkEtt9TtYGPANpovVw0KfdbLSwgFh9gcfS
         cHOye2bS8McMTBsENXe6ns/JfaMPh8qr4wzw0tCcSV8TAGlCjeecgyhpnsKNJFbpV8W6
         Y+JD6+qOfpQ+giX71dCfNJtVp4184pzRSa9wWwCaLHogwpiK2g9aK3t4QU+P1SXRKI5o
         iuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
        fh=5i0MCJnP0CwpU1Pz88C7SceN0Q9WM9Q8zvv3GbMDPAM=;
        b=B0w+d/z8vTEXT9JTOmLcq1qbmP//Lc/hgFq+sWRU16KPc9MPOA5DaoRTjaTiEY6mtE
         imx+iu8f99U1gFx2o3Avz9e2cawvTX6FWcCpWu7CE4xp/cJv7+4BMqDTFhO0H2jrz6wn
         G6yeIGOTMqiLl68GEznDAhO+2rInQArGNgjxJc6gecrgr/uP6PL1JTIm8+wjYOUlfHDX
         B/9e/0vv5JWKt2oaFm60PncdM8i/Nz6Z656heiFKtYQpVK6vje5DHra4XyXuvDF2zmNk
         PtmbhAOnExzevCo8hF0+Tpo4D+3k3pym89Fe4t/oWQuLXMQRxDl/ZSC6OAF188FCVSAB
         ThGA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777884281; x=1778489081; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
        b=kLY2aEDDf2WlW/Rehpr8mzcZpZ7tFm+u6VLp8rPixZgr8tBH8AIp5j1ESC68uwXEvJ
         JO8jExhUXuh9YWD9igR8Y1Cqj1Ee8kAv6kZkyPeCPFwUzUFy5sq8zvrroLTt9UJX3T7B
         c82hpgoHCx2NT0ZJGJQBecZZvRvR5L9lSQyWxOlKCAP3UYg4DVMi8R/6W70z4tFrbeJu
         /WUx0GYb96QkXHvNS9KT5t9eZO584V/VHASAoNAE5+OpjNQi26YSjXVaW7T38kpcnvNE
         LgV/GXmFydi+q4Nf/hTwmn39Usd2WBInQ/1V4Q0VmzIknXcWWXAK6iQO2V1SxEcoPi6T
         9y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884281; x=1778489081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
        b=ouhB/JKbsy+85glD1rpxSHv5uCek1PcLQolDj6VNTrQI7IRMsS3oteamzL40qDuSiX
         yOTmQx11ZlQt4SE2amXl3wOBC1nf/vTXcruHHtCHqFg+xoDp3+TrxZbYFul9kUCfCz0V
         B+dturgUGwo042UJaTI51fWczQulxYX7KX9VltKABDO/3a8F3JYBF6KE1G028lhpWSwX
         Dt1vKJvfH4egJnUykPq0Ii5kEMDz41NN07bDTGs36vAE4D2l4s68ZtesfyNYqCtU285v
         1ZtuC9wuY8EJqy2kBDcNEQUbxdYrhRGQ0+ExKi1dLig5Pn/Q2EPU1XnyrdlglbxEmv64
         C0jA==
X-Forwarded-Encrypted: i=1; AFNElJ//Qbl4sq3nnd+kRgo3594NGGrU1cB4fifq5em8mVEQlqsjT1unhlbWUETQQUpWcJhvOcCWksh98GtD32U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyL76o0QjLRNCPDfpsGzegDQ2BUITL7vgReWZRXv/ObRg67zo5T
	cOGTcdufM+1P5BgbS3biuE8DNOADz0CGj5TbsnFRs5the8hTRTEwptTSWTRKV6JCwqfzGYIfvBj
	8Aw4+NtXwR9ZF2ksQ5fgydl1xV5vtzWc=
X-Gm-Gg: AeBDiesucNddIPSj9J38/p+diJYh8T2yTSm0elzrhYqHS7wTrUuuK0T1UWvhSKCNRLs
	QaOz2T9ypsHuLMqpMjjfGjhKOp6afcSu0vCGn0mLEVvVmmo0lHDkuivH5GgQvP/WwVW7y3YASf0
	H27kXZ5eTM1BHIPCNaJ9+rWMyPEr4BjgkYnWcw7lRTaEUfv9RAKw6wbf0c04L9GJ+CTiEZPdDzv
	BzltHIKC8Y2adRlLfeZ4rYwLnt2yDAl/BzbfGblhFyghrg5SCyvSuv5q/eWzfSd6sdChzLxfEXu
	PL4ilcub+S5hXtUZ1X//EBamXlLoVntFLPyQ7f7jb4nRIOqBUit0wTcBMBSFkuPS7GDOY4LaXh6
	Ubhk=
X-Received: by 2002:a05:600d:f:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48a9867756dmr114115895e9.27.1777884281056; Mon, 04 May 2026
 01:44:41 -0700 (PDT)
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
References: <362eaba2-54dd-4b59-81f5-65abb916e916@linux.ibm.com>
In-Reply-To: <362eaba2-54dd-4b59-81f5-65abb916e916@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 May 2026 10:44:30 +0200
X-Gm-Features: AVHnY4JZ5hfoCAF-GdNeTg5qxvY890QoN5Fk7GQtaHRmuk32fVJ1xR5wgivEK84
Message-ID: <CAADnVQL7Hm592aGOKbmOMRiPuKz1uCLKu9KE3poZqyR51y4HhA@mail.gmail.com>
Subject: Re: [mainline][bpf] build failure: conflicting bpf_arena_* prototypes
 between vmlinux.h and bpf_arena_common.h
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:42=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Greetings!!!
>
> I=E2=80=99m seeing a CLANG-BPF build failure in tools/testing/selftests/b=
pf
> related to conflicting prototypes of bpf_arena_* helpers between
> vmlinux.h and bpf_arena_common.h, on mainline kernel.
>
>
> Error log:
>
>    In file included from progs/arena_strsearch.c:12:
>    In file included from
> tools/testing/selftests/bpf/bpf_arena_strsearch.h:4:
>    tools/testing/selftests/bpf/bpf_arena_common.h:47:15:
>      error: conflicting types for 'bpf_arena_alloc_pages'
>        void __arena* bpf_arena_alloc_pages(void *map,
>                                            void __arena *addr,
>                                            __u32 page_cnt,
>                                            __u32 node_id,
>                                            __u64 flags);
>
>    tools/testing/selftests/bpf/tools/include/vmlinux.h:135295:14:
>      note: previous declaration is here
>        extern void *bpf_arena_alloc_pages(void *p__map,
>                                           void *addr__ign,
>                                           u32 page_cnt,
>                                           int node_id,
>                                           u64 flags) __weak __ksym;
>
>    tools/testing/selftests/bpf/bpf_arena_common.h:49:5:
>      error: conflicting types for 'bpf_arena_reserve_pages'
>        int bpf_arena_reserve_pages(void *map,
>                                    void __arena *addr,
>                                    __u32 page_cnt) __ksym __weak;
>
>    tools/testing/selftests/bpf/tools/include/vmlinux.h:135297:12:
>      note: previous declaration is here
>        extern int bpf_arena_reserve_pages(void *p__map,
>                                           void *ptr__ign,
>                                           u32 page_cnt) __weak __ksym;
>
>    tools/testing/selftests/bpf/bpf_arena_common.h:50:6:
>      error: conflicting types for 'bpf_arena_free_pages'
>        void bpf_arena_free_pages(void *map,
>                                  void __arena *ptr,
>                                  __u32 page_cnt) __ksym __weak;
>
>    tools/testing/selftests/bpf/tools/include/vmlinux.h:135296:13:
>      note: previous declaration is here
>        extern void bpf_arena_free_pages(void *p__map,
>                                         void *ptr__ign,
>                                         u32 page_cnt) __weak __ksym;
>
> Tool chain Versions:
>
> gcc (GCC) 14.2.0
> # clang --version
> clang version 23.0.0git (https://github.com/llvm/llvm-project.git
> bd6bfba3e50343c112a04b639394ab85be17c29b)
>
> # llc --version
> LLVM (http://llvm.org/):
>    LLVM version 23.0.0git
>    Optimized build.
>    Default target: powerpc64le-unknown-linux-gnu
>    Host CPU: (unknown)
>
>    Registered Targets:
>      bpf     - BPF (host endian)
>      bpfeb   - BPF (big endian)
>      bpfel   - BPF (little endian)
>      ppc32   - PowerPC 32
>      ppc32le - PowerPC 32 LE
>      ppc64   - PowerPC 64
>      ppc64le - PowerPC 64 LE
>
> # objcopy --version | head -1
> GNU objcopy version 2.35.2-67.el9_7.1
> # ld --version | head -1
> GNU ld version 2.35.2-67.el9_7.1
>
>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

The issue is in your setup.
It was brought up a couple times in the past.
Please search archives.

