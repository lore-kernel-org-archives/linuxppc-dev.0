Return-Path: <SRS0=0QC4=42=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5673C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 01:53:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74C920675
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 01:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnuwCfeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74C920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48bLpf6C4GzDqqY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.193;
 helo=mail-il1-f193.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48bLn00wxGzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2020 12:51:45 +1100 (AEDT)
Received: by mail-il1-f193.google.com with SMTP id f5so7221849ilq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2020 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NtUWtFnRoHixZyuZBmfMFJSnhS7OwKwOd9rd2v5oL4I=;
 b=dnuwCfeG/t41mw734KNixttlsP4BmWgr25tDfloN0vIS6NevgfyAzX8oMdvoyptrMu
 eVDg+qwMtHZPcQA/29yp4F0gPtceaPsD8EWhpXeeynjvg8o7Bd5UXmHAeJJaL1aXu6Sz
 +U3lUcHh7syEjhcG9MdeZ8fPYdiDRKMc98NEAvcIPQ74v5zlBiYbxcuNRzDS3Apmgycj
 KJV0AByrK2uZkGac2MjICk9csKhhL/hocgQw5kl2hMgVvAeL72KQ6fGYhcEuf+eTEGbq
 ZrKA7elhTuzHAV3FWZ0rgcqY4yf9+HCN9JcFhGj20gjQCYpw263MICaY69uUG2hz015n
 VnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NtUWtFnRoHixZyuZBmfMFJSnhS7OwKwOd9rd2v5oL4I=;
 b=Zzxq9X0ODDvAVT/eWrB9zQ1kypP9UZd4zeZhqDL6Fg4/LgA0n4iA/FCJjg0TFPbjeq
 rRdilXwQ0BHDbKOqFnoP7jhdQxFREgOJksOCN6p3Ay2b3H6kTt25wc+pVOhk/oSey111
 yxh0d4lbvULPFm2kJM2gpNTG0yyYZxcvjfpRNdXjE7s3UeI4k9aN+u9AJ2gW5PQtNmeV
 0V1j7VLOoR2BIGgm1FhMdVrHyWh9o8oxPN12I+Z+hGWlF536GTFH6eKSVSM2iBC7+gHg
 z6W+VNbW0OmGa7uY2ERqCYhWG5wKXUUMTaNDR2XcWLyXaD/wEawXQRR21WlaqPyrDbMW
 8ujA==
X-Gm-Message-State: ANhLgQ2eVRLMY7M5ZS42a7CVItvBnHBLVn5aL/ShLWM+7r58KQQ+qsUS
 W6qu0m7LAL+NG5K4Ik/JQrXWu5mjFrP95Vcb2w==
X-Google-Smtp-Source: ADFU+vsVBnt8ZTgQv2IfEnSGzp7zi6Vy6tMPwtv4Mf1WMHG9M71JasbxRNUZNKT8b3u1i+3BiI7Yg/7FPF5NGH3Wrt0=
X-Received: by 2002:a92:91c7:: with SMTP id e68mr13615632ill.161.1583718641516; 
 Sun, 08 Mar 2020 18:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <1582882895-3142-1-git-send-email-kernelfans@gmail.com>
 <1583311651-29310-1-git-send-email-kernelfans@gmail.com>
 <1583311651-29310-2-git-send-email-kernelfans@gmail.com>
 <87eeu5jlub.fsf@linux.ibm.com>
In-Reply-To: <87eeu5jlub.fsf@linux.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Mon, 9 Mar 2020 09:50:30 +0800
Message-ID: <CAFgQCTtJ=vK7Z02+kpDeu6Vjyi7=s2pE=PqCQ+Z0Y8yCPj3cpA@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] powerpc/of: split out new_property() for reusing
To: Nathan Lynch <nathanl@linux.ibm.com>
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Kexec Mailing List <kexec@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Frank Rowand <frowand.list@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 7, 2020 at 3:59 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Hi,
>
> Pingfan Liu <kernelfans@gmail.com> writes:
> > Splitting out new_property() for coming reusing and moving it to
> > of_helpers.c.
>
> [...]
>
> > +struct property *new_property(const char *name, const int length,
> > +             const unsigned char *value, struct property *last)
> > +{
> > +     struct property *new = kzalloc(sizeof(*new), GFP_KERNEL);
> > +
> > +     if (!new)
> > +             return NULL;
> > +
> > +     new->name = kstrdup(name, GFP_KERNEL);
> > +     if (!new->name)
> > +             goto cleanup;
> > +     new->value = kmalloc(length + 1, GFP_KERNEL);
> > +     if (!new->value)
> > +             goto cleanup;
> > +
> > +     memcpy(new->value, value, length);
> > +     *(((char *)new->value) + length) = 0;
> > +     new->length = length;
> > +     new->next = last;
> > +     return new;
> > +
> > +cleanup:
> > +     kfree(new->name);
> > +     kfree(new->value);
> > +     kfree(new);
> > +     return NULL;
> > +}
>
> This function in its current form isn't suitable for more general use:
>
> * It appears to be tailored to string properties - note the char * value
>   parameter, the length + 1 allocation and nul termination.
>
> * Most code shouldn't need the 'last' argument. The code where this
>   currently resides builds a list of properties and attaches it to a new
>   node, bypassing of_add_property().
>
> Let's look at the call site you add in your next patch:
>
> +               big = cpu_to_be64(p->bound_addr);
> +               property = new_property("bound-addr", sizeof(u64), (const unsigned char *)&big,
> +                       NULL);
> +               of_add_property(dn, property);
>
> So you have to use a cast, and this is going to allocate (sizeof(u64) + 1)
> for the value, is that what you want?
>
> I think you should leave that legacy pseries reconfig code undisturbed
> (frankly that stuff should get deprecated and removed) and if you want a
> generic helper it should look more like:
>
> struct property *of_property_new(const char *name, size_t length,
>                                  const void *value, gfp_t allocflags)
>
> __of_prop_dup() looks like a good model/guide here.

Thanks for your good suggestion.
I will re-code based on your suggestion, if [2/2] turns out acceptable.

Regards,
Pingfan
