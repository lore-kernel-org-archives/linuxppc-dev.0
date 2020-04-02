Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289FC43331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 22:49:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004D12072E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 22:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYPyZxkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004D12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tdXg3DnjzDq8F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:49:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qYPyZxkk; dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tdVC5FSwzDr7k
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 09:46:59 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id i3so5419836ioo.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OQnxweQnqXfPXtvAjWkG4LAwMm7QgxQOU06/1lbhuSY=;
 b=qYPyZxkk8z01LGWskSrm9aG/7nt3J+cgEH/SymGNN597NCfm6MCdZIy6TzISZy66q4
 pj6rRU04jWHnuCETpqmyHTLKqZiwVuEyeFh5Rr0b3hSMwg5eGng2Ha2xdSdKsvmQxAOB
 QPSasGKfa8n/l/zHMpnSI/pAoBE+Rpko2nlur98dOVL1Ua5pOL9Ld4KHgbshpQDQcTna
 ZN9LC+pER0Nd3/NjtUkjv0UtAskAfOkP49pxmJi+E9xuTviSHaZd0wPMgN1pFs3Uk30N
 wghTmqvUOM9XnmeCBS/2N/NZZe5q7C6DI1LgBPQnuYA89x4cjlENgCSO+fUrkfhakK+1
 XFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OQnxweQnqXfPXtvAjWkG4LAwMm7QgxQOU06/1lbhuSY=;
 b=OmPSNY8T9dJfL3dBxGqwMo+F3YYjSA1LemWVNriqPyMyACnbEwLvVV18SXAMopCPLU
 BKD7q+6uDQvrK2v8OFFh8o6nNFKcHMDvHNAG2sj3UY50+7s4QG20vthBkPn2P1nFGFIh
 Ukc75rVPCdbtH9p890rkf9OiIjhtaoWIvsvKos5vf35U7sfAwmZWQ+x8qhuZpJgZc3Rc
 veiJL/tPdnQqyXZHU3k+L4oLd0wIW8SJmjdYiSdA5U+vtwn3Ukns3GXPvpaFDRex70+W
 252OdXuuTM+yToj98rxNDYtKy3BAght4XJet8JBNV+KhVm9lCtqdjsjUiHkbKyWwvABc
 SUjw==
X-Gm-Message-State: AGi0PubTvsoDWkX825tyFix44CE2yMs0evPR/H5JyIp/6ojrDb2eLs5g
 7tlBK3xKTnnPR8Z7M11EcVUe5IrKtgZbXRHlSrw=
X-Google-Smtp-Source: APiQypJ96SzZqukS6zpyCpAiLjdlBVXL/4HDhO4ilUK7VCKGO7VXzhUxFl62HyckGydrE57jcQ6v+hhAdMKSuRB5sZg=
X-Received: by 2002:a05:6638:d6:: with SMTP id w22mr494171jao.72.1585867615842; 
 Thu, 02 Apr 2020 15:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
In-Reply-To: <20200402195156.626430-1-leonardo@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 3 Apr 2020 09:46:44 +1100
Message-ID: <CAOSf1CEihBDDRny5S_7TA5Cqbdgsh6zN=kdq83OSgaLbRphtrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
To: Leonardo Bras <leonardo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Bharata B Rao <bharata@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 3, 2020 at 6:55 AM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> While providing guests, it's desirable to resize it's memory on demand.
>
> By now, it's possible to do so by creating a guest with a small base
> memory, hot-plugging all the rest, and using 'movable_node' kernel
> command-line parameter, which puts all hot-plugged memory in
> ZONE_MOVABLE, allowing it to be removed whenever needed.
>
> But there is an issue regarding guest reboot:
> If memory is hot-plugged, and then the guest is rebooted, all hot-plugged
> memory goes to ZONE_NORMAL, which offers no guaranteed hot-removal.
> It usually prevents this memory to be hot-removed from the guest.
>
> It's possible to use device-tree information to fix that behavior, as
> it stores flags for LMB ranges on ibm,dynamic-memory-vN.
> It involves marking each memblock with the correct flags as hotpluggable
> memory, which mm/memblock.c puts in ZONE_MOVABLE during boot if
> 'movable_node' is passed.

I don't really understand why the flag is needed at all. According to
PAPR any memory provided by dynamic reconfiguration can be hot-removed
so why aren't we treating all DR memory as hot removable? The only
memory guaranteed to be there 100% of the time is what's in the
/memory@0 node since that's supposed to cover the real mode area.
