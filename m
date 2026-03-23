Return-Path: <linuxppc-dev+bounces-18568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F544D58CD1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 04:41:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffL9K2fqJz2ySb;
	Mon, 23 Mar 2026 15:41:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::832" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774240901;
	cv=pass; b=XQEqApzkPGIbyuFU0BRQ/Ukqhoizfn5hVr150kye5mAA3ZNCND1HM9Wed7zEfzw6wo7orx+laIHP0t7Zt3FIm4mJtezT2MtxpM+w3IA6rqTFEHdETsmmsME0yHuyJjt4m18LGtCYz6UdTbm+KWz5aTlv5yiaTw57097a7nJXKsPI4VdrxBnjjqwFcxBgqHKZiyy5Vxz4bTrXygwfZ+bVudmyMqIFSvi8ecE6stSNC3or4cZc3MpcNx//pSdANqLl+DpRHmGDc12VrYU/TY4upf1AY/NymRZeOrkCMMR5TkQnln1tHgtWWM8whdiCqmEu2Afhv4eDlvbZxniwhlZCPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774240901; c=relaxed/relaxed;
	bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SshCwB4xTlmPD280D2Q82tZFWroUlovcY2oJ5Y/vsHnoQbQ29QYg4UdA7Sg9HR8ks3qytS1IMCVklagZWQwBMzg9EWi16eoq7CqeXKCL/RWiPrkYuEVCEwaqeG9NUQe0BJ3BziKGLHF8YlHRDrFUQqcI8P3vmsjFNOXkSlx8JkiXcSMTC43LYJ8XTI/zYOV2bqEl0qG2Z0rEBaCdXdJZ/CxEtB/S1unB+Anbj4l+ak/lJCReGQaRcWizKwwuTHWAejkMw7Kk9+1Z+BDM8e+94Pn1yIoT2Sx/oM/tUlLASmbbzbtnfxeePOEGbOjQCULsFn75jUlv7u2n5CFKV5BcJg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ngdJ58ec; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ngdJ58ec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffL9J1sPyz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 15:41:39 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-509062d829dso1025301cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 21:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774240897; cv=none;
        d=google.com; s=arc-20240605;
        b=gqiAJNArqPoXhyFvia7Dn60kOPYy17PR4yfXWCjG5oMbfZDwF209Qb0GYrHPHe7swr
         P0PqIoYcX95YaEij4AJrfbep7g2soV4LFZTY0B9udlknrcBrhO/46hAzxinte1gcTGsf
         e9bMz3Ybr8Mcd2DC7RFLK+tX81mMMBF2zz4y3cs5boE3FI0B8tyXUBVYOlHj5v1Og9r/
         tB42OPNGXoSRNYW3Nxpz5HuZqsoVILA+fwiS5RjRQ+sA3HhWX+g2EVxzn1xXkm1KQXJm
         IUpgxUfPRhXxqL9SlyOWhFwJfcAh/uzRwah1pl0H3zd9HwwmR7zMtmXwGMYET8Ynt4Nv
         Lyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
        fh=W8eAsgiSxio3TtFKx4RRaJwJKVWZ1dpDkwGdB//aXhk=;
        b=LUmv9BOYut1qRGvZBX1ohFLMAzn+xK+pl8rsy2wSCKhqb25pSK0BNPsuoeCGTTt+u9
         2Mget9g6RtIN9cWM0Kk5YfrvK8/2XhG3i654EFeIcWOsbsle4p8h2qEP1Gshp941F79v
         /JWyEKlJ5ZqhKTriAt44nBLjPjXyxI6BZaUQrXyfF4hxReM8wXbD3kQOONZmtyKkp0TE
         vPk2ktYLYx6Uonc/e/+XeDDWqiaIqs/rbYSx21ZAOkfOuzUBQeVEtp/ZkveV4nNoR04L
         p+5OMJYVmE04aAlq0oo+DanydFbQ/N8dH5J4BhmY//UgGt5tGqI83jU8r9ZSKDR81REZ
         jfkw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774240897; x=1774845697; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
        b=ngdJ58eceY2EcMhISJ+ikDJ+L6hhT1/F+r3PF+IjjvSqrcUtPEEgGOXYW55lPt6JXE
         NWgnE31pwvQRh5sjKZrY/4xYPTGZPz6qSiVa7U+Zs196fdgu3aw69zLbp/hVDB94nOUk
         Bx4Tmc1OS4sgyBrDTe4BhZ7ZBeahZS2UEpjuHp5n79vZvlf3uQ2haKnATCXC4ZhsYqCy
         6j9sUk+396XHdOvzIpOlGVcdaeX46t6WUBoOkDa1ADSkHng90/K9Nz4zIz+2eFLSDBsO
         K1ErNuJAizczl+WVEfctLsVHfkOcS2BSVHA3rm+MFB/UsDgpIwYTIsNH3F4HyKkoMnMN
         RLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774240897; x=1774845697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
        b=GmyD5rCFR1EX5pJ2vmG3neogsimDsP0JR28K5sCzID0jnAir+BQEYwwNCT4u3q9PPg
         y6c2N8D13Moljng6Wlc0z96GNpoQHWmmPvmvHYX/PX5VdMB408KkMcWamoR1gvLBDF0H
         IsosJR5RowMnTXJDRIxRHuBhRKuaxuC6GStaMxvMu7SjoOD2pApNskT93AWQeLrgZSaN
         QIX4c7yzLgnXM1oksom6O71FmqplZ+Pcd3BdtH1yAUBqVmeYEwOGdZkahdJ3Fu9KYyay
         78Hp+8tZ1/1yCfxbN5S1a2CT8E2XFiFsPimw5hrUdIJDAuTCrVHMiB7fZtgzebB+Mi1O
         9HIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN5DBLOjZD6lRlRI8MK/G3/O4G6XYbuRaX7TVgD+nQpQ6wstK2n6phV0yWUVF6JBuqxbPkmLyVcScli34=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1UGbX0JTZnlx3KyzO1dPCqHU2vnSdBehrm63rZEOgivS/h3Ve
	c+f5rsuUI68gIvdLwUw8Rrnx0J6BkejR5OfVi8OQ5833CvAxCh6oFF0cgP95/Dw3GdYolcUaGoj
	yax3HA6zvmju1RdnXfppGRMU92g/kaGNjsMZPTjQ5
