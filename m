Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40533C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 07:16:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0F920872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 07:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0F920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nkr04KfXzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 18:16:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ilande.co.uk
 (client-ip=46.43.2.167; helo=mail.default.ilande.uk0.bigv.io;
 envelope-from=mark.cave-ayland@ilande.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ilande.co.uk
Received: from mail.default.ilande.uk0.bigv.io (mail.ilande.co.uk
 [46.43.2.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nkny2MzRzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 18:14:46 +1100 (AEDT)
Received: from [86.188.254.49] (helo=[172.30.1.185])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1h68sz-0007a7-6j; Tue, 19 Mar 2019 07:10:10 +0000
To: linuxppc-dev@lists.ozlabs.org
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <c6ba8992-a3f3-2c99-6d6d-7ee9d41a22c5@ilande.co.uk>
Date: Tue, 19 Mar 2019 07:10:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.188.254.49
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Shift overflow warnings in arch/powerpc/boot/addnote.c on 32-bit
 builds
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
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

Hi all,

Whilst building the latest git master on my G4 I noticed the following shift overflow
warnings in the build log for arch/powerpc/boot/addnote.c:


arch/powerpc/boot/addnote.c: In function ‘main’:
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~



CURRENT HEAD 2019-03-19:

  HOSTCC  arch/powerpc/boot/addnote
arch/powerpc/boot/addnote.c: In function ‘main’:
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro ‘PUT_16BE’
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^~
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro ‘PUT_16BE’
     buf[(off) + 1] = (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro ‘PUT_32BE’
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro ‘PUT_64BE’
 #define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro ‘PUT_16LE’
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >= width of type
[-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                                         ^~
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro ‘PUT_16LE’
      buf[(off) + 1] = ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro ‘PUT_32LE’
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro ‘PUT_64LE’
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro ‘PUT_64’
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
  HOSTCC  arch/powerpc/boot/hack-coff



ATB,

Mark.
