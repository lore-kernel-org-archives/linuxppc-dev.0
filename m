Return-Path: <SRS0=SG0q=ZT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B8C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 09:42:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADAD20678
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 09:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP1Ytycb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADAD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47NG613K9dzDqkZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 20:42:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::143;
 helo=mail-il1-x143.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rP1Ytycb"; 
 dkim-atps=neutral
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47NG331TGkzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2019 20:40:14 +1100 (AEDT)
Received: by mail-il1-x143.google.com with SMTP id r9so20398236ilq.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2019 01:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NG5PPYHCXoD4PMsdjH9Xjb7nCaC1xI2QRc5PwXvFgog=;
 b=rP1YtycbL0HYJLf2occBphPeth6v1OW4+WEB+HHKa5qWX8VWbNdZNP5O8niSyTMSR5
 QH68xYkDt072ILeY7Hg0r7S5t/OuFO+2gUJRbjac5bmuZJAoBsqu/4CMFLlW4uwU8ga8
 B6H2BiivWpbjBMXUTpmLI3ce+qkt+ZFapvnCFWWdkQYOwzMDAdzTnT/zdMV6W5anR7cx
 QrjGIBTEe1jo0758aUAFc89ZjG2B+B3Uwl9zVougx+VNKKva9Z6t7d+sfxX/iv2im6/b
 QHGflsmC7MKwUZfEug58Mq4Wh0veuSuP0Z4Db9yffKrfQQtnvfzMDqVKou3wKFvXHWDv
 0ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NG5PPYHCXoD4PMsdjH9Xjb7nCaC1xI2QRc5PwXvFgog=;
 b=hwKF7vZ9cTfIia4X1zq5oPxzH6Q+2MiIOwR7P6mwVwjxWjZKqK2kEWcUzaw4LYQS+f
 OBvFZBUHabkOYMBwFqg5n162/pFe5VofWWOXy/opI/DJWTCRnD917vELEeaoTjo47H8X
 drfvpL/xylEzSRMcMmjeMBdf1G1eoRH5TRbG+eUv+R5qUdHTTnjy36mj8Tk+oRdPWvtZ
 Sl9xqDPh6DINPVGrXemrTdjc+6MzW/fr9dlmHckTN/fBimk5Bm3rIyebpW7khYqYsgDe
 qEBUvnSlegu6/nhnG0nr+WctR2lY3IZVggIxpbQxRlyGJzV5wN1lTPp+xQytxvDxopbk
 6cSw==
X-Gm-Message-State: APjAAAWMYMYxhYM1pLwb31pZZEQAkp/cxWmRLIBPOtM0+pa8bKqNeWUk
 VB9Goylv+5eW3Tw13qjyb9QkbF2jCBxr912udvle2A==
X-Google-Smtp-Source: APXvYqxMcbZ/UcmO1RP4Y7bzSz8DiOmfghw8icvRjwqKvalu/qxZ6wCdRn5nw0aFAij+uc/ZxVvN8QHn4MvUj2UH+gE=
X-Received: by 2002:a92:1711:: with SMTP id u17mr45711804ill.192.1574847611536; 
 Wed, 27 Nov 2019 01:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20191120012859.23300-1-oohall@gmail.com>
 <20191120012859.23300-41-oohall@gmail.com>
 <6bb90911-54fa-9f26-ec4d-7538f3303475@ozlabs.ru>
 <20191127092408.5a996f41@bahia.w3ibm.bluemix.net>
 <851d7f28-8698-ec0b-7732-423c0926ce94@linux.ibm.com>
 <20191127103354.0758b079@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191127103354.0758b079@bahia.w3ibm.bluemix.net>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 27 Nov 2019 20:40:00 +1100
Message-ID: <CAOSf1CGjyqOezi0aeyUc3C7mKNtu6WdW1g99nRwDHfDKqt_aHQ@mail.gmail.com>
Subject: Re: [Very RFC 40/46] powernv/npu: Don't drop refcount when looking up
 GPU pci_devs
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 27, 2019 at 8:34 PM Greg Kurz <groug@kaod.org> wrote:
>
>
> If everyone is ok with leaking a reference in the NPU case, I guess
> this isn't a problem. But if we move forward with Oliver's patch, a
> pci_dev_put() would be needed for OpenCAPI, correct ?

Yes, but I think that's fair enough. By convention it's the callers
responsibility to drop the ref when it calls a function that returns a
refcounted object. Doing anything else creates a race condition since
the object's count could drop to zero before the caller starts using
it.

Oliver
