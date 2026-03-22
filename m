Return-Path: <linuxppc-dev+bounces-18557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E8FC72AE
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 07:49:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdpNh65jTz2ySb;
	Sun, 22 Mar 2026 18:49:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::72c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774165780;
	cv=pass; b=BGpdmjjndT1J3ofpR+96KeLm3CEXPdE+y8VUqW9fwVLuAu+A1TbkFUz0Zdg5MDb5Z0eZTz+1iDYTvj48qRvwSE+gKCsJkM6eg4n1iaDTOKpticJznYc73zy1Q0cccNMpmK4lSh9XPeL+UVzc/wCF2BiRgZPUW7nnRBCG/RM7t2HMjQe3QMatIT3EmvJZjzBi6AbbQnJAw/QSBuj++NmveuflXlPlm11VgLE/5DHrzWSzPkSLv9jizdw5HdJ7WUl1U09kqf9zyaZSQDwem4DukDNcqFMKV3jeBiqvtYWa+sRGM1riPgFHyLPTaJjb9V0aRu+hnn0euqTRjVp/lAtMHg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774165780; c=relaxed/relaxed;
	bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMoH2Uk4pXejH84CxEmG6y5WO6sV+nbMFNZS5ICj+xG+I6G9zjoxQT3PPgacZr0Fj3nHZxHgcOFjg38+2NfkElbZt0fcQfjvvI29km3bf2/NGzPemFyuMuXGGDz/9Cr3/pHIee4oYPmRkJuGRorlfj9djR2ca2YJV3+R33V4WmN9VuC6CjHgrmJnP8aiFaUsKyOF1kRn78BENpV2gg2VLDcAyQjoS6m/mVTtffHGcZMd3bsd80mwsZV5onktTsNMl1b/3j3SFC9xgUXRwmXUfG97tx6denI4B6AHfXtjZCERHgsgwilL2MDn5fRowGl4go6jCaPc7JmCy1qzMDqZww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OYHD0Peh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OYHD0Peh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdpNg4x5vz2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 18:49:38 +1100 (AEDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso214546985a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 00:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774165776; cv=none;
        d=google.com; s=arc-20240605;
        b=AV33B3u+2G6Vzxgh1HSjWgQk1zf0oj5BqBU9KgLQfW1xpvLA+im3AbfGWPn5u2yNEs
         E7CqghFVbsHXDwm4OnyzWoCG/1U9PgQJU0aqK4xDscO+CNt82qRipcRZ18N6W54clCxD
         zj9exHL4IOG6h8D9/UtMeYcHYi/j7qu9j8muW2BNVORZqvakk3uU5+U9/1kUzna4PROb
         GUFffmMLMEAYLONMW1DvV4LJndOiLYyRMFRBIep4URBqKjgNQYmulVeHeHhsfKTpoTKi
         ETTIJ3ma7/nmFChlR6NwqCqtf3GavLpK1ogHmkpQ/b7i15IQ3oSG3gqRAp3c1K99sPa7
         /7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        fh=QClLTpJS+NpEvLhaSw8z58p+1gAH7djcAY/8aQm9Fgk=;
        b=amo1so/NUMEV1AkCvdj26LVsQuX8c8FxFga3UVpGTInB7UfWIxzxM0S7Ewg1l5SBZD
         ILyPjeB0/WGQNSwR7CBgN634/2C/5W/AZp94/UpC+jmiHP0gEyrTkjeueDwt/TZlGREk
         EXfbv5+cCPPloZVI291GEcxOOzsNH+ahFwCLQWSDGd6j5d3972Q19g35nltzHsy/Ui+V
         csZgdH9aFJ2H+Zrf9pWoEiG9oPidULqun7LYx/NxXyRg/avczFDzflp1o7q1UU9E9HXC
         IRbcdylIp9cD+/yGGvzMoQm9JtBLU9T9z9UyTr4rS8gvkW0HsEILEzC3ea53wwbKKdq/
         YRaQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774165776; x=1774770576; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        b=OYHD0Peh6zhzIZKerzcNVJ3NlPcWcsgczAQDruyEhlIGdZiBryL4HHve0Fh2YrN9sJ
         IjhwDW2yoWdmF3LRM54lUou9DwLDolpDoHXWcRL86mmbx2vc7ZDwIQ1OAsUhgZssCAa2
         JQqkSpQ6Wf7XqHYLEneRisilbOxkJQgJSOschv2FevF10nr0+S44vtgINzX7Db00ZYHX
         Z8el4vD3rph1lcSWEHzxGY66qUH3wYCgWalK0lk0uS4cp1DulaPnRhbZdd2epCD4D8uC
         5Jukeyqp3RrTj6MRIwKJOwP9R1iNHM+LDnyd3gYpzZr3S+wfI8Qfn1GrSUJh/khw78Fv
         pr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774165776; x=1774770576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        b=fyCfA4xeU/KDVOt4VwZ056eJzuAqDD1pJIsxLxaYBzt+TsmYqL+L6o9NVzjcTh8sYF
         0dLRasooUreyW6PPxmtJXE+wkhPlzRO6LiztC/yX8TzHHQtJvCSBAvXVl8NTtj3DHmVc
         8B/jxql/dlVenciPFGMstdnN0qceK99cX5jtOyb8v8BKtKsOND+zsCeS9anFOP/AmvpD
         N3zQkb6P3+lqFNnIOrl2mxxzCUutLbxFbHk2wcXRs4KDDF8ef5Qv41ITGXJBXERhdPSP
         yr8c0+J5oVVwjfH4tMjtSLJprdRHq4hAdUVkt6ncI6O2ojz3HaOWrZd8duH1gukoIPW8
         aU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOlDUfnKKseXLJ3LjtI+1ibihZ578jUCAzpQ/KuQDh7fZYvjC8RG/GODtvX+7P535Wazt+OmmvPtj3MUM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQGln34h6fT1lQuFSKKKnMM31cUXILi0PYd+6LLKqKBsYn0XmJ
	iypt06ISFiZhaL6+uO6L51ktnV5ekvZ3Pro9dMMM7arZCF5dgckSMDovP659yHBRcc4bygV1fTn
	0Z6hFhsPA4ZfrbGfOXqHVWtl2HySxzNM=
X-Gm-Gg: ATEYQzyWn3fMO+vsmZ2rWlHwapJvIyb0bssGFsKdf/eGPrJXOLEY8CwrD9dKsXuA2NR
	yC6xPr9gE9DK88+FJoekALlsrpS1Fq+XXTErfCizvOvE/EUgg9nUsiJrmdDxFt/VBu+Uh/GUcu4
	jtkd2cVpXis7oV6JrlRYJyRhPNi2f417tqGmHSuyBogUdVoo/69jxPcrmLR7Xu5gPJ2T0ZWCM+p
	DyjRrsQFA7vA+6nJgnc7kq5WmzZQdGj4rf9DRTcuXB/b2jNTNU6YhVbGuhHswH5/XIRtamr8ig4
	uQmQmsllcw==
X-Received: by 2002:a05:620a:318b:b0:8cf:db7b:6224 with SMTP id
 af79cd13be357-8cfdb7b68e2mr439093885a.59.1774165775634; Sun, 22 Mar 2026
 00:49:35 -0700 (PDT)
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
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-2-surenb@google.com>
In-Reply-To: <20260322054309.898214-2-surenb@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 22 Mar 2026 15:49:24 +0800
X-Gm-Features: AaiRm53R0BSIBZ-7kcLpHy3OcZIzoW6AMt3M9APBFS4L2dJIHsEh5rSFscqFXrY
Message-ID: <CAGsJ_4yAWxty2PAm0Lp-iDnAm6DpReedRvus7FFQb3A2dKPTYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm/vma: cleanup error handling path in vma_expand()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 1:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> vma_expand() error handling is a bit confusing with "if (ret) return ret;=
"
> mixed with "if (!ret && ...) ret =3D ...;". Simplify the code to check
> for errors and return immediately after an operation that might fail.
> This also makes later changes to this function more readable.
> Change variable name for storing the error code from "ret" to "err".
>
> No functional change intended.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>

