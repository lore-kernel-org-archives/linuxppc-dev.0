Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C9DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 08:48:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072A720854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HM3LPJrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072A720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NmsV659CzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 19:47:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="HM3LPJrd"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NmpN2tXSzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 19:45:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44NmpB2GfVz9v093;
 Tue, 19 Mar 2019 09:45:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=HM3LPJrd; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tj8p1K9Cgy4L; Tue, 19 Mar 2019 09:45:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44NmpB0wHfz9v092;
 Tue, 19 Mar 2019 09:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552985106; bh=LYHSJ12qnvccQhtPzX9QOHO/ZHNYau/eUjo5U7CPX2s=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HM3LPJrde7XoeiIpmxA28YncxRQ+NqDT5gi9et67SM1trklVVH5GGxsc19EjV1ssU
 6tSKbH3Nb2ReL9byTEsGEoHyG2DJ/LAOVexCEgh49tA3XITZuVSN+JvnTt3/UjJ69X
 BaPWQ7vaVYkzAyjdHySQtDK0Sh2wON84cR+bVJHk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 17ED68B74F;
 Tue, 19 Mar 2019 09:45:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1TFpeJMP0beH; Tue, 19 Mar 2019 09:45:06 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E91F38B8BB;
 Tue, 19 Mar 2019 09:45:05 +0100 (CET)
Subject: Re: Shift overflow warnings in arch/powerpc/boot/addnote.c on 32-bit
 builds
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 linuxppc-dev@lists.ozlabs.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <c6ba8992-a3f3-2c99-6d6d-7ee9d41a22c5@ilande.co.uk>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a02885b8-e865-bbbf-90b8-9db6e279d760@c-s.fr>
Date: Tue, 19 Mar 2019 09:45:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <c6ba8992-a3f3-2c99-6d6d-7ee9d41a22c5@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Le 19/03/2019 à 08:10, Mark Cave-Ayland a écrit :
> Hi all,
> 
> Whilst building the latest git master on my G4 I noticed the following shift overflow
> warnings in the build log for arch/powerpc/boot/addnote.c:

I guess the problem must have been there for some time. I get the exact 
same on 4.14.106

When reverting 284b52c4c6e3 ("powerpc/boot: Add 64bit and little endian 
support to addnote"), the warnings disappear.

Christophe


> 
> 
> arch/powerpc/boot/addnote.c: In function ‘main’:
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> 
> 
> 
> CURRENT HEAD 2019-03-19:
> 
>    HOSTCC  arch/powerpc/boot/addnote
> arch/powerpc/boot/addnote.c: In function ‘main’:
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_OFFSET, ns);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                 ^~
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>       buf[(off) + 1] = (v) & 0xff)
>                         ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                             ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                    ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>                                         ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
> [-Wshift-count-overflow]
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                                           ^~
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>                           ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>       PUT_64LE(off, v))
>       ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>     PUT_64(ph + PH_FILESZ, nnote2);
>     ^~~~~~
>    HOSTCC  arch/powerpc/boot/hack-coff
> 
> 
> 
> ATB,
> 
> Mark.
> 
