Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55191C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:24:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4494206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3TmaqAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4494206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445ZrH1m6XzDqkV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:24:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="K3TmaqAD"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Zgj3WvrzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:16:49 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id i19so1268142pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vo6jhFpbADqF/a0Ruw2bj4J5FVM9bvOetl2FepVuCV8=;
 b=K3TmaqAD4pXvm/GlBWOLi3KMMA3nE1BcVO5H8tvU6WLblDnG6rU5iQDEcf+DenGjg/
 KPBbaD/8Ufw7zsYwK3LHwKAGate7bhzVZvAM7dVb73c7t3ViHwYtk3KN3MQyiWf5ViLB
 lI33EzlB7Lp1o/q9BZudcdhoCMMcz6pQLrSp0UbWMq9mtoyG4uorMiL9svUzcIa7nOv1
 0Fas/qtQlGh0mUU2vhqHgiAA27XlZvAAsaGOR2l8gAhc/gb0y8s+owi+uNNY2lwlKnnU
 lB71JS+fKzNQWR6j1I7kY9bqUJk3JJjdSa3qIcnN/ih8DdMdwDP1z1iLDZUjxcVJOh/1
 2liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vo6jhFpbADqF/a0Ruw2bj4J5FVM9bvOetl2FepVuCV8=;
 b=oRtbLqUeJ3Nr4SLbxPAw2X8xMiPefQks3nLk34efa1IDuM7bbUdKzyX1h8NgkXd9o1
 63VVanzGJ1XgmyUpWrLpCEEwsPEvCNtIW5ZyPw6bIMM/ze6B2HHh+AYwzUClslJQFm5K
 JeRgc6z5RL7OObfVboCtQDWHJCH7i3VyZ1SgIzr3YO2rJaeZatZaFA7CQY7Uxpr8IDkF
 df1BWgPhWj4WiysFfS1YLaBrDSz2h0P6578IyevP3QKJCRAgOqwAzD4WTKEJepdZX4KV
 Yi/blik3bPZFlfS+jldDI0Dxd0J4955FFhJK41JaoG46ujFxfu6ij1UOmafZq29/Pqwj
 4Xlw==
X-Gm-Message-State: AHQUAuYVB9H15/3Vtbiy3zoLAVix+6CEeTvuqya4ZMIL7fyCN9DlG3eR
 LXwZiJ3TC6ediP4hmUCtLk9NeaGZiV+8CFTIKjs=
X-Google-Smtp-Source: AHgI3IZeQgqWVtrcsfm2Tm2BWN3Prl48FQfg6UjzpDJVhVgiMrpi7spJkXwnpCmoaBF9grx4xygB0oWfMnVdUG2nFc0=
X-Received: by 2002:a63:d347:: with SMTP id u7mr4363863pgi.383.1550848607431; 
 Fri, 22 Feb 2019 07:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
 <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
 <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
 <CAOLK0pzXnvk=FsfjH07jUyRJGpeiNG7-9vR9Vo0mLJtdPnt_7Q@mail.gmail.com>
 <d9043bc8-d006-bf64-2047-79a9b6f98183@redhat.com>
In-Reply-To: <d9043bc8-d006-bf64-2047-79a9b6f98183@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Fri, 22 Feb 2019 23:16:35 +0800
Message-ID: <CAOLK0pyGhbd43rVPZE7waaStUkGVYVgakG2VgqtME4PxNTOY0w@mail.gmail.com>
Subject: Re: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct
 mmu_spte_page
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, the arch/x86 maintainers <x86@kernel.org>,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 11:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/02/19 16:05, Tianyu Lan wrote:
> > Yes, you are right. Thanks to point out and will fix. The last_level
> > flag is to avoid adding middle page node(e.g, PGD, PMD)
> > into flush list. The address range will be duplicated if adding both
> > leaf, node and middle node into flush list.
>
> Hmm, that's not easy to track.  One kvm_mmu_page could include both leaf
> and non-leaf page (for example a huge page for 0 to 2 MB and a page
> table for 2 MB to 4 MB).
>
> Is this really needed?  First, your benchmarks so far have been done
> with sp->last_level always set to true.  Second, you would only
> encounter this optimization in kvm_mmu_commit_zap_page when zapping a 1
> GB region (which then would be invalidated twice, at both the PMD and
> PGD level) or bigger.
>
> Paolo

Hi Paolo:
             Sorry for later response and I tried to figure out a bug
lead by defining wrong
max flush count. I just sent out V3. I still put the last_level flag
patch in the end of patchset.
Detail please see the change log. Just like you said this was an
optimization and wasn't 100%
required. If you still have some concerns, you can ignore it and other
patches in this patchset
should be good. Thanks.

-- 
Best regards
Tianyu Lan
