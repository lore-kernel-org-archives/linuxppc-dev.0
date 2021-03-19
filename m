Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:27:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF5264F6C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF5264F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F21p61c5Fz3bsY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 22:27:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=jvi2TjAH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=jvi2TjAH; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F21nh0xkjz30Hn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 22:27:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F21nd6qNNz9sW1;
 Fri, 19 Mar 2021 22:27:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616153222;
 bh=SJUI+cVNBIHGkQbkPGl1xY5RSVIeBRxI+2BmjsUgI08=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=jvi2TjAHo+g4V5RqAc0ASmwglmajEUle6qxrDDiV95pFRFyCwimLPMZxk1ZWWg2c0
 JOonksaHm9cFAI7y8sC3wTZZgdnPcM7z9XAGmcmRIWY+O9agcgmvppzBSDOIBCT1mS
 T0Nr8rkz/miPOI1fjkGEg/yq+7vOGMi/gUR2PFzgQ2DnBFSDxHrg2Jh7UvDdyUQ+w6
 QmgFurfDTVSodkPTDVPgQ3+7Iiymj1ZfvLGbMQCZTbMxWUu32AtbFvEMJ68tvUnQCZ
 geQKYSACKgTSZaLf8fY4hGPHduBcM40dY8YBEQ+fLbXpYRTtvC46Ak2sWeLWcGUrZy
 TYi2Fp6ZEcF7g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] hotplug-cpu.c: show 'last online CPU' error in
 dlpar_cpu_remove()
In-Reply-To: <c2fdbf4e-995b-fec8-7dc3-41beb7d66daa@gmail.com>
References: <20210305173845.451158-1-danielhb413@gmail.com>
 <c2fdbf4e-995b-fec8-7dc3-41beb7d66daa@gmail.com>
Date: Fri, 19 Mar 2021 22:26:59 +1100
Message-ID: <87a6qz8juk.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Henrique Barboza <danielhb413@gmail.com> writes:
> Ping
>
> On 3/5/21 2:38 PM, Daniel Henrique Barboza wrote:
>> Of all the reasons that dlpar_cpu_remove() can fail, the 'last online
>> CPU' is one that can be caused directly by the user offlining CPUs
>> in a partition/virtual machine that has hotplugged CPUs. Trying to
>> reclaim a hotplugged CPU can fail if the CPU is now the last online in
>> the system. This is easily reproduced using QEMU [1].

Sorry, I saw this earlier and never got around to replying.

I'm wondering if we neet to catch it earlier, ie. in
dlpar_offline_cpu().

By the time we return to dlpar_cpu_remove() we've dropped the
cpu_add_remove_lock (cpu_maps_update_done), so num_online_cpus() could
change out from under us, meaning the num_online_cpus() == 1 check might
trigger incorrectly (or vice versa).

Something like the patch below (completely untested :D)

And writing that patch makes me wonder, is == 1 the right check?

In most cases we'll remove all but one thread of the core, but we'll
fail on the last thread. Leaving that core effectively stuck in SMT1. Is
that useful behaviour? Should we instead check at the start that we can
remove all threads of the core without going to zero online CPUs?

cheers


diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 12cbffd3c2e3..498c22331ac8 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -271,6 +271,12 @@ static int dlpar_offline_cpu(struct device_node *dn)
 			if (!cpu_online(cpu))
 				break;
 
+			if (num_online_cpus() == 1) {
+				pr_warn("Unable to remove last online CPU %pOFn\n", dn);
+				rc = EBUSY;
+				goto out_unlock;
+			}
+
 			cpu_maps_update_done();
 			rc = device_offline(get_cpu_device(cpu));
 			if (rc)
@@ -283,6 +289,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				thread);
 		}
 	}
+out_unlock:
 	cpu_maps_update_done();
 
 out:
