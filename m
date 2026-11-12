Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F028606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OSHIG8ov
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQPxJ3Xrdz2xVY;
	Fri, 13 Nov 2026 02:50:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::832" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794498644;
	cv=pass; b=RaVLf2jvfdY9MIXaYtUZaVAus7dWIn/dkr3q+u4YmaeHmmFCYmOYeDQ+n4YB4RrU64b4HzfNCoirJ7rmRlRHyLfA+b22eIuWXk18ufFYUbTntzG4+ACtDrmxGplO3ec6CTE3Ab22lRe6nodLAasLznn+fyfnNO+mjqm1KpU70MGPitsuPha2FgNr5IOxLSziHf0y3FEdyGgwVn0VSydcsZBzbSq5GHWbNcVFuHNN/DQxtpk1svQ9YgVTZglHd+3zkopQW/Sx+NmuPr5riF6v5Xktjhvg6cygPwWt3zAf2p6as0mB02Na1YIxNybrZQ6PSGCUmZVDFTCmERA4Vlr+Bg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794498644; c=relaxed/relaxed;
	bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsFjBFzwZwIKB7iQXwls8gsWjAIoTCKecgj/+CPjeSc1wMYAcQ/f/2Zt+UIPrzZidkXTJxumzQ0YGijKnJnrcCSCPrJ5M5qdRXa0ZcttLsu5iSHIk9fibQfcpJWwO6GTLEyk3or+ZrzIfpTZEScLebBsYu/Qh9IX+/rcKgFMwR4o4NC/7yBhvHsI6piGxn+bVqAyhUVKAB1k13XxkegyF+K+yaFJEs1yfnCcGo0iPfIksEzh6gCAYDoqNiZoDsAzvksHS+XhTk11iBB3HZq+YNv/CAohTsOl0sySQpGjgskTDXICDd8rlH+Pn2aXL6vViMoLliri8fv3qK/N05LgrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OSHIG8ov; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OSHIG8ov;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQPxG55cNz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:50:42 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-5383c97c8cfso272871cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 07:50:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794498639; cv=none;
        d=google.com; s=arc-20260327;
        b=FjEBbMkduN+88gX/MAoAGPHoj2TQj9FQ/ph+oSaxvTej6XNhHfDGg5exMzItpfIkQx
         bZLCfFRhIfpIiDqbxRSON/GUzq9YPSoXCJWQpD6KlTt0ppVJTgYCmnUA/ROAwu1wIbZ7
         6fd+rjsC7pLd5M4KNd2lt05wpRJBj3/+vk/QXSb+RvpZkpB9OElJOpxuas56kSh6KEc9
         hcMKwQhY7WJrbuE9An7E4eS7aln7YV2s0UiHhbOolVmY6aBLPQxskrCaNu7/wynZlyeR
         7gVgMJpXOgjjN3Yu7NDrnTRVFAeJWdS3dSEy5jsxrwe7wbDN9RuEV0Pupsd69Mjc4Jkx
         /goA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
        fh=hCrZMkugK++FWXdMlkXsNWOeV+WcrIl3wS+2xoWJKj0=;
        b=jHncO7dRLp/3mz+ZBR+v23xyDlpd9jEka47jSNzuyRkOIe0tuTeg2Z6zH4sCGBDDKZ
         VA2r0ypK/S2QeGNU60JDHYg7Hw71yAHoAKDeAJaRpSg+K/jSvYUj5wycIWCN6PkxXs/E
         M2XSOlccPpl4rgnA+1F0PJARMTYQipEMwmWOoHHUsbc7QeQrTtY74YDsiWfWRu9shAS3
         J+egPWuGpsWxOsZdP69CZhASzkMEA5G9jx07yVJRN/FO1CRnxKmb9iUIhEhZBX4ts6pn
         9BRJa/MqYTrub7mhV/uSYOI/4oZvpRR19bsYCDpyp9clJtSDt4u8Y4bpkQ4gxORyfMoX
         YHSw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794498639; x=1795103439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
        b=OSHIG8ova2uSA3aUYqsVBZmXXNW8M1pkfzYfCAyrYAVy+TFb9K8X+Pzm5KrTNEK6ui
         sgzeS/ISzwDnTpmSBuKO/jqm+6F0xO6rJ4GYweK0hF0/YUPyDV5Mi1qvQusvYyErJnim
         OQ0EW7GxTb0Bu8f2NUShNTQhjyp0sYZ5uCMo3IN+p3XQou7rvsVCvVFWm/y8APC4igUf
         d1pUg8rvSgwigmNoLfB5nTFFNaT+g+1k4edkSpBncZCUjfvWcN7GzvCO607wkr0qwbV/
         yynfVxVWprD5QLb+1sOM/IDM0WtxkGiccPKaubPBFSYDc84iwqBkyIqQYyLfN8yT5t3P
         K4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498639; x=1795103439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
        b=usPW0omFN4B4PZsFPZOa94XSV6NX3u+MbqYreG5z/kyuBsKYvVMklCH6a4dpApcI2w
         d7Et/OWo/paGxR29pwOxdU0kK7suUAHtbtosKx6jM4+Dxk4V/9ytc92ZSCFSCZrfDszx
         lOItoTMgGUspXHRJ2WSJv7lXhRlpMsXUo3LKscYa+MExdEwI+KLpJhDmduoIX2YJRnaK
         PFDbOTNuDocWXKTwRjERXKOXdlxZYyp+kMUk8vaYdtW239NiV7GCjpj2E/tClX9msoky
         sTez9rtys0i5eJz2L6Ipm7JT82loTt48vvLSXqAX2f+u1jMF+1SezUz9in+LbMaPXA1F
         54vA==
