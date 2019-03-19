Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BBC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 10:29:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B87206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 10:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B87206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nq6W6BKXzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 21:29:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.105; helo=5.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo69.mail-out.ovh.net (5.mo69.mail-out.ovh.net
 [46.105.43.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nq4l6t50zDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 21:27:49 +1100 (AEDT)
Received: from player756.ha.ovh.net (unknown [10.109.143.24])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id A83814B9A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 11:21:50 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 210223D89D7D;
 Tue, 19 Mar 2019 10:21:43 +0000 (UTC)
Subject: Re: Shift overflow warnings in arch/powerpc/boot/addnote.c on 32-bit
 builds
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 linuxppc-dev@lists.ozlabs.org
References: <c6ba8992-a3f3-2c99-6d6d-7ee9d41a22c5@ilande.co.uk>
 <a02885b8-e865-bbbf-90b8-9db6e279d760@c-s.fr>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bffc54df-1903-174a-50ae-803bb74a3d55@kaod.org>
Date: Tue, 19 Mar 2019 11:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a02885b8-e865-bbbf-90b8-9db6e279d760@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14032372016956017521
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrieeggdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 3/19/19 9:45 AM, Christophe Leroy wrote:
> Hi,
> 
> Le 19/03/2019 à 08:10, Mark Cave-Ayland a écrit :
>> Hi all,
>>
>> Whilst building the latest git master on my G4 I noticed the following shift overflow
>> warnings in the build log for arch/powerpc/boot/addnote.c:
> 
> I guess the problem must have been there for some time. I get the exact same on 4.14.106
> 
> When reverting 284b52c4c6e3 ("powerpc/boot: Add 64bit and little endian support to addnote"), the warnings disappear.


Ouh. This is from the little-endian days. I suppose we are missing a u64 
cast somewhere ? The L suffix seems wrong also.

C. 

> Christophe
> 
> 
>>
>>
>> arch/powerpc/boot/addnote.c: In function ‘main’:
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>>
>>
>>
>> CURRENT HEAD 2019-03-19:
>>
>>    HOSTCC  arch/powerpc/boot/addnote
>> arch/powerpc/boot/addnote.c: In function ‘main’:
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_OFFSET, ns);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
>>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                                                 ^~
>> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
>>       buf[(off) + 1] = (v) & 0xff)
>>                         ^
>> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
>>   #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>>                             ^~~~~~~~
>> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
>>   #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
>>                                                    ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
>>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>>                                         ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
>> [-Wshift-count-overflow]
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                                           ^~
>> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
>>        buf[(off) + 1] = ((v) >> 8) & 0xff)
>>                           ^
>> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
>>   #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
>>                                                   ^~~~~~~~
>> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
>>       PUT_64LE(off, v))
>>       ^~~~~~~~
>> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
>>     PUT_64(ph + PH_FILESZ, nnote2);
>>     ^~~~~~
>>    HOSTCC  arch/powerpc/boot/hack-coff
>>
>>
>>
>> ATB,
>>
>> Mark.
>>

