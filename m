Return-Path: <temerkhanov@yandex.ru>
Received: from smtp3.yandex.ru (smtp3.yandex.ru [213.180.223.87])
	by ozlabs.org (Postfix) with ESMTP id 49EE8DE771
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 01:02:30 +1000 (EST)
Received: from cifronik.21th.com ([62.16.86.116]:31966 "EHLO
	satanklaus.cifronic.local" smtp-auth: "temerkhanov" TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by mail.yandex.ru with ESMTP id S4747707AbYHYPCV
	(ORCPT <rfc822;linuxppc-dev@ozlabs.org>);
	Mon, 25 Aug 2008 19:02:21 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [RFC] Fix level IRQ handling on Xilinx INTC with
	ARCH=powerpc
Date: Mon, 25 Aug 2008 19:02:58 +0400
References: <200808251656.00247.temerkhanov@yandex.ru>
	<fa686aa40808250726q69a40f9crd814ce52685c071b@mail.gmail.com>
In-Reply-To: <fa686aa40808250726q69a40f9crd814ce52685c071b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200808251902.58916.temerkhanov@yandex.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Reply-To: temerkhanov@cifronik.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 August 2008 18:26:54 Grant Likely wrote:
>This
> patch unconditionally adds what is essentially a device specific fixup
> to *every* Linux platform.  I cannot see that flying very far.
>

I know that. But without IRQ_CHIP_UNMASK_ACK set this fixup won'be applied so 
setups that are not affected should work as before.

This problem was already discussed before: 
http://www.nabble.com/Level-IRQ-handling-on-Xilinx-INTC-with-ARCH%3Dpowerpc-td18711173.html

Of course, I can just modify xilinx_intc_unmask() routine to perform 
acknowledge as I did before, but it seems a hack to me.
