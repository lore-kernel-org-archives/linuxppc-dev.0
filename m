Return-Path: <sshtylyov@mvista.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48B232C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 20:22:58 +1000 (EST)
Received: by lags15 with SMTP id s15so830715lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 03:22:55 -0700 (PDT)
Message-ID: <504DBF3D.2000102@mvista.com>
Date: Mon, 10 Sep 2012 14:21:49 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: [PATCH][v3] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
References: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
 <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
 <ED492CCEAF882048BC2237DE806547C9079D9AB9@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <ED492CCEAF882048BC2237DE806547C9079D9AB9@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Bhartiya Anju-B07263 <B07263@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 10-09-2012 6:53, Xie Shaohui-B21989 wrote:

>>> +	/* Workaround for data length mismatch errata */
>>> +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
>>> +		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
>>> +			qc = ata_qc_from_tag(ap, tag);
>>> +			if (qc && ata_is_atapi(qc->tf.protocol)) {
>>> +				u32 hcontrol;
>>> +#define HCONTROL_CLEAR_ERROR	(1 << 27)

>> shouldn't we have this #define be part of the enum that the other
>> HCONTROL_ bits/flags are part of?

> [S.H] do you mean this?

    Apparently not. He said *enum*, not #define.

> #ifdef SATA_FSL_XXX_ERRATUAM

    We don't need that at all.

> #define HCONTROL_CLEAR_ERROR	(1 << 27)
> #endif

MBR, Sergei