X-Gm-Gg: ATEYQzyfbFWww7dliN8dqIUha1gp7te47XdYMemm+TGd2/2PWnZiFRpX9DAPbB4hpWC
	cU0xrKZ21v96LgNT5FHnqVKrXWl2nuQMld6o0GkOw4eItG5DEIW1YXW63MupHaCyQMzsG/54DgF
	Qhevp0Ye84jy5UAfBHc0UMMF0a1k+fDl6sj0E5HAyBgFVhDHiOCPHor9gNs9PlXpLhOLOOw/mOp
	6SWIbb/0rfNX3x9sgbVY7dQb7bVoZHqZNLblv9E5fY7HzhQQ0/wMMoCylUgbf/jqinA/7p/aXdC
	0GsYQQ==
X-Received: by 2002:ac8:5c8b:0:b0:507:35b2:6b9 with SMTP id
 d75a77b69052e-50b48107de0mr21777311cf.7.1774240896259; Sun, 22 Mar 2026
 21:41:36 -0700 (PDT)
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
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-4-surenb@google.com>
In-Reply-To: <20260322054309.898214-4-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 22 Mar 2026 21:41:25 -0700
X-Gm-Features: AQROBzB-kgyO_oEQY20cC0lvKSqR0xCjsdgKi5Q7Yl3nGZ7l0Zr3zEDlsBs17n0
Message-ID: <CAJuCfpHOy7QR1Bk4tA_JNzeS1M2OYEJuuxuZeWjnZoY3u62B5A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> If kvm_s390_handle_pv() call fails its error code gets recorded but
> execution proceeds as if the call was successful. If the next call to
> copy_to_user() fails then the original error is overwritten.
> The follow-up patch adds fatal signal checks during VMA walk, which
> makes it possible for kvm_s390_handle_pv() to return EINTR error.
> Without this fix any error including EINTR can be overwritten and
> original error will be lost.
>
> Change error handling for kvm_s390_handle_pv() to alter normal flow
> once failure happens. This is consistent with how kvm_arch_vm_ioctl
> handles errors for other ioctl commands.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3eb60aa932ec..ddad08c0926f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>                 }
>                 /* must be called without kvm->lock */
>                 r =3D kvm_s390_handle_pv(kvm, &args);
> +               if (r)
> +                       break;

At [1] Sashiko says:

"Does skipping the copy_to_user() call here prevent returning Ultravisor
error codes (rc and rrc) to userspace when kvm_s390_handle_pv() fails?
When an Ultravisor command fails inside kvm_s390_handle_pv(), it populates
args.rc and args.rrc with hardware failure codes and returns a negative
error code (e.g. -EINVAL).
Before this patch, execution unconditionally continued to copy_to_user(),
allowing these diagnostic codes to reach userspace even if the ioctl
ultimately returned an error.
By breaking early on error, this skips copy_to_user() entirely and silently
drops the updated rc and rrc values, which might break userspace's ability
to handle and diagnose hardware Secure Execution failures.
If the goal is to prevent overwriting the original error with -EFAULT,
could we perform the copy unconditionally and only update 'r' if it was
previously 0?"

[1] https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@google.co=
m

This might be the reason why copy_to_user() in the original code is
called even when kvm_s390_handle_pv() fails. Then I guess it would not
be a problem if copy_to_user() later fails and overrides EINTR with
EFAULT. We could avoid that override by checking if r is already
holding an error code but that would change current behavior and
possibly the userspace expectations. I'm more inclined to simply drop
this patch and let errors including EINTR to be handled as they are
today. If anyone has objections please let me know.

>                 if (copy_to_user(argp, &args, sizeof(args))) {
>                         r =3D -EFAULT;
>                         break;
> --
> 2.53.0.1018.g2bb0e51243-goog
>

