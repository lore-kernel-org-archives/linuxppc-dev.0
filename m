Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615FCC282DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6C9217F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfTkhjmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6C9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l2KD0kSFzDqPG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfTkhjmi"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l2HR0JmlzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 11:55:14 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id v12so414939pgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=hRag2r+cRQClvnbXFRGifKjpch/VB6yXiPd+MKpC/OI=;
 b=HfTkhjmiPibg78nX7rz+t//QBE0dtUWyFpG2qsbR+7T6k1NxDW7Wcww4EkaWRCwWuI
 4t6n/XR7YKhU6Ip7uJcS4Jdp4v4O8QR5IUOTsz+r/qXNIEDlQwFbRg8VjOrBAvrbMowj
 vNF3b94lIHyNeJlcYW5YZfYNzTEbtLl6feJXmZaGePfGHM/2HTnSu/YQIgENM99PENOn
 55rH17hWB9tNbF3xJYl9HZfeXhTZIT72G09/zQMsggdmQdruuSaEwxvhrZ5NXoe85lWQ
 bWjIUCHNNMSgsjXAB2ssI31LELp8oh6A9v83Jmuj9cOTzkkY4FubJvXYsobUdFCvcWd+
 Dm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=hRag2r+cRQClvnbXFRGifKjpch/VB6yXiPd+MKpC/OI=;
 b=pEfnLgkrUzSHtQYKPlnzIeo2B8vhSksrGF5+qGDN76g89hDzv0qJmJ4GGlj4yDK87D
 ra+uxYPMKytlQQMYEEapHsJzAHxsR6xHpKkAuMrR2KcqG4A1uQ3vuWBjhwbMKf0wPCnb
 00oh1oskklQaxvELP/mdMGEKh54a5fErM+w5sQDYKevgyObMqvqNsymirpYG2QK+DW2v
 a2qIFhTvsQGbD7P6K6LNY5sPlqGKgofXf8bUb1BNzxJ7XCeUKHMBZ4DK43LVVLoVqwPJ
 bDNmaaGYdNDiUyYTc+3c0mmGsbmZAmx+ILnVmZKyefFtr4Jd7lWrQa66/veYv/jfGd9z
 fO0Q==
X-Gm-Message-State: APjAAAUb796drXDxsqcKWu27aFQHQBETQxb/+ycei1OqqG0jUDpsyA2n
 TcQdga25vJbghNIftwUFDKs=
X-Google-Smtp-Source: APXvYqyHjfF93x3cbVWeXKbtshSYY17+rtsxNfJ8sSQorfiydS6oA2SxUH+sZLHd4xB5kswQ1rmvdQ==
X-Received: by 2002:a63:195e:: with SMTP id 30mr85422621pgz.312.1555552512900; 
 Wed, 17 Apr 2019 18:55:12 -0700 (PDT)
Received: from localhost (14-202-58-58.tpgi.com.au. [14.202.58.58])
 by smtp.gmail.com with ESMTPSA id k79sm791108pfj.28.2019.04.17.18.55.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Apr 2019 18:55:11 -0700 (PDT)
Date: Thu, 18 Apr 2019 11:55:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
 <87bm1dfog4.fsf@morokweng.localdomain>
 <1555389147.okxbj1prw2.astroid@bobo.none>
 <87r2a0jffq.fsf@morokweng.localdomain>
In-Reply-To: <87r2a0jffq.fsf@morokweng.localdomain>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555552271.zy2w4ddjqe.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thiago Jung Bauermann's on April 18, 2019 11:00 am:
>=20
> Hello Nick,
>=20
> Thank you very much for reviewing this patch!
>=20
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> Thiago Jung Bauermann's on April 11, 2019 9:08 am:
>>>
>>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/power=
pc/platforms/pseries/hotplug-cpu.c
>>>> index 97feb6e79f1a..ac6dc35ab829 100644
>>>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> @@ -214,13 +214,22 @@ static void pseries_cpu_die(unsigned int cpu)
>>>>  			msleep(1);
>>>>  		}
>>>>  	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE=
) {
>>>> +		/*
>>>> +		 * If the current state is not offline yet, it means that the
>>>> +		 * dying CPU (which is either in pseries_mach_cpu_die() or in
>>>> +		 * the process of getting there) didn't have a chance yet to
>>>> +		 * call rtas_stop_self() and therefore it's too early to query
>>>> +		 * if the CPU is stopped.
>>>> +		 */
>>>> +		spin_event_timeout(get_cpu_current_state(cpu) =3D=3D CPU_STATE_OFFL=
INE,
>>>> +				   100000, 100);
>>
>> If the CPU state does not go to offline here, you should give up and
>> return online, right? Otherwise I think query-cpu-stopped-state can
>> get confused by CPUs in idle and you get a false positive.
>=20
> Can it get confused? My impression from reading the definition for
> query-cpu-stopped-state in the PAPR is that it will simply return a
> CPU_status value of 2 in that case, meaning that "the processor thread
> is not in the RTAS stopped state", but I don't know much about this.

In QEMU (non-KVM) mode, qcss I think may get confused between H_CEDE
and rtas-stop-self. KVM mode may be okay because H_CEDE is handled in
the kernel.

>> That race can still happen, we would really need a sequence count check
>> over current CPU state to ensure we got a race-free qcss value, but at
>> least a check here should make the race implausible to hit.
>=20
> Actually, since rtas_stop_self() panics if the processor fails to stop
> and also since callers of pseries_cpu_die()=C2=B9 already assume that it =
is
> going to succeed in stopping the CPU (given that the function returns
> void and can't signal an error), a more straightforward way of
> eliminating the race is to simply do this:
>=20
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index 97feb6e79f1a..2331a609f48f 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -215,7 +215,7 @@ static void pseries_cpu_die(unsigned int cpu)
>                 }
>         } else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFL=
INE) {
>=20
> -               for (tries =3D 0; tries < 25; tries++) {
> +               while (true) {
>                         cpu_status =3D smp_query_cpu_stopped(pcpu);
>                         if (cpu_status =3D=3D QCSS_STOPPED ||
>                             cpu_status =3D=3D QCSS_HARDWARE_ERROR)
>=20
>=20
> What do you think?

Yeah I think that may be a good idea, just makes things much simpler.

Thanks,
Nick

=
