Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA3BC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 04:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A6620868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 04:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4wAx+KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A6620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jt0q68Q4zDqJ8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 14:38:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h4wAx+KM"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jszC0BWkzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 14:37:08 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id cv12so9677555plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 21:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=E2J8FCcZICudBVADKm6eTLtEY6cfhmZTKVVTnYMjWvM=;
 b=h4wAx+KMXQyv56jGbe28LksTwtxU8ui9V0UUjEUdzC9Ng6Jb+8kDRiUtMiFCwLvYaA
 Xao6MoF86DoaPZTzsbIWDLSPn9pzf1bPFI4YLpZzPddMcR9dyEYZ7CM5P7VxtnDYW+OB
 dmfiALn9FRC1zA4dRZzdjxpeoTufjJSiZ6T/F4yDTXatnFXZwLbY7XkVxs0UNj7izMGJ
 holbFbJXIwgwsLfipnGUNrntDUbX6X3Tr0HMPRlGrcokvVqHD8rEZnwKewKFDjcU7tsu
 dPw4HkgbMHpy74VuiK8cdeb8korDrekLqXhkI9/NAUJHQ+vkkRyNhJzFjwmWCwympXgq
 lHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=E2J8FCcZICudBVADKm6eTLtEY6cfhmZTKVVTnYMjWvM=;
 b=AJ8u7LgzdaHEUO2eXtAx8A2hy5127fX8A6Y+fZlLx0Pr7cJiIN1Z/T1wSYy8ASWUYa
 o8otvMvIGofdl8PqWwTsImDsZ7bGUpNxu5iML2s3ETMO6IJrUtiYIlVSoCcDYO80HOaS
 gS/ao5YHY+utPJZVWwfrpQ55pu1KlHxIkg1vZGBrR7Ez83wsICrpTgb1SrkNLuwL8uWy
 QjvGndJNjPGUH2Ffn1SrtJQiIjVWiqnhG+riJQDV39fNK7Q7Qj1qySV8lle4x0CXHwz7
 H6PPCwlBlXjg5XRp7i/cB1QDEJi+SsahauXpq9wYKEVLTm2WIkmqtH/L1z2XvBvhRp29
 +SPw==
X-Gm-Message-State: APjAAAUGTGD9hqvihub/e5LrNFyGcNUV83GW8LvIscavYjla3caKWsyP
 L6kjY+yhEloEH1VS+BLsohk=
X-Google-Smtp-Source: APXvYqxob3352s++Kw4hIPaC4lgQEAN2KmtNSAnK1QkCcbZAWKkeOyPF99GItYbRTMw4loMTgeiogw==
X-Received: by 2002:a17:902:e084:: with SMTP id
 cb4mr81560747plb.77.1555389424887; 
 Mon, 15 Apr 2019 21:37:04 -0700 (PDT)
Received: from localhost (61-68-62-84.tpgi.com.au. [61.68.62.84])
 by smtp.gmail.com with ESMTPSA id i24sm69181844pfo.85.2019.04.15.21.37.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Apr 2019 21:37:03 -0700 (PDT)
Date: Tue, 16 Apr 2019 14:36:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
 <87bm1dfog4.fsf@morokweng.localdomain>
