Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FACC282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:01:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D147C2084A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRju4zgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D147C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rwdz6HYRzDqjN
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:01:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRju4zgM"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rwbq2DW8zDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 11:59:34 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id p4so787395plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 16:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HMW/FMkhqaB4zEYchULm6MpORv5yMKsYsiw2e9nQxZA=;
 b=eRju4zgM9xFXZyfOwiLeuoAGZx+DaB08Xje1nxEDUvTWOXoqtVrswEabbpDH8WkI+j
 WAK2wH43J0T0698kLjnrDIMckEqQ75gdhd2JMBRyFbLN+blE8UiDNuHYq/bTZosWlBNH
 mOVYKSmzcoJRug7V6F9EHXAQL/Sl6ijx88T68T/n7TivJQL2Hd61C+cy7RxgLmWK0BHJ
 Z3qlVXDoWFceYtWU89T2T16z3BiRW8wtCFGqo9Ov1JakAl5KeqHpQHXAsdLP/RYYP8oz
 pcIEMfckcd83Z5kF6PfDhig9iseafg22oSbiwNccfF5z/PQTOVHuWlWY+FO2U/EBcnwB
 vdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HMW/FMkhqaB4zEYchULm6MpORv5yMKsYsiw2e9nQxZA=;
 b=aF1Abu7iRFLJDg8m19s0ml864YXH/6y/+RgSTo8E7xhBDoXDSpXKPZG3+YYdVvCg1u
 PZLrMsuaZiHlM4D+kCqn3EdeD9QzN8UPNbDsFFYF2pmM7iuUyFtkMSG23tZ+5hNBGdUU
 bttWzduxQlt22UmcOg8EvIe76KzzFMKO1OVRRA68yjUU8Gac3LUEH3VuWAW1eLcDh1M0
 9LsuAk2JjSaj9OccQoHuLEpIVOLGeYcnEMtDlE51PobcAMqignQtLEh4itF1kwLjG4LG
 WHgArMM0z/Kom2/juqQzKkAT1+45xUWZpfYdbIuTgKOmrdVERkPauZ1HEZvUsZcwe9tb
 1ZMg==
X-Gm-Message-State: AJcUukfQrxPl0EPe69bG1/1fQpIAlUnYWVrxlr+WySS9D44w3JNQc7zE
 NefeI4nmJBw0fybmfwVM/Eg=
X-Google-Smtp-Source: ALg8bN7otX5werawFMy+3MlBIphh87r2CkXXWRYvktP8EwiieKjqBuYmkHq+dOy0dcEiNrAFZ+Dl5Q==
X-Received: by 2002:a17:902:5066:: with SMTP id
 f35mr42177714plh.78.1549069172103; 
 Fri, 01 Feb 2019 16:59:32 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 l82sm8592561pfg.127.2019.02.01.16.59.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 16:59:31 -0800 (PST)
Date: Sat, 2 Feb 2019 11:59:28 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 4/4] powerpc/livepatch: return -ERRNO values in
 save_stack_trace_tsk_reliable()
Message-ID: <20190202005928.GM26056@350D>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
 <20190122155724.27557-5-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122155724.27557-5-joe.lawrence@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Nicolai Stange <nstange@suse.de>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Torsten Duwe <duwe@lst.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 22, 2019 at 10:57:24AM -0500, Joe Lawrence wrote:
> To match its x86 counterpart, save_stack_trace_tsk_reliable() should
> return -EINVAL in cases that it is currently returning 1.  No caller is
> currently differentiating non-zero error codes, but let's keep the
> arch-specific implementations consistent.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Seems straight forward

Acked-by: Balbir Singh <bsingharora@gmail.com>
