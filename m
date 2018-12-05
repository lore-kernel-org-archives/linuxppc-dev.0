Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DFFC07E85
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6672133F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="IVdR8xul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6672133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438v774XW9zDqPd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:48:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="IVdR8xul";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::3; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="IVdR8xul"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438v2d2LlLzDqpB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 20:44:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544003059;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Us0Y6iG1zqYJFobUUSTAv7ZQZM1Eimv3YTkHhrcbeVI=;
 b=IVdR8xuloItY1B1Zr/axXQfYWaH6Qj71QVf+4CsyQToAyS6su1NDSBvEBA5gwtq+KO
 0yYG5uVoeKvA2Not5tBXP5MKMG8cCXYJgXYH2/Ebv0NINLaBXXgTfw9ECs7O4ORhTJ/3
 QjBUBW8tK7GtpFWoATvwIAn5AjrpZhLMU78+JQLV6c61HMjuhkCz9pJvIXlS9+LlC8Jm
 Ilj6WqCdntF46yq6GWRVxg/lL0jZU2uo4okyfcF6YvBuTER0TFKIK0SupD1kVECPtfxH
 0CSb20+xso+gKlYYE3gzrBGqrbkIBIQLPZhthJFuwkRQmKbGoSmx/RZI+/n5of8edE63
 IxIg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkJh/ARs/ll0LP9pYXILmPj+77/lQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:6972:d6c3:ba77:3810]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uB59i6eZb
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Wed, 5 Dec 2018 10:44:06 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
Date: Wed, 5 Dec 2018 10:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204142426.GA2743@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04 December 2018 at 3:24PM, Christoph Hellwig wrote:
> On Tue, Dec 04, 2018 at 10:53:39AM +0100, Christian Zigotzky wrote:
>> I don't know why this kernel doesn't recognize the hard disks connected to
>> my physical P5020 board and why the onboard ethernet on my PASEMI board
>> doesn't work. (dma_direct_map_page: overflow)
> Do you know if this actually works for the baseline before my patches?
> E.g. with commit 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97 ?
>
Hi Christoph,

Thanks for your reply. I undid all dma mapping commits with the 
following command:

git checkout 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97

After that I compiled the kernels with this code for my P5020 board 
(Cyrus) and for my PASEMI board (Nemo) today.

Result: PASEMI onboard ethernet works again and the P5020 board boots.

It seems the dma mapping commits are the problem.

@All
Could you please test Christoph's kernel on your PASEMI and NXP boards? 
Download:

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian

