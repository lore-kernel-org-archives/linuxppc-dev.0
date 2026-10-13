Return-Path: <linuxppc-dev+bounces-29421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E37ACC6B19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j40dT6kfdz3brv;
	Wed, 14 Oct 2026 03:48:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791910093;
	cv=none; b=F0bs9Wo9uGFSsjSNdKwIDTpehVyCF2J9al/IaEF3cr6v4FU0j6Lq4d+Y7zcLvzCrlQ0geLh85LG/m2YKM9zmYeaOX50z0J7+Kf/mDq0lMvCiJVH5fIURvaz3IT/+d3m5/RLCmwNnKMzRsewSKtMHBB3Pp++boe0cbeuS4qPDiQjuKSefN+v3QxWroFEDAlV/oAIORpFjz8eZZRKL4j32tffhpbvv5idzTQiZioUynz9ZAdBxSylee/Qgo7Kta9KMo3eKLqPh3XvT7lUlo2Sw+CO/a6SesehBiMV4GCdiSXr+ITyxMT0FaWVW0fq6e61JLJZBcIUvJfkENjU1PTZ1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791910093; c=relaxed/relaxed;
	bh=JrdkhjVWS0paU+Qy/xA3FUiCVMdE6viTRALFdsJ0zOM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0D8tiVvKD4QjBmPgQUktZwNhkPtWazXnZ2wgLkxwE34zFhDtS0GgNfoWnH1HHlkJCYr4MklV1ZkP89vt9CD66oUQhiFq9P7VHQhZ5AG8UyIAue2DXFC7tpSwAb2NF1nNu/lNsuf5DnRBpwpuLXnBmywkBHHtUU06JzSRgu78iKleLxaxw072d4eGwvWyZvwq4bGqiNmqJcCygcOHg+TGPTasPH4xKb4NdcrBChLPP32y1b2sVTi5VdSt2QkReSswTN9cQ4S+b2mf3SjR4sm88ZyGqpH4P1pOnKlH7h60RfDMRThR+AOmdkXzR745cBlYpkQDR4YF9Vgmbvr/8Ufcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YrKRHa+8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YrKRHa+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j40dS6Qs1z3brM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 03:48:12 +1100 (AEDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5bced78b3dfso1955975e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910089; x=1792514889; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JrdkhjVWS0paU+Qy/xA3FUiCVMdE6viTRALFdsJ0zOM=;
        b=YrKRHa+8qoXGymmDDZFDBdHDN24Gnfro9ofh17c4J2sIXX4XOOz0Rt4U3BD7VrY3xr
         oLGonV/kbEYldyKLdJQgiVXhbQk3LxcWJ25ewxbsl6BamHKCPcH+V31d6bXco/evM+DF
         SlDeaaFuD7Otp5FF41o1Kpn29yDY00smVDMLEQu+i49XoRqPM+5dLdacG5CG+WSZD4M9
         MSBYHvFur8mmegs73zhZZ26YV+XL6apYSQVeU87Z9Kb4oan3vScCZnBhv5duu+qljDIN
         aGbZ/IaAwGU1yc2SaP221Vj2dVKXgePrPSWxdAZzBvXkqr4mBZShXUoos8HIYpWsCbx0
         VNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910089; x=1792514889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JrdkhjVWS0paU+Qy/xA3FUiCVMdE6viTRALFdsJ0zOM=;
        b=HM43OH8w3TkT66cuqG3gspP+Qdk22APVrEj6XfcvL7DeMrOUsQVTIUfOqOkXpKJ1lg
         WKKYfnR0vtu8KZ6btTf5XV08MRSBM+jeMSKvNOLxdAPaR5uNLIadifFK+LrwfE8ytLbN
         mkpu1a0MjIZr7yTQ6YNejoi3nRdWbRFmBnFOdIQLZOc7vPcsQdDZyPcoL1qxWZWK6RLq
         VBVutdK1P/u+MBXtabnB11yqTHNcdIUaNCl0GI0dUMLmJ9sPrD5aQ1vsFFmFPdP4mO68
         t6M6O7p0/PsXFZJPld+GlosaWQBoyCJEffvxb5W689iGURB1CXhjGB21figQlL4hLYS8
         Bdlg==
X-Forwarded-Encrypted: i=1; AKwUvBwiIN8p1WdpH0EWz8d8KTtfmeeyNPzy/Sv7RQ+Qc7opxZLnqR9cKdUOmr/MQWdTcv8iDg4hqbaHT0qItos=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKgczxUOg32s6YCR/hUUyaM5p6axdJpn/lnCN7GRKTr142s+K5D
	0uVNXSdjHbOIt3kDc1sxnBJ/3tK5130LWrj9ajDQyHJdPT8VOWeOnB2p
X-Gm-Gg: AYBFou0VwXVqv5pDaLnW4tysjgzMbwnn4f0YQcG7IXbUgjjUT/QL8ZgmfYJoMWTBY/L
	oLkcxy38ibOUWaidiXsbDuFtWOYOyidjd+ACq4hRHWk02cdHSssDFNFVCfMvw4XKA1vhZYi0Mog
	5vqcBCmSFEnEiAKhx1Yd4HBdENc1ZrxiKOUydKXy1sdDxKwQw1qsEt3KF4EwFePBxC/shHcIqOL
	LIlmnUCEbKvX7WgEdGEdexytzGzEkM1KJIt8/jHReAr5WiQ8ap7P82G6HfwenvTBMmqovyYfdfk
	n4dH3LX7o9QWhtExohiU8nyUa+SEt6npc+eCMBYiQCzypsvC10HGC4DXkIlJ1eXT0mU8ZShtQRY
	7GYxooULnsV+xqlcnrxT/orhgNirq5/ZMOUbgt0WPiric6irLZpxP3C5hbLnAISAmkjt11Uv1fx
	UYjMQw/XXXCrrS6QfsnWJ+k9J5ZM430OCgGSsak3bb1ZPXe5pdpZAbVa9sXLK23A5hOImUOMau2
	Kmb94z65VhYK/bB/n1wDGL/
X-Received: by 2002:a05:6512:3d0c:b0:5b8:f309:f275 with SMTP id 2adb3069b0e04-5bcde8cea91mr4857257e87.58.1791910089239;
        Tue, 13 Oct 2026 09:48:09 -0700 (PDT)
Received: from pc636 (host-95-203-22-87.mobileonline.telia.com. [95.203.22.87])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c3cd2f24sm37276021fa.28.2026.10.13.09.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:08 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 13 Oct 2026 18:48:06 +0200
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: Hao Ge <hao.ge@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 4/4] mm/percpu: stop unmapping the CPU that failed to
 map
