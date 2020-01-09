Return-Path: <SRS0=9p14=26=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17487C282DD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jan 2020 14:39:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D34520721
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jan 2020 14:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D34520721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47tpfp2LpJzDqZS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2020 01:39:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47tpcn1qqjzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2020 01:38:01 +1100 (AEDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1ipYRV-0003WO-4H; Thu, 09 Jan 2020 15:05:45 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id A3E5F1060CF; Thu,  9 Jan 2020 15:05:44 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
In-Reply-To: <207cef10-3da8-6a52-139c-0620b21b64af@c-s.fr>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
 <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
 <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr>
 <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
 <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de>
 <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr>
 <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
 <207cef10-3da8-6a52-139c-0620b21b64af@c-s.fr>
Date: Thu, 09 Jan 2020 15:05:44 +0100
Message-ID: <87d0bslo7b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 luto@kernel.org, vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe!

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> In do_hres(), I see:
>
> 		cycles = __arch_get_hw_counter(vd->clock_mode);
> 		ns = vdso_ts->nsec;
> 		last = vd->cycle_last;
> 		if (unlikely((s64)cycles < 0))
> 			return -1;
>
> __arch_get_hw_counter() returns a u64 values. On the PPC, this is read 
> from the timebase which is a 64 bits counter.
>
> Why returning -1 if (s64)cycles < 0 ? Does it means we have to mask out 
> the most significant bit when reading the HW counter ?

Only if you expect the HW counter to reach a value which has bit 63
set. That'd require:

uptime		counter frequency

~292 years      1GHz
~ 58 years      5GHz

assumed that the HW counter starts at 0 when the box is powered on.

The reason why this is implemented in this way is that
__arch_get_hw_counter() needs a way to express that the clocksource of
the moment is not suitable for VDSO so that the syscall fallback gets
invoked.

Sure we could have used a pointer for the value and a return value
indicating the validity, but given the required uptime the resulting
code overhead seemed to be not worth it. At least not for me as I'm not
planning to be around 58 years from now :)

Thanks,

        tglx
