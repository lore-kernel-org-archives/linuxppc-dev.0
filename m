Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF389C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Feb 2022 16:53:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JssfN6H80z3cPP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Feb 2022 03:53:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jssdx0KVLz2xB1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Feb 2022 03:53:08 +1100 (AEDT)
Received: from [192.168.0.2] (ip5f5aee58.dynamic.kabel-deutschland.de
 [95.90.238.88])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D39A661EA1924;
 Mon,  7 Feb 2022 17:53:05 +0100 (CET)
Message-ID: <36ffe02f-b299-2085-108a-5a4551e620fb@molgen.mpg.de>
Date: Mon, 7 Feb 2022 17:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ppc64le: rcutorture warns about improperly set
 `CONFIG_HYPERVISOR_GUEST` and `CONFIG_PARAVIRT`
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Sebastian, dear Paul,


In commit a6fda6dab9 (rcutorture: Tweak kvm options) 
`tools/testing/selftests/rcutorture/configs/rcu/CFcommon` was extended 
by the three selections below:

     CONFIG_HYPERVISOR_GUEST=y
     CONFIG_PARAVIRT=y
     CONFIG_KVM_GUEST=y

Unfortunately, `CONFIG_HYPERVISOR_GUEST` is x86 specific and 
`CONFIG_PARAVIRT` only available on x86 and ARM.

Thus, running the tests on a ppc64le system (POWER8 IBM S822LC), the 
script shows the warnings below:

     :CONFIG_HYPERVISOR_GUEST=y: improperly set
     :CONFIG_PARAVIRT=y: improperly set

Do you have a way, how to work around that?


Kind regards,

Paul
