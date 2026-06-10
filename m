Return-Path: <linuxppc-dev+bounces-22428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4855CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:02:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbDCF2CTKz2ysW;
	Thu, 11 Jun 2026 04:02:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781114569;
	cv=none; b=R4fIhw6bBH/63tZvpiv92LZTe34M3fGIdo6EyiDKSm/ySkL2iKzCWqiz3VQB73MG3BBXXiodfMsJTqvweUIrVGOnvq6KdgR+7o5a+rHtZar5Zq1rdRMHPu+Ag6RTBIwZdzj2tcOoOUQVv2iRHgB6ncWUMqX+q9Z1gs4+sRtw9pWstN/bgMuJYyctshWdZa4lPNMMYoLbODDmlPvDy3ZOc0zK8lr4Nr/TaAHVVohCdESAW22/oc4UBCxuBe4KlpGRocCohBikkqBTyCOQEXv486bBT54isfC4ShiQvQTLn5gN/dVw8xP9d3BEI+3sziRmwLtZVvyGx/QgSJwv/G0Ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781114569; c=relaxed/relaxed;
	bh=kBzMtgZnQ0JjubcHgSYpkiu1HFqidm8qbhuirNDbgQA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=McjRm+x3Kzy/x70TLPIDt25m1Z9ygmJvxA2AqJwTN7AoRMFAbiDZm3H+KjfMnUmcY8Mdks0cLeolZ7FyoQMnFvGfHdLP9aWEVDyhSxzHwxPVr60HzW7X+jftzc5NdShlZvSVOJG5TmfTxfQJEr3TwW5HMBzzzgtdYOkC+5O4w5pGcrPSUspe0Fui161HeHxxOBmRCMC0HTMweMxyxNol6H/JgYeT+W7EDWY4zK96ogqmd5J1Xek34IP2iZZphe9sqn52IRkLEfpyjAw6co2RepU3jwpCkSeZXzLbs483kMl1+o5mvDLX/W3x7nrgRw0FLufGg1ho33b07RDM+6Edew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=wEvxdYIl; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=wEvxdYIl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 336 seconds by postgrey-1.37 at boromir; Thu, 11 Jun 2026 04:02:46 AEST
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbDCB16M2z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 04:02:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781114561; x=1781719361; i=markus.elfring@web.de;
	bh=kBzMtgZnQ0JjubcHgSYpkiu1HFqidm8qbhuirNDbgQA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wEvxdYIlE/vigRTwz+ytnZBTKOCGfLuzEXyjbB4IufruPqCRaNVmqemkNCuEEDSD
	 4DOjhmwO4n0sCMs+meIyA4RAtHwKoWo0UaTGqtnHUvNWENR2jv0Nu3EP5l45sjCgW
	 Yt6yUWyLqrLxPYgYgGharbI/DC3tqcjjqbGvcymAW8ZMw32Gw9R+0tMHj7FOswDUe
	 Jkg2VjRwLsHOr6iUJ7kdoxO0oZBtchEk7Gdv4NTv/GjdZ8PosBBd7BzZQT226iBbL
	 KuuTpQ4QTR8A4QCkWcQenfayhody/li6bajs287qDnXTi1FaCxz8yJUpKSoFEcrWN
	 tC7xBc9qeZwp4y1R/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG9DE-1wRrOQ2yce-00AdK4; Wed, 10
 Jun 2026 19:56:42 +0200
Message-ID: <d8fb5bab-e65b-40c5-b4ac-7b0736702990@web.de>
Date: Wed, 10 Jun 2026 19:56:39 +0200
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
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org, Bart Van Assche <bvanassche@acm.org>,
 Christophe Leroy <chleroy@kernel.org>, Kees Cook <kees@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] powerpc/powermac: Use common error handling code in
 kw_i2c_host_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BY2W0mT4VkkXtvo9AE3X5vQgGO15AQ/QpBss8cy8IB9P9dWSZ6M
 Ccpq5xVhPaKo35/yVyuCPVmsSJ4o0k8YcqNBs3dDFU9Z8ZxscqxNGrsQaoVsLpl7DeZJBQp
 Z1Mpj35sFjdGbsV7QUuFnJ+u7gz1Zv09r7CzguBcjr9ABFXHW5yq/FnhR8UkthHyDKhp9pE
 9KdCVVRxEVaC8xvwxnp3A==
UI-OutboundReport: notjunk:1;M01:P0:I8dDuJaDYbI=;s1iDSjga47/I4F/lQT9Bcs4jO7C
 WOv3f83W5Hy9Wa8oUttYG+gOyfk2j4KVbyRopCr7VC0GKFJYuRvUQdxr6PxMQM8YZZE9MWtOn
 YJcScyjqex2cEBwPar29YMPYr+LRpt7nzqCVM3JpKlbLiaUzGNJ774lsH+Z0pO+gzp8Hde3NJ
 ZhVXmHzbcAviHj+oTNBCAmU7yOGaN4wsnoc3I3INZaMrtgFf6/Qh7HS8ehkSNvOazZLP6JrBO
 1nPJrPjIUhq/WLl7E5zYf5CLQA3yWwo+Ljy6zquoP37pP91bZFAH/7XJYh/x379C/mgxFwppG
 FPKV+VeD9kAeR0V9ucgHt921NARj04LdDovcQAGClyOjZohB5bxDJj81U2IYTv40JmOJcNxOa
 4Sm7k5GEOX0UIHzR+nBB5YiHIlHbJKskSYtfVI0oFNsHYR6kxSmiwm5/ca+OWjJ1skSEonf7+
 gLT3hrWkGGZ16p4Q8J18aItz6kuztP9DRdMvZduJU7iGU+EHk2SyAAwPGtABzKOuERDY0+8T8
 yoFQp1XOgsduQudpOhg/EOWNvwfS4Mk23iJCQhaJW8LKKpsvWBLnBuIkAiD2V1UGpHCe2B0x1
 uu9kzx8BO42pYAqaQHRCNvD/RjbLiEIS+euk0wtuDg9HyB+mqbeR2RiKvHe8CCjqDnrWMAvvC
 yC2JSph7XHT93ZF742/Lnpga9YOM8Lghe9+pzNxEmSpWNY57Oehu2vgHm9jYrVBViUR/R4+VN
 na3LPDxGC9TmPbVaq4L4/M44E1bAK0BLuac9ZPWzb0vsKUjcMEfBGdwyeHOePAdhGbpckhy5R
 pxqvRa15xdetfvOKUJNYtAGa9SJMd/ymGoP8yOdGBd5H6A+Kt3ivkD8xWlEp7SmhLKc4Nrgr7
 Dossz5t/9ddWojqDtPUuXHZKReHuWkAMJk3lpsgtwZ43s+w5Lse8OqVZ3KV2/TALNyqkOJmjR
 pmt2bKSQl/yHJnUuwoO0OanAuFpFU5qjZn/XN8GQvcX7c8ELr+Iz8grQuHn6vf1JOcmrN0i/p
 vI+f8qVCLqeIf5r4Qnne84Py4dO2IW6rA/4qmWwPxgOyBHtES0p7XzG+yDKDbWcFm8hTZToYR
 ow59fwGgItepsO3OTk5vRwkun/ANglx1snMuKjaIL0LOQOnwem2fjpp+rNEvDProy/+DaqLJr
 AxhX4g7Ywqrh4g0yBp2kRBDkCSuiFpS4Ej1kPMa8IEx9TPdBIBd5C/O89ReFq4KakvofvTYCk
 wKMBA4zvVrwbZOmZQgxhnB0AiYbyHzADSAXue1BJl+sw1PvocmoQMxHXI3Ia560uNozT6roAS
 Pld4AHp0EMIvF0EaWLODZ4y3AgzuklKMvRWV2pp013m/eNeWho12oFG1KSGYBMdEFItWIpYzL
 /t2Wj2KMG8tAoELDgEYc+C9O5poEVEbZJQN8TQC5vXylL+UOElHtUA0s9ZQs/iz1WuwMhVnzp
 UrDCNaR4hEhLbNiXP1gtR/rucgPCijAgtn0xLAYX2fBDFIczbv2Afq1XKvAGLjZoBO5rZjFgm
 5X7DbJSkKCPZaMbH6EEbD4k7eyCPeuTnHPdKWssMS0h+ICroKDOqvZg4CEyRXyjmEHU97Et/Q
 36UJsL5U+jz8kGGIfoT/f3SgwUSr/mwEpOyDDjgUXbRjcQxY9JRsjdS5Kzp57IXBYZL5wun9e
 014sywwoO3ei5Z38nNKkC2DuzKfYMARY71JuqKVpNtlGIDC/uXQ93vCmcVYPIIA0z344HpA5z
 C1+x00ZQmYpifTjLzeSY9sVW9MUWbFwnQ7/pIsDcrBEdMs+2B17dhKpxvPgO/6LuuqFbr9P06
 NQuMSqj5oqjBo+r6TSEnYnGfVgjWSmRPiwajzJt09l3AlGjoZwcthDLlW2mYlkAejqLkFFleJ
 lmcnXu5EyFQj5uly0vsXlV1KXmGbbfOa78LHgHsnMXMCxj6+7AyZkHGrjy9HzSpgSKs14cJer
 seoUFPaj7sv0da+HqkIpiBOA61QyWPDenxDyLE1DTpfUPhHOkY2F6osyPIJRVj3VZdNM3Q1bo
 8kVcDXr+XkqtAKgQBY5uCPyHH9KFkZwLjvCK4ZCGmbAaXvB65N22eKzJX1S/rEtMoKuak1dQG
 wKoKGQ+y+NVg1lCF3LKb+CucHI5epBAl4zt2oOuFTA/4F6QzsCDtRLeEIcy68dmGFxsBB2drP
 6wsL5JlQIDiFvgTjcke642p3CPdNlcTgj5N+hIxipyxAZCKSamLpezCda8wG0jNvXE4b3HdiA
 w4fjSXyPHar3fqxxCVtqEfpK0pvlRAS0ijfL14SyzUWqykOI+mR1q30CAwy6/Fj5Y/rWo3xC/
 D9S9nP+XAklIZMBWVL+K3DG1e4i1MCOgoxnU7PvcOE2U7kCS/KKI8QYjxx3zfZk7OtZc+wKgv
 A6k90q5h/aAvqESWxubPyDOHZ/jQo5otpKefu/ZQ5fEtmaiGfQw1UFUpIdCmCJ3Q77SysARlD
 M9YplaUBjptohghSGbyv4gio36nkX6JfOkBfUPAlXdUUi2pKeN9FRA2sadBSq1F18c4ZvGab2
 NHQ8KRv+NnwZjWucWArnHOslr6mnOSRbwER9izDL5O5OrsmtFuW+EE2yov7yIcfCX9IyULqgJ
 cm57pEnlcJEr5JGLtVs+2SQ4RJOdk+rD45ruTcCcobA7dsLisQOVRyiJOWEqo+VXgnZ6AVMi+
 AQKw+pdaMNNQonzg3sSB8/W6MAVHMq5pwtFa1xLq5L6f8tfZWyrYiIWGjh6BrhbttyMkmrnJU
 tXGmBOP8xPtqYQten2Ch5vCl1DdKOldIVzci4VDD+KAoc9fJAKHJtYG2X5kK885qW5QaftHHP
 wj1jrcBkkDKcy35Bm7a3qHfTs8Fsa9KS8w7LtZItlMsq2WY5qz+BQrjiEz6uAfObCrF4RqOMK
 oO7rsBkpnwxlj/DUQ8/37txCt8wGbzh+AeAk8h72BA+L78tH0MjYdfDaQifxDIcXNYpfITg0c
 Mo94hgeVzifA4grGih47SWtB2ZtU+iX+nrbIqjZ4GV3H8BBMhmVBnqH56Ttea7H/PhjgBGFSA
 pG6tGgUB9SVCT6A43pPdqOdMF41XWlcPK6bLp2qhjazEAj+SMSTgH3UWy36S5s3gSfMNoOI1o
 TYza3HU+RQ/NoJLR+5yjRpTCAamQL9Vd5NkJZ5FsZBR79+AGdKky0RFRYvvCMFdj4TF3zy3OJ
 VVrHQ5dRK/VtxAoS756HKSBBDJj8ixmb/FcOwLE+dZ12DOC35GfpTFsB6vTX9mtLI5y1uZuVQ
 6lNSOqAgmF5QV6tgMLS+Q2Gst1rdbpih8YZxo6Mz0tEGMICjm0wqfz0lI0vQD6Ip+eph4HanK
 UVCoYWO9WPURDh0BAVI10wMfl4mIOoK4jo+9bXXy08/+7CyzDPMaXCn8Qz7hqpPs4NPMTvsVW
 eetgM9vaHM5MA/88lxw/6QeYoSJe0pDrttJajdHmBQTySuxD0/6j0XaFM2VnHoeJvKZEj/Km5
 XH+/Uri7uoznGVagAdCV/Lgj/TJwjvBR9bCzOyOrMIygBNiaL4Fg72OXDKXoHatFdIUXexnOK
 FdXbA++y/RnXvFyRCEiU0bohcKATwaEWoihVRmRkms+8aLX273fp7WgyGtZF1ikfpknBq5DI+
 0oh4HFKwEGdAAmQC3inwxeWBtz4RjWBo05stlz9uQ6KyJf3JA8ChYDS49Hcrs8JVVaGonePIl
 SkFgN6rDc1Kh5iXf25oZQ4BNlVLJEFP3dkAzN/kSLAWmxrg4HRFpL/a8FoUwYrewAhChFtR8k
 lPtn5dUEjAH0J1YzKcPJFgx4MXfpej+iA96YpPuLbu2IWwHvfLKzF2q5UjtNeUVNKB07uKKn4
 fRVavVqYZ0NON+pdwnha7M21F2803Pyk5KSCnC4pU7tTlW5HrNl97drTeCyajB6UiIthMBnG1
 bA+i84LlJ09AR1YBcCUrXOKe/8sPchzCR9K/Hp1mkO3cRVyzQ6m6XdWZdK1j9zMSrCCDBaBp3
 9BNU+IG+LZXe9YCakKChAT2B+qPGRjPOJAh/lK01GxAzlT6CgzOWcJWV/dHGM+c+WPROhIsXZ
 d0W6a4aeIpANcPAPymm/WAo4VJ9ZwYVau3wMVWKt/rBd1aqhgPLf4ZujNoio7p1jc94frbBJl
 3hxEt0DaH2Qx42/RaBIlzBOiHMXmpD6ZbPbFWoflCsOxfJFs3qPNo37ZFS4xC5lLi6pCozwKV
 2DbxbKX8IqKEUKt+QStDIN8VtkxQQxI1L/QvuaEgkv04jCWgXLY1Yy+FR9bRz34TlCw+cVUyw
 ZeGjIOF3HAuE7nFBImzUUUnv2nxY0BVf4WU7AG/52y+OLDGYNGxD6OMijqsP6LZhZ7GMDRnsX
 VC2t8Dy9kzTB4IpkMb2DFz9gM2ES8xG8sYvKc3qI5gj70Yr7UwxjiYhEH87ZZRnE0xgvRI90i
 BwPjB2PGtKqxzIs4g2IZUIJhb9nJrGc6Hzz7zODXy0hX/RneYeg7IgMxkj/IhAo8ZD4jkHDee
 5TsyNSAUhCvpLuV5ZuZud47j43mfOS5z884jq/AW6Ogy+EntA96faHIn7NPDtzZrZvupsVl/6
 bj5PUtN775zihbAgwL+S69GpkduW0RbbvLv/+1ZysWHogIuBMNS3VSjtmLIjnxbY/FCVUZSJZ
 b5l1tSLeWFRDVwz4IJxAFADI0oMmrzVGQeW4aL1MQZm/EGJusHKF+CQHkIl14uDb/jFn5Mv2d
 /z9otGzOfol23ZMcv3FJTb2B/iURbbShqEpTHtdF7Fjy3lGIpCX+5lFky/DqZ1vpw/j73U3z/
 i8OSPXdpcmWPo7o5ewslhhohcmr8P5q/kdnUlQXDsUMWtsUZFdqyBl8+K8lEb9JYJCCL4SCba
 XHCIlMqcsydQBFFAEvK9cjAIiAi8EHgNHFQoLaimIVXRqccN1nQkAT8gh3tbITE7K/+oQU8e1
 tDBvwUg0xQthk36WLUAkRDxmtUKndhpQA5DM/9TnS8Xn32UabWdNZcADT6UOYqogKQCWGpH8m
 RmUk9hJGFa+29ZIUC52K62XCiYQyYdwT/Jqpmy1ucpVVeYyqGz9un3CHTYYrfxltEqnuU50g6
 mBmY5ngtQ0BuepxyLBjRujqjOboG+a40WaD+0G1Vez2apOczjCjRXMvYiDjLND5yOPt7EwWPy
 GblBhu1WLMs4mZhnhayyCi3pJvzAFdv06yNSK7RVQ5Wy8NS4vZKJct38nVuqUOTbWn+PF5ySn
 i4LKCVVF+FEeBghjMLvSyH7Lgld1wjPfVbTihRdEzyaDGukROsG62o8jb1dGFU3sXpwYqN3g5
 XUkE+rvxmqJSZbbvroM5h7wHjoEgXtXv2TC4pQbnOvuLFpM/AqNz3q0lW9OLs0fHpiV1cn3Ms
 /gMujUgGhC6yH1Ps9iMSXs63ZOq96Kt8Cd8+QvcJWKv9D4b5+CzzlUQMyDfReSnbiUrj0byQh
 OHronp5LHNtRCwtbwG/ilny9hBbRkzdDemgoncdQDFjgH1M+Tjip05rf35BG6mjbMnf0Y+2L5
 Otq1ZGdKGoDye6+HzNVyWhhTuOORFkstxf5JUpicOXeL6Z9FrJxGRp5CeAcey910Zqlqmirfq
 r2QqBtj7BsP2MOii4OHaqiDjpIpopQi0yREFI1jYw+2l0VjK/jtN3hNTaadFN9RDt+SEGoGaN
 Uya7UcaqHz8Kol8EOQ=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 Jun 2026 19:50:08 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powermac/low_i2c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/plat=
forms/powermac/low_i2c.c
index da72a30ab865..8daf389d72e9 100644
=2D-- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -504,8 +504,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_ini=
t(struct device_node *np)
 	if (addrp =3D=3D NULL) {
 		printk(KERN_ERR "low_i2c: Can't find address for %pOF\n",
 		       np);
-		kfree(host);
-		return NULL;
+		goto free_host;
 	}
 	mutex_init(&host->mutex);
 	init_completion(&host->complete);
@@ -540,8 +539,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_ini=
t(struct device_node *np)
 	if (host->base =3D=3D NULL) {
 		printk(KERN_ERR "low_i2c: Can't map registers for %pOF\n",
 		       np);
-		kfree(host);
-		return NULL;
+		goto free_host;
 	}
=20
 	/* Make sure IRQ is disabled */
@@ -559,6 +557,10 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_in=
it(struct device_node *np)
 	       *addrp, host->irq, np);
=20
 	return host;
+
+free_host:
+	kfree(host);
+	return NULL;
 }
=20
=20
=2D-=20
2.54.0


