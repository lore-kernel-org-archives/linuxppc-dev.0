Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB3C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:43:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261362064C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ascii.art.br header.i=@ascii.art.br header.b="uL7d+BW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261362064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ascii.art.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lhfm47JdzF3Lg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 08:43:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ascii.art.br
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ascii.art.br header.i=@ascii.art.br header.b="uL7d+BW1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ascii.art.br
 (client-ip=23.83.209.62; helo=fossa.birch.relay.mailchannels.net;
 envelope-from=tuliom@ascii.art.br; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ascii.art.br
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=ascii.art.br header.i=@ascii.art.br header.b="uL7d+BW1";
 dkim-atps=neutral
X-Greylist: delayed 601 seconds by postgrey-1.36 at bilbo;
 Thu, 01 Nov 2018 08:41:21 AEDT
Received: from fossa.birch.relay.mailchannels.net
 (fossa.birch.relay.mailchannels.net [23.83.209.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lhc10bVVzF3KQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 08:41:20 +1100 (AEDT)
X-Sender-Id: dreamhost|x-authsender|tuliom@ascii.art.br
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 4FB523E40ED;
 Wed, 31 Oct 2018 21:23:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (unknown [100.96.33.121])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0190C3E40DC;
 Wed, 31 Oct 2018 21:23:43 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|tuliom@ascii.art.br
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
 by 0.0.0.0:2500 (trex/5.16.2); Wed, 31 Oct 2018 21:23:44 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|tuliom@ascii.art.br
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Lyrical: 6947fb403d921692_1541021024137_1751827036
X-MC-Loop-Signature: 1541021024137:2867470366
X-MC-Ingress-Time: 1541021024136
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (localhost [127.0.0.1])
 by pdx1-sub0-mail-a42.g.dreamhost.com (Postfix) with ESMTP id B1AD47FF42;
 Wed, 31 Oct 2018 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ascii.art.br; h=from:to:cc
 :cc:subject:in-reply-to:references:date:message-id:mime-version
 :content-type:content-transfer-encoding; s=ascii.art.br; bh=OhWH
 tYSSPJuXLZy1tdNhkCrf7Kc=; b=uL7d+BW1YH4nA1+0/T2JKm6J54xx+pScnX/H
 z+DG5ziySbOnITOWWYIuUQiFimJpj3ksdZ+ee+ul+o4uuWVwoUTgaf1DoRlt6toe
 4Eknj0Drv/unxkyndo41W23La6YmhvwPhad9JXYxC0ih61trfH6Q5vj9xWoA+fEA
 V6NphpM=
Received: from ascii.art.br (unknown [177.95.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: tuliom@ascii.art.br)
 by pdx1-sub0-mail-a42.g.dreamhost.com (Postfix) with ESMTPSA id 4DAC37FF46;
 Wed, 31 Oct 2018 14:23:40 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a42
From: Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>
To: Florian Weimer <fweimer@redhat.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
In-Reply-To: <877ehyf1cj.fsf@oldenburg.str.redhat.com>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <20181031185032.679e170a@naga.suse.cz>
 <877ehyf1cj.fsf@oldenburg.str.redhat.com>
User-Agent: Notmuch/0.27 (http://notmuchmail.org) Emacs/25.3.1
 (x86_64-redhat-linux-gnu)
Date: Wed, 31 Oct 2018 18:23:37 -0300
Message-ID: <87efc5n73a.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrieefgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefvuhhlihhoucforghgnhhoucfsuhhithgvshcuofgrtghhrgguohcuhfhilhhhohcuoehtuhhlihhomhesrghstghiihdrrghrthdrsghrqeenucfkphepudejjedrleehrdejvddrfeehnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegrshgtihhirdgrrhhtrdgsrhdpihhnvghtpedujeejrdelhedrjedvrdefhedprhgvthhurhhnqdhprghthhepvfhulhhiohcuofgrghhnohcusfhuihhtvghsucforggthhgrughoucfhihhlhhhouceothhulhhiohhmsegrshgtihhirdgrrhhtrdgsrheqpdhmrghilhhfrhhomhepthhulhhiohhmsegrshgtihhirdgrrhhtrdgsrhdpnhhrtghpthhtoheplhgrsghoghgvrheslhhinhhugidrihgsmhdrtghomhenucevlhhushhtvghrufhiiigvpedt
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
 linuxppc-dev@lists.ozlabs.org, 
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Florian Weimer <fweimer@redhat.com> writes:

> * Michal Such=C3=A1nek:
>
>> On Wed, 31 Oct 2018 18:20:56 +0100
>> Florian Weimer <fweimer@redhat.com> wrote:
>>
>>> And it needs to be built with:
>>>=20
>>>   go build -ldflags=3D-extldflags=3D-pie extld.go
>>>=20
>>> I'm not entirely sure what to make of this, but I'm worried that this
>>> could be a regression that matters to userspace.
>>
>> I encountered the same when trying to build go on ppc64le. I am not
>> familiar with the internals so I just let it be.
>>
>> It does not seem to matter to any other userspace.
>
> It would matter to C code which returns the address of a global variable
> in the main program through and (implicit) int return value.

I wonder if this is restricted to linker that Golang uses.
Were you able to reproduce the same problem with Binutils' linker?

--=20
Tulio Magno
