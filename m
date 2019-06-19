Return-Path: <SRS0=CHEA=US=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E614C31E5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 10:16:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB60121479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUDCIHmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB60121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TLTV4vltzDqpB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 20:16:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FUDCIHmF"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TLRL1snczDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 20:14:53 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id t16so9444714pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=6i/GeqDjrWmWov4kQahlGNOB5ZKJs7UV4GwUkEvu3yE=;
 b=FUDCIHmFiUaivC6kaQ3sYLdpKaBpcxhLQ9X2o5L+O94uzKtvv9zvu60l2fomkBKnV/
 9QPowqfeNME5ed0XLxG3s3/PQjhBJflMH9euC8V69JQCPWUq5/Rq+LFzBKwjPlfyXifz
 XMM7uqD1JdmNFPCw6NWSRyGdZGdVFGUkj9JeIKG6xmWy1XDD7L0YQpj4L3R/snt1oquS
 zmhDk2R2Qh/xU0Nob8jwT+HG667MtRGcui31L613/u7+O2Xc6/IyKQ/u57oAkTKWxExh
 B6BwwQEeXQfdkV1CiJNXdRtEIKJuLSYKH6hFQN49zdHXaExlalQ/brt1zRyLDPOZ1DMh
 wtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=6i/GeqDjrWmWov4kQahlGNOB5ZKJs7UV4GwUkEvu3yE=;
 b=hknBGYfTCCBtlnxH0EdKlwuLiyF8uShsct8TeLae9C6T/JzcAj103GPNVn1Kv0PUlN
 jYfj0txxBTxoWAs1kpDdjnORuAfJiev3AIYuscIuPv/65+b6B2Hi1oGXc3Vd2REgSv0l
 DmPX7n5ffgw86pH7VhlxhedUM7NOfcUHu6clgYNwpwOA+5LVgMMJ7rCUeTl+tL8Mr5dn
 zz/eVZID0TfXVXKBN+NFv7weVKNQ3GI+vdn3XSVlP76SWbSdYApDGNPeuIXao1Os1t5C
 Sw0OyVSzhSvadkopZb4yEqoT84y+HqjWHLgjtb4x03WnePwJaX+8zbeHnvT9oqCDUqtL
 XbXw==
X-Gm-Message-State: APjAAAX/NbNIZ0W8+5FLKeTyV+/u0R8NO3gRJ8ct5mZSpwmRWNu19B/Z
 bxBwz3JCetqO2zsRXIWNqdY=
X-Google-Smtp-Source: APXvYqwwcbJwmLM8R4kXz9EDK8fOmfB/NTHOIXIR8Nghol24uNK6j1dHGi22a8Jur1GfGfSK0OwCDg==
X-Received: by 2002:aa7:82cd:: with SMTP id
 f13mr129011930pfn.203.1560939289993; 
 Wed, 19 Jun 2019 03:14:49 -0700 (PDT)
Received: from localhost (193-116-92-108.tpgi.com.au. [193.116.92.108])
 by smtp.gmail.com with ESMTPSA id r1sm14141972pfq.100.2019.06.19.03.14.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 03:14:49 -0700 (PDT)
Date: Wed, 19 Jun 2019 20:09:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/1] cpuidle-powernv : forced wakeup for stop states
To: Abhishek <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190617095648.18847-1-huntbag@linux.vnet.ibm.com>
 <20190617095648.18847-2-huntbag@linux.vnet.ibm.com>
 <1560917320.mk5nn6r8jw.astroid@bobo.none>
 <689a52a7-7bfc-7225-e563-ac07f7357e75@linux.vnet.ibm.com>