X-Forwarded-Encrypted: i=1; AL+hErFnLLD+2hrdauvWiWcmYdJO74RiemmYgiqF5Y65gTtbQb8h97wMOD+NSa1vDlxP+rwW3KU7MaPuQf08xOo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9mvTDjtTnLgTohswcs2dHiJcgVWx9dej1I88UhGrOXZbiid1Hx
	u4urL7gfg7Tg9GxJueGIRQsgp1ZXtf8mrjEIhV0OcOV6ghR4DBVPGCLAQt9qcBnZxGlDyzSSbt5
	W1LmgaHFaebRXy2eI4Qp/KwK+j6wf/j8mEB4Ejntm
X-Gm-Gg: AYBFou2t32vyeRkosDLtw30zyYznddUcFF08PBw1NkXdd2LfpuBK7GXYsm1Jx5wVJ4Q
	V9C+cpHr5BflSBoOVZtZz4lsmc2NkNlkQdCC8d1i7VyuwN1XFTLo1vaCeD8qqQ48fTVecmd8DRm
	OUqbWD0A2IVGOmuofkNZ2Z0NJAQHIfcp4J11UXzTZnSVrDWPPtBPD8NCFK1TF2gSUDFcCNU8aNt
	pkUvZpKWsvLrASZSJMo5MshqUPG4f9r5OshTA9pnv7OXCsmBxtOU57QQQbZwIxZypa7I2uywCC/
	KsQqO7xqXwcm279DpxLnyvrqVckuxaI9D4yhDqARH7WXR6JOmu9rgKiUX8xbPXkcmtqZhBSOTCO
	O76Dx2QPKy4n1nUwfzcDbMgtBtAt2fwXbKhDIYAa4edSH8P+bnmQo+gEg/QlRBPsvgqFbK283PR
	eIIli0EpWi+1jB8Rbe/M/KjkxtsA==
X-Received: by 2002:a05:622a:c14:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-55990231239mr18865281cf.10.1794498638566; Thu, 12 Nov 2026
 07:50:38 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-2-hao.ge@linux.dev>
 <CAJuCfpHjSZhPPpRudAdrDPzz8dGK=Mx62CYCNoO4MC9OhnGd=A@mail.gmail.com> <aa6caf61-a4a1-4c51-aae7-ebb767f3430c@linux.dev>
In-Reply-To: <aa6caf61-a4a1-4c51-aae7-ebb767f3430c@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 07:50:27 -0800
X-Gm-Features: AclHuK8tTrX5dxrTUPnpF2OR-DhefKyRTvk3c3hlnhcxw9TdWFm-p4sWJVSI-pQ
Message-ID: <CAJuCfpEC-YR7NrX_J4U-eyP-2T=E02OKKEO0eSjFMzja+BFLww@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 11:49=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> On 2026/11/12 05:03, Suren Baghdasaryan wrote:
> > On Tue, Nov 10, 2026 at 11:24=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> >> the origin pages. If the second mapping fails, the first one is left
> >> mapped, and the callers do not roll it back. The next vmap of the
> >> same metadata range hits the stale PTEs again and fails with a
> >> WARN_ON() and -EBUSY in vmap_pages_pte_range().
> >>
> >> Undo the shadow mapping on that error path, the same way
> >> kmsan_ioremap_page_range() cleans up after a partial failure.
> >> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> >> the shadow mapping, so no TLB flush is needed.
> >>
> >> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_p=
ages_range_noflush()")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >> Reviewed-by: Dev Jain <dev.jain@arm.com>
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  mm/kmsan/shadow.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> >> index 0c88d89bf0d6..2166086d3dc3 100644
> >> --- a/mm/kmsan/shadow.c
> >> +++ b/mm/kmsan/shadow.c
> >> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long =
start, unsigned long end,
> >>                                             o_pages, page_shift);
> >>         kmsan_leave_runtime();
> >>         if (mapped) {
> >> +               /* Undo the shadow mapping set up above. */
> >> +               kmsan_enter_runtime();
> >> +               __vunmap_range_noflush(shadow_start, shadow_end);
> >
> > Sorry, there is a problem here. You introduce "can_resched" check to
> > avoid calling cond_resched() later in the series (in patch #7), but at
> > this point __vunmap_range_noflush() can be called with GFP flags which
> > do not allow blocking. Before recent Ulad's change called "kmsan:
> > remove hard-coded GFP_KERNEL flags" this function was called only with
> > GPF_KERNEL but now that's not the case. I think you can move
> > introduction of can_resched flag into this patch.
>
> Agree. I just went back and looked at Ulad's b186a94227b7 ("kmsan:
> remove hard-coded GFP_KERNEL flags").
>
> So will do next version. But perhaps it is better to make it a separate
> prep patch in the same series? Because besides this call site, the other
> places that call __vunmap_range_noflush() need to be changed as well.

Agree. Moving that into a separate patch at the beginning of the
series with its own changelog and explanation would be cleaner.

>
> Thanks
> Best Regards
> Hao
>
> >
> >> +               kmsan_leave_runtime();
> >>                 err =3D mapped;
> >>                 goto ret;
> >>         }
> >> --
> >> 2.25.1
> >>

