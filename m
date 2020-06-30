Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963CBC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 02:00:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428FD20780
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 02:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFbydKyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428FD20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wncr1CB6zDqV6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 12:00:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=dFbydKyQ; dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49wnZp4XBhzDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 11:58:42 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id z15so7225554wrl.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 18:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=k6wRh3ytme3gPSlALKJl6wuK0hUmcexe6Z7bwnzkD9I=;
 b=dFbydKyQLV5QX3J4VY9869CPSiZaD228wHrj0M2Z2D8yRuWI9THsp+7kDikYjL6saL
 OGdEcktIGk/kF9VZj+84bJ2awzhsNdRjflSsUNxCPQl4mniXAOAV8XSDgigJ3xHFA87m
 JE8kDhWuc0rQKPSwYLy7SrvQqiVUScaeRo4jnlantr5w6ThKvGm8KLn951bzxyt5uIk4
 jE/qFpSZGKzuHFz2jwQ3LrRpHkQb+1ZoF7sPUHf78rq9w5M83a1on9Bf9LWWUcLrK0+6
 GpFnhzDIBxAdxGNEK33hh8FSWXh9yxabxEXGEhxXd1kU7IZwsAjaNxHLFXhv7KOQHHuM
 37Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=k6wRh3ytme3gPSlALKJl6wuK0hUmcexe6Z7bwnzkD9I=;
 b=TwlFHfbu7V40ZMNR/VJvsThkHOCsBXU9jc37hLVKZsUmITRea/f4SV5n6mRa03sIib
 dB430F6UxdUqQz6qdlAQ5u4Tpd4ibqVOTAYBeO/U6aYgz1ig8HgCIAKpBt2WyOn2juNJ
 EUQM8OewdWSvP+yERd9uOhqglv6zxGT+msZkucqhjfd8bD9+NHarp+WB1PZkD/kxTeBB
 uh+VNa2qYO+PgO0egRGkjgFHzLK3TIwP0bAfo85VcYUPi2lxZlZqMYMQ29AAF9XWHxVK
 cre599x2yr1saMRIQ8UKuO4MlrWrOWQaLYEhPmE7b9Tn8NNo2oGcB8SbZWq8dekKbTTF
 LeTA==
X-Gm-Message-State: AOAM533bj8tRb24hTKU5dkvq3w8r76hSvQv7CTRNMelcMdYSjktu0ef6
 NJa/DRVeyWm4MvUrSJDhWw2hZq7m
X-Google-Smtp-Source: ABdhPJxu7q0WxuSIpUAdZqmDn2LZ96oyRft2Mpcbf6AUyK05/ie1YP8kwX/ibQJEGKtCZqLJfmov/A==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr19723464wrp.415.1593482318118; 
 Mon, 29 Jun 2020 18:58:38 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id a15sm2011397wrh.54.2020.06.29.18.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 18:58:37 -0700 (PDT)
Date: Tue, 30 Jun 2020 11:58:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: inline doorbell sending functions
To: linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20200627150428.2525192-2-npiggin@gmail.com>
 <202006280326.fcRFUNzs%lkp@intel.com> <87zh8l7318.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zh8l7318.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <1593482195.vpy5eylip3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: kbuild-all@lists.01.org, Anton Blanchard <anton@linux.ibm.com>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Michael Ellerman's message of June 30, 2020 11:31 am:
> kernel test robot <lkp@intel.com> writes:
>> Hi Nicholas,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on scottwood/next v5.8-rc2 next-20200626]
>> [cannot apply to kvm-ppc/kvm-ppc-next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use  as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc=
-pseries-IPI-doorbell-improvements/20200627-230544
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.gi=
t next
>> config: powerpc-randconfig-c003-20200628 (attached as .config)
>> compiler: powerpc64-linux-gcc (GCC) 9.3.0
>=20
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    In file included from arch/powerpc/kernel/asm-offsets.c:38:
>>    arch/powerpc/include/asm/dbell.h: In function 'doorbell_global_ipi':
>>>> arch/powerpc/include/asm/dbell.h:114:12: error: implicit declaration o=
f function 'get_hard_smp_processor_id'; did you mean 'raw_smp_processor_id'=
? [-Werror=3Dimplicit-function-declaration]
>>      114 |  u32 tag =3D get_hard_smp_processor_id(cpu);
>>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>>          |            raw_smp_processor_id
>>    arch/powerpc/include/asm/dbell.h: In function 'doorbell_try_core_ipi'=
:
>>>> arch/powerpc/include/asm/dbell.h:146:28: error: implicit declaration o=
f function 'cpu_sibling_mask'; did you mean 'cpu_online_mask'? [-Werror=3Di=
mplicit-function-declaration]
>>      146 |  if (cpumask_test_cpu(cpu, cpu_sibling_mask(this_cpu))) {
>>          |                            ^~~~~~~~~~~~~~~~
>>          |                            cpu_online_mask
>>>> arch/powerpc/include/asm/dbell.h:146:28: warning: passing argument 2 o=
f 'cpumask_test_cpu' makes pointer from integer without a cast [-Wint-conve=
rsion]
>>      146 |  if (cpumask_test_cpu(cpu, cpu_sibling_mask(this_cpu))) {
>>          |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Seems like CONFIG_SMP=3Dn is probably the root cause.
>=20
> You could try including asm/smp.h, but good chance that will lead to
> header soup.

Possibly. dbell.h shouldn't be included by much, but maybe it gets
dragged in.

>=20
> Other option would be to wrap the whole lot in #ifdef CONFIG_SMP?

Yeah that might be a better idea.

I'll fix it up and repost if there's no strong objections to
the KVM detection bit.

Thanks,
Nick