In-Reply-To: <689a52a7-7bfc-7225-e563-ac07f7357e75@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560938644.5ukemauqsy.astroid@bobo.none>
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
Cc: ego@linux.vnet.ibm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Abhishek's on June 19, 2019 7:08 pm:
> Hi Nick,
>=20
> Thanks for the review. Some replies below.
>=20
> On 06/19/2019 09:53 AM, Nicholas Piggin wrote:
>> Abhishek Goel's on June 17, 2019 7:56 pm:
>>> Currently, the cpuidle governors determine what idle state a idling CPU
>>> should enter into based on heuristics that depend on the idle history o=
n
>>> that CPU. Given that no predictive heuristic is perfect, there are case=
s
>>> where the governor predicts a shallow idle state, hoping that the CPU w=
ill
>>> be busy soon. However, if no new workload is scheduled on that CPU in t=
he
>>> near future, the CPU may end up in the shallow state.
>>>
>>> This is problematic, when the predicted state in the aforementioned
>>> scenario is a shallow stop state on a tickless system. As we might get
>>> stuck into shallow states for hours, in absence of ticks or interrupts.
>>>
>>> To address this, We forcefully wakeup the cpu by setting the
>>> decrementer. The decrementer is set to a value that corresponds with th=
e
>>> residency of the next available state. Thus firing up a timer that will
>>> forcefully wakeup the cpu. Few such iterations will essentially train t=
he
>>> governor to select a deeper state for that cpu, as the timer here
>>> corresponds to the next available cpuidle state residency. Thus, cpu wi=
ll
>>> eventually end up in the deepest possible state.
>>>
>>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>>> ---
>>>
>>> Auto-promotion
>>>   v1 : started as auto promotion logic for cpuidle states in generic
>>> driver
>>>   v2 : Removed timeout_needed and rebased the code to upstream kernel
>>> Forced-wakeup
>>>   v1 : New patch with name of forced wakeup started
>>>   v2 : Extending the forced wakeup logic for all states. Setting the
>>> decrementer instead of queuing up a hrtimer to implement the logic.
>>>
>>>   drivers/cpuidle/cpuidle-powernv.c | 38 ++++++++++++++++++++++++++++++=
+
>>>   1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidl=
e-powernv.c
>>> index 84b1ebe212b3..bc9ca18ae7e3 100644
>>> --- a/drivers/cpuidle/cpuidle-powernv.c
>>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>>> @@ -46,6 +46,26 @@ static struct stop_psscr_table stop_psscr_table[CPUI=
DLE_STATE_MAX] __read_mostly
>>>   static u64 default_snooze_timeout __read_mostly;
>>>   static bool snooze_timeout_en __read_mostly;
>>>  =20
>>> +static u64 forced_wakeup_timeout(struct cpuidle_device *dev,
>>> +				 struct cpuidle_driver *drv,
>>> +				 int index)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i =3D index + 1; i < drv->state_count; i++) {
>>> +		struct cpuidle_state *s =3D &drv->states[i];
>>> +		struct cpuidle_state_usage *su =3D &dev->states_usage[i];
>>> +
>>> +		if (s->disabled || su->disable)
>>> +			continue;
>>> +
>>> +		return (s->target_residency + 2 * s->exit_latency) *
>>> +			tb_ticks_per_usec;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>> It would be nice to not have this kind of loop iteration in the
>> idle fast path. Can we add a flag or something to the idle state?
> Currently, we do not have any callback notification or some feedback that
> notifies the driver everytime some state is enabled/disabled. So we have
> to parse everytime to get the next enabled state.

Ahh, that's why you're doing that.

> Are you suggesting to
> add something like next_enabled_state in cpuidle state structure itself
> which will be updated when a state is enabled or disabled?

Hmm, I guess it normally should not iterate over more than one state
unless some idle states are disabled.

What would have been nice is each state just have its own timeout
field with ticks already calculated, if that could be updated when
a state is enabled or disabled. How hard is that to add to the
cpuidle core?

>>> +
>>>   static u64 get_snooze_timeout(struct cpuidle_device *dev,
>>>   			      struct cpuidle_driver *drv,
>>>   			      int index)
>>> @@ -144,8 +164,26 @@ static int stop_loop(struct cpuidle_device *dev,
>>>   		     struct cpuidle_driver *drv,
>>>   		     int index)
>>>   {
>>> +	u64 dec_expiry_tb, dec, timeout_tb, forced_wakeup;
>>> +
>>> +	dec =3D mfspr(SPRN_DEC);
>>> +	timeout_tb =3D forced_wakeup_timeout(dev, drv, index);
>>> +	forced_wakeup =3D 0;
>>> +
>>> +	if (timeout_tb && timeout_tb < dec) {
>>> +		forced_wakeup =3D 1;
>>> +		dec_expiry_tb =3D mftb() + dec;
>>> +	}
>> The compiler probably can't optimise away the SPR manipulations so try
>> to avoid them if possible.
> Are you suggesting something like set_dec_before_idle?(in line with
> what you have suggested to do after idle, reset_dec_after_idle)

I should have been clear, I meant don't mfspr(SPRN_DEC) until you
have tested timeout_tb.

>>> +
>>> +	if (forced_wakeup)
>>> +		mtspr(SPRN_DEC, timeout_tb);
>> This should just be put in the above 'if'.
> Fair point.
>>
>>> +
>>>   	power9_idle_type(stop_psscr_table[index].val,
>>>   			 stop_psscr_table[index].mask);
>>> +
>>> +	if (forced_wakeup)
>>> +		mtspr(SPRN_DEC, dec_expiry_tb - mftb());
>> This will sometimes go negative and result in another timer interrupt.
>>
>> It also breaks irq work (which can be set here by machine check I
>> believe.
>>
>> May need to implement some timer code to do this for you.
>>
>> static void reset_dec_after_idle(void)
>> {
>> 	u64 now;
>>          u64 *next_tb;
>>
>> 	if (test_irq_work_pending())
>> 		return;
>> 	now =3D mftb;
>> 	next_tb =3D this_cpu_ptr(&decrementers_next_tb);
>>
>> 	if (now >=3D *next_tb)
>> 		return;
>> 	set_dec(*next_tb - now);
>> 	if (test_irq_work_pending())
>> 		set_dec(1);
>> }
>>
>> Something vaguely like that. See timer_interrupt().
> Ah, Okay. Will go through timer_interrupt().

Thanks,
Nick

=
