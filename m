Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:08:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B2420664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ascii.art.br header.i=@ascii.art.br header.b="wknXmXZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B2420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ascii.art.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ljBk0fPXzDqZl
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 09:07:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ascii.art.br
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ascii.art.br header.i=@ascii.art.br header.b="wknXmXZw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ascii.art.br
 (client-ip=23.83.214.37; helo=cockroach.maple.relay.mailchannels.net;
 envelope-from=tuliom@ascii.art.br; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ascii.art.br
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=ascii.art.br header.i=@ascii.art.br header.b="wknXmXZw";
 dkim-atps=neutral
X-Greylist: delayed 2433 seconds by postgrey-1.36 at bilbo;
 Thu, 01 Nov 2018 09:04:27 AEDT
Received: from cockroach.maple.relay.mailchannels.net
 (cockroach.maple.relay.mailchannels.net [23.83.214.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lj6g41HtzF3L3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 09:04:26 +1100 (AEDT)
X-Sender-Id: dreamhost|x-authsender|tuliom@ascii.art.br
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 1DEBD682407;
 Wed, 31 Oct 2018 22:04:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (unknown [100.96.19.78])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 24CA168348A;
 Wed, 31 Oct 2018 22:04:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|tuliom@ascii.art.br
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
 by 0.0.0.0:2500 (trex/5.16.2); Wed, 31 Oct 2018 22:04:23 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|tuliom@ascii.art.br
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Abiding: 3bf506900ca2e854_1541023462276_2483921906
X-MC-Loop-Signature: 1541023462275:3945271528
X-MC-Ingress-Time: 1541023462275
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (localhost [127.0.0.1])
 by pdx1-sub0-mail-a42.g.dreamhost.com (Postfix) with ESMTP id B8FA97FF53;
 Wed, 31 Oct 2018 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ascii.art.br; h=from:to:cc
 :cc:subject:in-reply-to:references:date:message-id:mime-version
 :content-type; s=ascii.art.br; bh=thFyQQZHfkpX1hE1MIrC/4rpaTw=; b=
 wknXmXZwO1vD7H7g0ioSU232B66SCxTNOhFmUZnJAUxd7sD7KdRmIt/LJw9MvLoM
 jofVJJnIkrPV8sx3uT90vpDh5mce8i5EeRMb0p+5ckDryjUT+UvtBSsqp7MxURMi
 8xVHNTetg+4pNFRgBTXqKtZHMSNlx/HLzhfv75hiK10=
Received: from ascii.art.br (unknown [177.95.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: tuliom@ascii.art.br)
 by pdx1-sub0-mail-a42.g.dreamhost.com (Postfix) with ESMTPSA id BDD2E7FF51;
 Wed, 31 Oct 2018 15:04:19 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a42
From: Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
In-Reply-To: <87in1hlsa7.fsf@oldenburg.str.redhat.com>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <20181031185032.679e170a@naga.suse.cz>
 <877ehyf1cj.fsf@oldenburg.str.redhat.com> <87efc5n73a.fsf@linux.ibm.com>
 <87in1hlsa7.fsf@oldenburg.str.redhat.com>
User-Agent: Notmuch/0.27 (http://notmuchmail.org) Emacs/25.3.1
 (x86_64-redhat-linux-gnu)
Date: Wed, 31 Oct 2018 19:04:14 -0300
Message-ID: <87bm79n57l.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrieeggddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffujghffgffkfggtgesthdtredttdertdenucfhrhhomhepvfhulhhiohcuofgrghhnohcusfhuihhtvghsucforggthhgrughoucfhihhlhhhouceothhulhhiohhmsegrshgtihhirdgrrhhtrdgsrheqnecukfhppedujeejrdelhedrjedvrdefheenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheprghstghiihdrrghrthdrsghrpdhinhgvthepudejjedrleehrdejvddrfeehpdhrvghtuhhrnhdqphgrthhhpefvuhhlihhoucforghgnhhoucfsuhhithgvshcuofgrtghhrgguohcuhfhilhhhohcuoehtuhhlihhomhesrghstghiihdrrghrthdrsghrqedpmhgrihhlfhhrohhmpehtuhhlihhomhesrghstghiihdrrghrthdrsghrpdhnrhgtphhtthhopehlrggsohhgvghrsehlihhnuhigrdhisghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
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
Cc: "Lynn A. Boger" <laboger@linux.ibm.com>, linux-mm@kvack.org,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, 
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Florian Weimer <fweimer@redhat.com> writes:

> * Tulio Magno Quites Machado Filho:
>
>> I wonder if this is restricted to linker that Golang uses.
>> Were you able to reproduce the same problem with Binutils' linker?
>
> The example is carefully constructed to use the external linker.  It
> invokes gcc, which then invokes the BFD linker in my case.

Indeed. That question was unnecessary.  :-D

> Based on the relocations, I assume there is only so much the linker can
> do here.  I'm amazed that it produces an executable at all, let alone
> one that runs correctly on some kernel versions!

Agreed.  That isn't expected to work.  Both the compiler and the linker have
to generate PIE for it to work.

> I assume that the Go toolchain simply lacks PIE support on ppc64le.

Maybe the support is there, but it doesn't generate PIC by default?

-- 
Tulio Magno
