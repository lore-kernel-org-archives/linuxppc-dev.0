Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA302C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 11:50:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C75820855
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 11:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C75820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d7yv4wVjzDqM7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 21:50:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d7x25gQTzDqKb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 21:48:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44d7x14RKcz9sPp;
 Mon,  8 Apr 2019 21:48:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/configs: Enable CONFIG_USB_XHCI_HCD by default
In-Reply-To: <15427d53-0008-7958-6b7c-914820f042c5@redhat.com>
References: <1549885032-15702-1-git-send-email-thuth@redhat.com>
 <20190212103129.19de0cfc@umbus.fritz.box>
 <15427d53-0008-7958-6b7c-914820f042c5@redhat.com>
Date: Mon, 08 Apr 2019 21:48:52 +1000
Message-ID: <87lg0kyaxn.fsf@concordia.ellerman.id.au>
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
Cc: Laurent Vivier <lvivier@redhat.com>, David Gibson <dgibson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thomas Huth <thuth@redhat.com> writes:
> On 12/02/2019 00.31, David Gibson wrote:
>> On Mon, 11 Feb 2019 12:37:12 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>> 
>>> Recent versions of QEMU provide a XHCI device by default these
>>> days instead of an old-fashioned OHCI device:
>>>
>>>  https://git.qemu.org/?p=qemu.git;a=commitdiff;h=57040d451315320b7d27
>>>
>>> So to get the keyboard working in the graphical console there again,
>>> we should now include XHCI support in the kernel by default, too.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> 
>> Wow, we didn't before?  That's bonkers.
>> 
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> 
>>> ---
>>>  arch/powerpc/configs/pseries_defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
>>> index ea79c51..62e12f6 100644
>>> --- a/arch/powerpc/configs/pseries_defconfig
>>> +++ b/arch/powerpc/configs/pseries_defconfig
>>> @@ -217,6 +217,7 @@ CONFIG_USB_MON=m
>>>  CONFIG_USB_EHCI_HCD=y
>>>  # CONFIG_USB_EHCI_HCD_PPC_OF is not set
>>>  CONFIG_USB_OHCI_HCD=y
>>> +CONFIG_USB_XHCI_HCD=y
>>>  CONFIG_USB_STORAGE=m
>>>  CONFIG_NEW_LEDS=y
>>>  CONFIG_LEDS_CLASS=m
>>> -- 
>>> 1.8.3.1
>
> Ping?

Sorry, will pick it up.

cheers
