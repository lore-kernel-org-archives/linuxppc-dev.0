Return-Path: <linuxppc-dev+bounces-16819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A07E9E31B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 01:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBHmq5bxTz2xcB;
	Thu, 12 Feb 2026 12:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770859835;
	cv=none; b=BL30CnAjOQ+m8U6fVPZffspUMiZa3qEt1cKYGIrFf72jSHFPQr1lf6JqrSSNcd8zo1YN8puZ6Krv92rkWbeGyunaIBPdjmQ+nLqEo4cUGSM1jFlR3gr3dtbovyqtId6pW16EY82E/Ea6vnCOA1uP4yPOrDF5b0kOn+Gs7mDDhdi47uqEka26NZNTKWix2gti1rPTftTAMH5Vn4ZSxTOMWjORLq85injJZRBUHgzPVYPzCBgTKnL9uNteas1vht6cZcEv4PgDEUhY2yVfi03uAKnSJwIAugCf5qov6WIJtQLutZb/IpTjDd4qW//RZGX/TxGlMbv0VIl1KUwiAlyCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770859835; c=relaxed/relaxed;
	bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nE9NOQkay/bk69UPYDgYCiEbv19Il2qRJBtSy/E9FCRSFNIKg689wXWb/F5DtDBE9us1iEkomO/CJWcEatK3fgbu9ayDkO/qZxMXo85iT6xIZZKr1tTCtKHIZsYB9C35PkqQhcPWv+wMe9qicmVAPzI6HkhmbIDyiZus9em6ZwY83+jqe2NtKb41sN0TsP4kG9myJCzzg5Q10/5nOUrJDCFP0Qc7aWajspB/JObAPs3TJmtIuBBr+tDeUBPTLCz8IUGI1T7/rvZmDJpPbsb2P03VXq49I3WTiGvDrDfcBlMnBp5HOLbcWxaBIfM6b8e67aNErcmVxgjkHHjtzH9smw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AstQJRbp; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AstQJRbp; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AstQJRbp;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AstQJRbp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBHmp4d8Wz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2026 12:30:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770859828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
	b=AstQJRbpgZMBDfedPSvIG3Xnm5M2B//WLIDQk+TQjtOT3E6HivpB5auxwSEoGzSe4NadKB
	4VX0yKUdUPfE+Bo5cB8Zvun30ncCADH3u1Nmka9q4M8pdlDxKVaJGgVOJpoBiAOn5fAxAe
	d9b0KsQkGsIPO7slZKuV4rPPHflHXtk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770859828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
	b=AstQJRbpgZMBDfedPSvIG3Xnm5M2B//WLIDQk+TQjtOT3E6HivpB5auxwSEoGzSe4NadKB
	4VX0yKUdUPfE+Bo5cB8Zvun30ncCADH3u1Nmka9q4M8pdlDxKVaJGgVOJpoBiAOn5fAxAe
	d9b0KsQkGsIPO7slZKuV4rPPHflHXtk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-PtFB9CWdPe2FNGtpWKD-_w-1; Wed, 11 Feb 2026 20:30:26 -0500
X-MC-Unique: PtFB9CWdPe2FNGtpWKD-_w-1
X-Mimecast-MFC-AGG-ID: PtFB9CWdPe2FNGtpWKD-_w_1770859826
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e1dab2235so908634a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 17:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770859825; x=1771464625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
        b=sKOTRo/f1C2Oo2yPnTugjtpipGqaGQPmCQ3IX266ETfU1aSR9tJhu3OIjcVTPW9ZBZ
         vbIsbu2QtbB8EYTnoDp3lIWniGV1KWuG2vOy0GWwp3684ccy3I8soiPMMMWxePAR0igK
         2HOZzY/yFj7umDvKPoiRVw6HRT01ivjiBs8nunRqeVkpsWNBFH1fLmzvVK7WBGFOoIWt
         n9Ug4SDX2ufUU4ysg0zubq1Y0n648LllIe142OYulp28r4fwDug9perw9dCxDbVBYo5L
         YVo1pcj83neC8ig4BbbxDhF6UiByUR85gJk8FaXkQzkoAwfr01trL8fKJx23sjnTV28+
         2M8A==
