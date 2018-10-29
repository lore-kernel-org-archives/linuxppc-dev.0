Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C211C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 10:25:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0321A20827
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 10:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="eMga+7Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0321A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k9hg6ksCzDrPy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 21:25:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="eMga+7Ju";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::8; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="eMga+7Ju"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k9f328TFzDrNW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 21:22:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540808562;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=sPdtuUhWZvznKC2dk/ok1HzvQSD/4JWza784X15JWhU=;
 b=eMga+7JuwqqhKSqv28qnyd6XjCP2TezbF23wkzGXPOvw0aTgHA22doiK9ofM4Um8mh
 piG236FKokc2LJ4KOmpmkGHmpnqbnFg/munGHnbQ1u3weJ2EbszzMeDilzfv0zFp+J3T
 6FqBMpdAgY/yMdL/T7/5GoVZUge6aOSMmTTCJfN6vY/lDSJlJFo1as+Y0DCSIsEj9LIU
 nvb0tLrbxBHnAPeX1pAZ2Pld42oFQ7b+OjW/sO9O31yhwzHq60qIKmFPdUZIZ4Eb1NcZ
 K0qFInNHZt5xRr5PdwqJYLWGEafkX/8+miSa+V6JX7PJ6/Z1fPN7Pvs2ppgeIBYYjxR5
 eyqQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkJ2hjb/59nI2wnmBb2pgrM62g9yA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:6ddf:9a41:450e:f08b]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9TAMf6QC
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 29 Oct 2018 11:22:41 +0100 (CET)
Subject: arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
Message-ID: <009777be-1025-a309-2804-c76cd00d3947@xenosoft.de>
Date: Mon, 29 Oct 2018 11:22:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
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

Hello,

The latest Git kernel doesn't compile currently because of the following 
error:


   CC      arch/powerpc/kvm/powerpc.o
In file included from arch/powerpc/kvm/powerpc.c:51:0:
arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined 
[-Werror]
  #define TRACE_INCLUDE_PATH .
  ^
In file included from arch/powerpc/kvm/../mm/mmu_decl.h:25:0,
                  from arch/powerpc/kvm/powerpc.c:48:
./arch/powerpc/include/asm/trace.h:224:0: note: this is the location of 
the previous definition
  #define TRACE_INCLUDE_PATH asm
  ^
cc1: all warnings being treated as errors
scripts/Makefile.build:305: die Regel für Ziel 
„arch/powerpc/kvm/powerpc.o“ scheiterte
make[2]: *** [arch/powerpc/kvm/powerpc.o] Fehler 1
scripts/Makefile.build:546: die Regel für Ziel „arch/powerpc/kvm“ scheiterte
make[1]: *** [arch/powerpc/kvm] Fehler 2
Makefile:1052: die Regel für Ziel „arch/powerpc“ scheiterte
make: *** [arch/powerpc] Fehler 2
christian@christian-virtual-machine:~/Downloads/a$ env LANG=C make 
CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc uImage
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   CC      arch/powerpc/kvm/powerpc.o
In file included from arch/powerpc/kvm/powerpc.c:51:0:
arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined 
[-Werror]
  #define TRACE_INCLUDE_PATH .
  ^
In file included from arch/powerpc/kvm/../mm/mmu_decl.h:25:0,
                  from arch/powerpc/kvm/powerpc.c:48:
./arch/powerpc/include/asm/trace.h:224:0: note: this is the location of 
the previous definition
  #define TRACE_INCLUDE_PATH asm
  ^
cc1: all warnings being treated as errors
scripts/Makefile.build:305: recipe for target 
'arch/powerpc/kvm/powerpc.o' failed
make[2]: *** [arch/powerpc/kvm/powerpc.o] Error 1
scripts/Makefile.build:546: recipe for target 'arch/powerpc/kvm' failed
make[1]: *** [arch/powerpc/kvm] Error 2
Makefile:1052: recipe for target 'arch/powerpc' failed
make: *** [arch/powerpc] Error 2

---

I deleted the definition of 'TRACE_INCLUDE_PATH' in 
'arch/powerpc/kvm/trace.h'. After that the kernel compiled without any 
problems.

-- Christian
