Return-Path: <SRS0=u7tn=UC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A64C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 21:55:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F6626C3B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iADSXB00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F6626C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Hpkw5R3PzDqdb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 07:55:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iADSXB00"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Hpfk6zKczDqTL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2019 07:51:42 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id b8so28895487edm.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jun 2019 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=spxbSxrpztoX+OYGfxSQU5fac10irlk+vBajDvb33D0=;
 b=iADSXB000vxOYJWwJoRtrAYRSo/dfLvDu8/qH49kJalqjkE/hRmqwTCq4kjqxxqPyz
 mt7rwocjIZSBlcJTIetx5SRB82REH/WVNBhcl/al+3Jnif0mJk2tmzdtMRWUZ/A9kT+f
 +vZRpM+tuHCzspT7CZxurPYPB5NkolL3JSOI2GggioMDa08zdzPluWWVaVkHqoXiCkaF
 QXAllhgAKLE4rh2W5lCa5VoyCUhA+VrsRxjDVyYQz3WfPeUL4nfKX1Op/PRfZenluLnr
 CDCQdYjIMW3k8Zlz8Dump4vaQY8BmqE5+lU9xzFcikpVlzg1kzyo3c4a1Az/Y6tPhB4d
 Zt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=spxbSxrpztoX+OYGfxSQU5fac10irlk+vBajDvb33D0=;
 b=tPyy6veWE5NhinRYFHUHnEP8cczOx2mwJ74qgnLBSJK5ctuGhoUUXZ6TEOHOe++qOQ
 7DPYwq0ctR1I//vYqx1sa4wREub+FM7wCge55wZNEah6sPE5e64++L+OrzgpwxfWNer5
 lRwvBZPeRTuB7Wa7EfizGN53yQ6deGoSWTnIjA4aCPVifk9OJ0wnqY/Z71+5SBb4nu/v
 aqBHTJzjeV1gGfS2QPijJj3bfurvEAS48umwj4bEpZMJAzSR46mRX7G+C1b6aHt0IfNM
 GTNAc1pRN9ZF7hpMyUZ42QfRYP3AOmyp9141wQ8JK+270rNTFgGV61gw+pKFBpy0MRWT
 mdDA==
X-Gm-Message-State: APjAAAUWdZrcnPxAB1u1GU9XKg1ClkDkW/DNrlwk203ZZRd2ZC8h+4+N
 OUsby25BuU+z5NsYacspvNU=
X-Google-Smtp-Source: APXvYqysmW+FQopVoJyDuQ/uqrAMHI1xHaH7Iwn4k4JCGIFFIXvqOIx6KZ7m/OoH/36YsKRUpIfwDQ==
X-Received: by 2002:a17:906:25c9:: with SMTP id
 n9mr4769934ejb.51.1559598700059; 
 Mon, 03 Jun 2019 14:51:40 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
 by smtp.gmail.com with ESMTPSA id p13sm4239321edm.97.2019.06.03.14.51.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 03 Jun 2019 14:51:38 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:51:36 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Message-ID: <20190603215136.GA45181@archlinux-epyc>
References: <20190603174323.48251-1-natechancellor@gmail.com>
 <CAKwvOdkQzdZezwf51UddFVGQh0mRFMEexr1cMHx=va88T515YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkQzdZezwf51UddFVGQh0mRFMEexr1cMHx=va88T515YQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nick,

On Mon, Jun 03, 2019 at 02:07:50PM -0700, Nick Desaulniers wrote:
> On Mon, Jun 3, 2019 at 10:44 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > Looking at the loop in a vacuum as clang would, fndit could be
> > uninitialized if entries was ever zero or the if statement was
> > always true within the loop. Regardless of whether or not this
> > warning is a problem in practice, "found" variables should always
> > be initialized to false so that there is no possibility of
> > undefined behavior.
> 
> Thanks for the patch Nathan.  fndit isn't really being used for
> anything other than a print statement outside of the loop.  How about:

Thank you for the review, this seems reasonable. I will send a v2
shortly.

> 
> ```
> diff --git a/drivers/pci/hotplug/rpaphp_core.c
> b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..c3899ee1db99 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct
> device_node *dn, char *drc_name,
>   struct of_drc_info drc;
>   const __be32 *value;
>   char cell_drc_name[MAX_DRC_NAME_LEN];
> - int j, fndit;
> + int j;
> 
>   info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>   if (info == NULL)
> @@ -245,17 +245,13 @@ static int rpaphp_check_drc_props_v2(struct
> device_node *dn, char *drc_name,
> 
>   /* Should now know end of current entry */
> 
> - if (my_index > drc.last_drc_index)
> - continue;
> -
> - fndit = 1;
> - break;
> + /* Found it */
> + if (my_index <= drc.last_drc_index) {
> + sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
> + my_index);
> + break;
> + }
>   }
> - /* Found it */
> -
> - if (fndit)
> - sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
> - my_index);
> 
>   if (((drc_name == NULL) ||
>        (drc_name && !strcmp(drc_name, cell_drc_name))) &&
> ```
> (not sure my tabs were pasted properly in the above...)

Doesn't look like it but no worries.

Thanks,
Nathan
