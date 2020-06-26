Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF3C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 09:50:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43E121531
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 09:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9E4RANf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNmCe82S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43E121531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tXFW4MgnzDr1Y
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 19:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=b9E4RANf; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WNmCe82S; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tXCc5CnlzDqxq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 19:49:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593164950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Efxbz4+IL7hOT9q8C3wqr1PbduZKxqRf8f3jF7MlDLo=;
 b=b9E4RANfxb7bVvLOliUNhilHwXAk465aZImdovEF8qbj5hnF1S4cD1w6j1XWVNR0RR1GeH
 Zm0BPnqAMc18bVadaiT1dEFX8JShes/ZAltc3MAD8n3z/3V36mdM9Q1ZRfOOvWutlNRJzs
 CBdLZe+KlrIRIU1uoB6RJnmcEkOgMKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593164951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Efxbz4+IL7hOT9q8C3wqr1PbduZKxqRf8f3jF7MlDLo=;
 b=WNmCe82SEQwp39D5rt7wmtjQWyf+wGM0eImjJTyHt4wbMd+cKopUka4aGIaRiOCdKP0EYz
 hmbdJP6wMtqHX+Q2hvhQ8eYKELpWvnf2a/zrPMLMWE/YnR7VYOrzu9UpqKe4gbzUQM3zy3
 O/JcD7ofYVPWkuOoTuxKuRi8HiBzgUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-49VZyMssMHKKSqBXvTkyAA-1; Fri, 26 Jun 2020 05:49:07 -0400
X-MC-Unique: 49VZyMssMHKKSqBXvTkyAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A89BB8015F7;
 Fri, 26 Jun 2020 09:49:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A05EF512FE;
 Fri, 26 Jun 2020 09:49:05 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3B9DC87581;
 Fri, 26 Jun 2020 09:49:05 +0000 (UTC)
Date: Fri, 26 Jun 2020 05:49:04 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <240479777.18793651.1593164944980.JavaMail.zimbra@redhat.com>
In-Reply-To: <a55e7ccd-09e8-726a-21d2-02b00b48d857@linux.ibm.com>
References: <2065283975.18780128.1593154755849.JavaMail.zimbra@redhat.com>
 <ac99e243-0945-8be0-6ae4-73af29b7a199@linux.ibm.com>
 <a55e7ccd-09e8-726a-21d2-02b00b48d857@linux.ibm.com>
Subject: Re: [bug] LTP mmap03 stuck in page fault loop after c46241a370a6
 ("powerpc/pkeys: Check vma before returning key fault error to the user")
MIME-Version: 1.0
X-Originating-IP: [10.43.17.25, 10.4.195.3]
Thread-Topic: LTP mmap03 stuck in page fault loop after c46241a370a6
 ("powerpc/pkeys: Check vma before returning key fault error to the user")
Thread-Index: +SQgQTzsoh7wIMXbpIdarpEWA6mgnA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Rachel Sibley <rasibley@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 sandipan@linux.ibm.com, linuxram@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



----- Original Message -----
> Can you check with this change? While checking for access permission we
> are checking against UAMOR value which i think is wrong. We just need to
> look at the AMR and IAMR values to check whether access is permitted or
> not. Even if UAMOR deny the userspace management of the key, we should
> do the correct access check.
> 
> modified   arch/powerpc/mm/book3s64/pkeys.c
> @@ -353,9 +353,6 @@ static bool pkey_access_permitted(int pkey, bool
> write, bool execute)
>   	int pkey_shift;
>   	u64 amr;
> 
> -	if (!is_pkey_enabled(pkey))
> -		return true;
> -
>   	pkey_shift = pkeyshift(pkey);
>   	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
>   		return true;
> 

This change fixes it for me. mmap03 and reproducer from previous
email no longer get stuck.

Thanks,
Jan

