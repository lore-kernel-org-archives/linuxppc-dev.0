Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB4EC10F0B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F0F2133D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="bCzj/iy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F0F2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YVpl47QqzDqNy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 00:45:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::3; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="bCzj/iy4"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YVd027qSzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 00:37:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554212231;
 s=strato-dkim-0002; d=xenosoft.de;
 h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=OSaMoaorNBzz+ZOfBefeB5jg9FTzakG5/mv1SUv3Ksg=;
 b=bCzj/iy4xeYWVjdudfU7J87cGJN8HYRVy6YfUoN6wI3yV5DRZQEcV3xte/CfbcLOBJ
 e4kziItfjQoS8tjU6n9iujlpd3wz3feXpqNu7P+G5Bo6ZFe1APYWdG6GOFX7nm3YG3zG
 e8tJNqOU9nXidzipNX0CBDYPNqgVZO/q2fa26tf5PfKBXChVd14JDa06FCHsUboDFbln
 lC2CLuTx0pLt/D/t5Vl+I4imL7ntx7+FubdQFOoK0cDR1bgeipfsUD3athXBc2ElT3O+
 ILs36w7/e5q6DnSSWajMsE2HP5lkF6AEU+FglizSD0POEwr/qq4KVpDLiqao8T+PLyH1
 AExw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkHjmyKKK/rcXR1ZP82+wn/3rw0jQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:80df:9973:4a42:68b5]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id k00e1ev32Db9pzv
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 2 Apr 2019 15:37:09 +0200 (CEST)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
Message-ID: <be5cd01d-30d0-8e06-fc63-b17d6da4a098@xenosoft.de>
Date: Tue, 2 Apr 2019 15:37:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

I figured out, that the VLC player doesn't play videos anymore since the 
PowerPC fixes 5.1-3 [1]. VLC plays videos with the RC1 of kernel 5.1 
without any problems.

VLC error messages:

[100ea580] ts demux warning: first packet for pid=1104 cc=0xe
[100ea580] ts demux warning: first packet for pid=1102 cc=0x4
[100ea580] ts demux warning: first packet for pid=1101 cc=0x8
[10109218] core decoder warning: can't get output picture
[10109218] avcodec decoder warning: disabling direct rendering
[10109218] core decoder warning: can't get output picture

----
dmesg: https://bugs.freedesktop.org/attachment.cgi?id=143840

I created a bug report because of the VLC issue with the kernel 5.1-rc2 
and higher today [2]. I got an answer from Michel Dänzer today.

Quote Michel Dänzer:

None of them directly affect the radeon driver.

It's quite likely that this is a PPC specific issue. Your best bet is 
bisecting between rc1 and rc2.

I haven't seen any other similar reports.

----

I was able to remove the PowerPC fixes 5.1-4 and 5.1-3 with the 
following commands:

git revert 6536c5f2c8cf79db0d37e79afcdb227dc854509c -m 1

Output: [master 4b4a8cf] Revert "Merge tag 'powerpc-5.1-4' of 
git://git.kernel.org/pub/scm/linux/kern ... erpc/linux"

git revert a5ed1e96cafde5ba48638f486bfca0685dc6ddc9 -m 1

Output: [master 0c70b7b] Revert "Merge tag 'powerpc-5.1-3' of 
git://git.kernel.org/pub/scm/linux/kern ... erpc/linux"

The removing of the PowerPC fixes 5.1-4 and 5.1-3 has solved the VLC issue.

The problematic code is definitely in the PowerPC fixes 5.1-3 [1].

Please check the PowerPC fixes 5.1-3 [1].

Thanks,

Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc2&id=a5ed1e96cafde5ba48638f486bfca0685dc6ddc9
[2] https://bugs.freedesktop.org/show_bug.cgi?id=110304