X-Forwarded-Encrypted: i=1; AJvYcCVwsikBjXikwx43bTbcCymx19wUY4dgF7cepLBmkimPwyUE0pVzEClvWEXwWVcKpsOsOQ4NJtnjcWLFn4c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz77qTmAn7ysgPBKGlmgGwCHyehhpl8OLKRemm/59q0DBO1lcEu
	r1VwhtLXPwaIAsKSJv6cuj2SUhEkdvoD2R9/+uOTEvdTpW897tdJyHTRE1B/+/USrwnuuBsZ7Fm
	IJeLuw2zNN3xTcEWsIS7qVd7C+bfLCMO56VTw/e93FfPSMQWDNv+MUQXs4vhUIrwebv0=
X-Gm-Gg: AZuq6aLzw6Gv1G7JNZP6ZbDK3gU5PIUc+enTZmGKaA4Gd0RF1AmJHJYG5UsAI9Bp+wp
	Hg5PegKhIhA83xwZCTGdp5cDpB1aY/FazP2WywjJ3tggx2xQB1QER/yBGrajYQyJqV1v+CCyLB6
	r5EEqDFfmLhDurbHO16//5yfLcET6ANZDMiFaII9exucgIZzmTpl/vlgk16soW9hXBtbGJcqgyU
	DSUHUTQZmIg/t1vvxdWAJa4Ve1ygHq9OU5C535BsUb4LtyG+ZoHbQ3rB+e0wZDhoBST1YWtDqS0
	xLgxg0I+vrRjqN6iSpL9cb0bmgOcOfFN4U4+KjIN9ihffSbjcC7M8eIAE1aXfptzC+FJm033rfm
	UM+r5mekmoUnu
X-Received: by 2002:a05:6a20:e20d:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-3944887601cmr937845637.55.1770859825453;
        Wed, 11 Feb 2026 17:30:25 -0800 (PST)
X-Received: by 2002:a05:6a20:e20d:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-3944887601cmr937804637.55.1770859824883;
        Wed, 11 Feb 2026 17:30:24 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197f7e0bsm3248413a12.27.2026.02.11.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:30:24 -0800 (PST)
Date: Thu, 12 Feb 2026 09:28:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Egorenkov <egorenar@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aY0rZp9ROwfjPgD8@Rk>
References: <20260203041434.872784-1-coxu@redhat.com>
 <20260203041434.872784-2-coxu@redhat.com>
 <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f3ynkbwW9oFddtRKB4dVQkL4LPPV4ZTt1qCuDEOvCJo_1770859826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 09, 2026 at 03:43:08PM -0500, Mimi Zohar wrote:
>On Tue, 2026-02-03 at 12:14 +0800, Coiby Xu wrote:
>> EVM and other LSMs need the ability to query the secure boot status of
>> the system, without directly calling the IMA arch_ima_get_secureboot
>> function. Refactor the secure boot status check into a general function
>> named arch_get_secureboot.
>>
>> Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  Other than unnecessarily splitting a line, the patch set looks
>good.  As soon as the open window closes, I'll queue these patches for linux-
>next.

Hi Mimi, thanks for reviewing the patch set! Would you like me to send a
new version with the line splitting issue fixed?

>
>> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
>> index 138029bfcce1..27521d665d33 100644
>> --- a/security/integrity/ima/ima_efi.c
>> +++ b/security/integrity/ima/ima_efi.c
[...]
>>  {
>> -	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
>> +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
>> +	    arch_get_secureboot()) {
>
>No need to split the line here or below.
>
>
>>  		if (IS_ENABLED(CONFIG_MODULE_SIG))
>>  			set_module_sig_enforced();
>>  		if (IS_ENABLED(CONFIG_KEXEC_SIG))
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 5770cf691912..6d093ac82a45 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -949,8 +949,8 @@ static int ima_load_data(enum kernel_load_data_id id, bool contents)
>>
>>  	switch (id) {
>>  	case LOADING_KEXEC_IMAGE:
>> -		if (IS_ENABLED(CONFIG_KEXEC_SIG)
>> -		    && arch_ima_get_secureboot()) {
>> +		if (IS_ENABLED(CONFIG_KEXEC_SIG) &&
>> +		    arch_get_secureboot()) {
>
>===>
>
>Mimi
>
>>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>>  			return -EACCES;
>>  		}
>

-- 
Best regards,
Coiby