In-Reply-To: <87bm1dfog4.fsf@morokweng.localdomain>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555389147.okxbj1prw2.astroid@bobo.none>
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
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thiago Jung Bauermann's on April 11, 2019 9:08 am:
>=20
> Hello,
>=20
> Ping?
>=20
> --=20
> Thiago Jung Bauermann
> IBM Linux Technology Center
>=20
>=20
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>=20
>> When testing DLPAR CPU add/remove on a system under stress,
>> pseries_cpu_die() doesn't wait long enough for a CPU to die:
>>
>> [  446.983944] cpu 148 (hwid 148) Ready to die...
>> [  446.984062] cpu 149 (hwid 149) Ready to die...
>> [  446.993518] cpu 150 (hwid 150) Ready to die...
>> [  446.993543] Querying DEAD? cpu 150 (150) shows 2
>> [  446.994098] cpu 151 (hwid 151) Ready to die...
>> [  447.133726] cpu 136 (hwid 136) Ready to die...
>> [  447.403532] cpu 137 (hwid 137) Ready to die...
>> [  447.403772] cpu 138 (hwid 138) Ready to die...
>> [  447.403839] cpu 139 (hwid 139) Ready to die...
>> [  447.403887] cpu 140 (hwid 140) Ready to die...
>> [  447.403937] cpu 141 (hwid 141) Ready to die...
>> [  447.403979] cpu 142 (hwid 142) Ready to die...
>> [  447.404038] cpu 143 (hwid 143) Ready to die...
>> [  447.513546] cpu 128 (hwid 128) Ready to die...
>> [  447.693533] cpu 129 (hwid 129) Ready to die...
>> [  447.693999] cpu 130 (hwid 130) Ready to die...
>> [  447.703530] cpu 131 (hwid 131) Ready to die...
>> [  447.704087] Querying DEAD? cpu 132 (132) shows 2
>> [  447.704102] cpu 132 (hwid 132) Ready to die...
>> [  447.713534] cpu 133 (hwid 133) Ready to die...
>> [  447.714064] Querying DEAD? cpu 134 (134) shows 2
>>
>> This is a race between one CPU stopping and another one calling
>> pseries_cpu_die() to wait for it to stop. That function does a short bus=
y
>> loop calling RTAS query-cpu-stopped-state on the stopping CPU to verify
>> that it is stopped, but I think there's a lot for the stopping CPU to do
>> which may take longer than this loop allows.
>>
>> As can be seen in the dmesg right before or after the "Querying DEAD?"
>> messages, if pseries_cpu_die() waited a little longer it would have seen
>> the CPU in the stopped state.
>>
>> What I think is going on is that CPU 134 was inactive at the time it was
>> unplugged. In that case, dlpar_offline_cpu() calls H_PROD on that CPU an=
d
>> immediately calls pseries_cpu_die(). Meanwhile, the prodded CPU activate=
s
>> and start the process of stopping itself. The busy loop is not long enou=
gh
>> to allow for the CPU to wake up and complete the stopping process.
>>
>> This can be a problem because if the busy loop finishes too early, then =
the
>> kernel may offline another CPU before the previous one finished dying,
>> which would lead to two concurrent calls to rtas-stop-self, which is
>> prohibited by the PAPR.
>>
>> We can make the race a lot more even if we only start querying if the CP=
U
>> is stopped when the stopping CPU is close to call rtas_stop_self(). Sinc=
e
>> pseries_mach_cpu_die() sets the CPU current state to offline almost
>> immediately before calling rtas_stop_self(), we use that as a signal tha=
t
>> it is either already stopped or very close to that point, and we can sta=
rt
>> the busy loop.
>>
>> As suggested by Michael Ellerman, this patch also changes the busy loop =
to
>> wait for a fixed amount of wall time. Based on the measurements that
>> Gautham did on a POWER9 system, in successful cases of
>> smp_query_cpu_stopped(cpu) returning affirmative, the maximum time spent
>> inside the loop was was 10 ms. This patch loops for 20 ms just be sure.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Analyzed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> I have seen this problem since v4.8. Should this patch go to stable as
>> well?
>>
>> Changes since v2:
>> - Increaded busy loop to 200 iterations so that it can last up to 20 ms
>>   (suggested by Gautham).
>> - Changed commit message to include Gautham's remarks.
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc=
/platforms/pseries/hotplug-cpu.c
>> index 97feb6e79f1a..ac6dc35ab829 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -214,13 +214,22 @@ static void pseries_cpu_die(unsigned int cpu)
>>  			msleep(1);
>>  		}
>>  	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE) =
{
>> +		/*
>> +		 * If the current state is not offline yet, it means that the
>> +		 * dying CPU (which is either in pseries_mach_cpu_die() or in
>> +		 * the process of getting there) didn't have a chance yet to
>> +		 * call rtas_stop_self() and therefore it's too early to query
>> +		 * if the CPU is stopped.
>> +		 */
>> +		spin_event_timeout(get_cpu_current_state(cpu) =3D=3D CPU_STATE_OFFLIN=
E,
>> +				   100000, 100);

If the CPU state does not go to offline here, you should give up and
return online, right? Otherwise I think query-cpu-stopped-state can
get confused by CPUs in idle and you get a false positive.

That race can still happen, we would really need a sequence count check
over current CPU state to ensure we got a race-free qcss value, but at
least a check here should make the race implausible to hit.

Thanks,
Nick

>> =20
>> -		for (tries =3D 0; tries < 25; tries++) {
>> +		for (tries =3D 0; tries < 200; tries++) {
>>  			cpu_status =3D smp_query_cpu_stopped(pcpu);
>>  			if (cpu_status =3D=3D QCSS_STOPPED ||
>>  			    cpu_status =3D=3D QCSS_HARDWARE_ERROR)
>>  				break;
>> -			cpu_relax();
>> +			udelay(100);
>>  		}
>>  	}
>> =20
>=20
>=20
=
