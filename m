Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2EEC47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 17:42:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446B0206D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjdfKITT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjdfKITT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446B0206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LSv3625VzDqnc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 03:42:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=pbonzini@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=WjdfKITT; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WjdfKITT; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LSjr1tBnzDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2020 03:34:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589218475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCAJG5qvZrEQpE9xVUmgEKkY6ZGLKpgEhGop1JiyIl0=;
 b=WjdfKITTEgFHoCjsS9PIrlAAInX21HIR32HGv3gMnClArvSCDBfGHe/Nwo1YL+0JPA6y64
 L1/BlJUhlxwPSJsL7nex70EHYycCIIlujkvT5DQIa3r1Xo4nAj6QIJuW4jnuqPZ7aggpK+
 e2VFUrN8/NCSW1lLi81mPNdNavN7AMU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589218475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCAJG5qvZrEQpE9xVUmgEKkY6ZGLKpgEhGop1JiyIl0=;
 b=WjdfKITTEgFHoCjsS9PIrlAAInX21HIR32HGv3gMnClArvSCDBfGHe/Nwo1YL+0JPA6y64
 L1/BlJUhlxwPSJsL7nex70EHYycCIIlujkvT5DQIa3r1Xo4nAj6QIJuW4jnuqPZ7aggpK+
 e2VFUrN8/NCSW1lLi81mPNdNavN7AMU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-tOtx960LPqGtcC-2U_rJjw-1; Mon, 11 May 2020 13:34:32 -0400
X-MC-Unique: tOtx960LPqGtcC-2U_rJjw-1
Received: by mail-wr1-f69.google.com with SMTP id f2so5574362wrm.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 10:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jCAJG5qvZrEQpE9xVUmgEKkY6ZGLKpgEhGop1JiyIl0=;
 b=gp/sCC/tsnPZ+SE37Hp9saUCqdsl7I39PwrlIOf65HB4mHwOZJn1yDiuLmMZ95qVWq
 sXWih4qRq2jr5BgNH5SKmYonjAlcA0GWbaxmkmw2dTehTLZGYcQpzeytENbaJku7Zt0+
 J5hUoIZH8wFP+AA/CxK48PiHPnCPlhaFJ6a3FsPpeoJrAeuXrEk50TTafmGTtJnuZ8s8
 jTrgpqc2nHbPbACBnj7fZ7gNPlKQs3tOptwZspwiHBIYXv7USFOotpuoHzfQnQilR9Xn
 pqMyZlNOvzouflf4Ar3emaOSjxsC3jeU1Y6qONLsX7ANX0EqHY/GO3lyMHTPbwz+QHUP
 bXBQ==
X-Gm-Message-State: AGi0PuYE81rseQz4B+z05GbJl7To9oKU6vof3oxnLiRHFYWBXeS8LvNV
 b63PpM0TXGZVnRrL0+oPp6Ucs2zuPebcE5Jgbnh3LBZ2OeRmq+3bYvZigLyF4k5/UCik+z3glB8
 IRC5TCsMGxjIJuyOqioCaftRdKQ==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr12469228wrs.285.1589218471446; 
 Mon, 11 May 2020 10:34:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNe6I7z0SbQYOHpqyl28aME7TxGvpzSGiIlzFVueJrlC+GRcVDtQgQEgjyS86Oa3oOuu0xgw==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr12469194wrs.285.1589218471191; 
 Mon, 11 May 2020 10:34:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4c95:a679:8cf7:9fb6?
 ([2001:b07:6468:f312:4c95:a679:8cf7:9fb6])
 by smtp.gmail.com with ESMTPSA id 89sm18102311wrj.37.2020.05.11.10.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 10:34:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To: Jonathan Adams <jwadams@google.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
 <CA+VK+GOccmwVov9Fx1eMZkzivBduWRuoyAuCRtjMfM4LemRkgw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe21094c-bdb0-b802-482e-72bc17e5232a@redhat.com>
Date: Mon, 11 May 2020 19:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+VK+GOccmwVov9Fx1eMZkzivBduWRuoyAuCRtjMfM4LemRkgw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 linux-s390@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 linux-mips@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Jim Mattson <jmattson@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jonathan, I think the remaining sticky point is this one:

On 11/05/20 19:02, Jonathan Adams wrote:
> I think I'd characterize this slightly differently; we have a set of
> statistics which are essentially "in parallel":
> 
>   - a variety of statistics, N CPUs they're available for, or
>   - a variety of statistics, N interfaces they're available for.
>   - a variety of statistics, N kvm object they're available for.
> 
> Recreating a parallel hierarchy of statistics any time we add/subtract
> a CPU or interface seems like a lot of overhead.  Perhaps a better 
> model would be some sort of "parameter enumn" (naming is hard;
> parameter set?), so when a CPU/network interface/etc is added you'd
> add its ID to the "CPUs" we know about, and at removal time you'd
> take it out; it would have an associated cbarg for the value getting
> callback.
> 
>> Yep, the above "not create a dentry" flag would handle the case where
>> you sum things up in the kernel because the more fine grained counters
>> would be overwhelming.
>
> nodnod; or the callback could handle the sum itself.

In general for statsfs we took a more explicit approach where each
addend in a sum is a separate stats_fs_source.  In this version of the
patches it's also a directory, but we'll take your feedback and add both
the ability to hide directories (first) and to list values (second).

So, in the cases of interfaces and KVM objects I would prefer to keep
each addend separate.

For CPUs that however would be pretty bad.  Many subsystems might
accumulate stats percpu for performance reason, which would then be
exposed as the sum (usually).  So yeah, native handling of percpu values
makes sense.  I think it should fit naturally into the same custom
aggregation framework as hash table keys, we'll see if there's any devil
in the details.

Core kernel stats such as /proc/interrupts or /proc/stat are the
exception here, since individual per-CPU values can be vital for
debugging.  For those, creating a source per stat, possibly on-the-fly
at hotplug/hot-unplug time because NR_CPUS can be huge, would still be
my preferred way to do it.

Thanks,

Paolo