Message-ID: <as5gxn6i2DD0iprj@pc636>
References: <20261009063619.112313-1-hao.ge@linux.dev>
 <20261009063619.112313-5-hao.ge@linux.dev>
 <CAJuCfpGEgTocqrdpOtkOfks-geU0vVMZudNEG5+XWi3sxQdymQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGEgTocqrdpOtkOfks-geU0vVMZudNEG5+XWi3sxQdymQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 03:46:43PM +0400, Suren Baghdasaryan wrote:
> On Fri, Oct 9, 2026 at 10:36 AM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > __pcpu_map_pages() clears the PTEs it installed when it fails, so
> > pcpu_map_pages() only has to tear down the CPUs it mapped before
> > the failing one.
> >
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> 
> > ---
> >  mm/percpu-vm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > index 509d8901835c..59d3a336a6bd 100644
> > --- a/mm/percpu-vm.c
> > +++ b/mm/percpu-vm.c
> > @@ -252,10 +252,11 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk, struct page **pages,
> >         return 0;
> >  err:
> >         for_each_possible_cpu(tcpu) {
> > -               __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
> > -                                  page_end - page_start);
> > +               /* The failing CPU's partial mapping undoes itself */
> >                 if (tcpu == cpu)
> >                         break;
> > +               __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
> > +                                  page_end - page_start);
> >         }
> >         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
> >         return err;
> > --
> > 2.25.1
> >
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

