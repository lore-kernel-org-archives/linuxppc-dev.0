Return-Path: <SRS0=0bRz=5P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E9C43331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 03:12:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B663620732
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 03:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJLjrZAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B663620732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48rHZJ1WRlzDqb1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 14:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48rHWy4RCjzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2020 14:10:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=vGDNTOGNwMse2sdXdcBLsEqwHL/+zvFxHg/HxTxQcaY=; b=nJLjrZApvFQKX5agjxMBq2m84R
 3uRzQKtfvDUYtgoROwxBQpD1K/k0C+ovJIByku2SyiM5fMKVlCC2RNiG98WpgdyTvmeq0PejZl0hV
 qxksT/94cIymMto2sysxJp4G8YkQHFKwcKRFfH7rpT8FK07TBalEN6AxneSxAmtcTedPNRAbxD1jg
 kJa6PiKHTVBnBcsSkeD3yZPROqR2IdkjGcTWrpawpSJ8CVQA4HRIMe+MhOGQZpf+79QRhqefKSlaw
 yZs/BcA/C9zZJ3SVDhqQiFgT+uWls6uX70Q/fQgP80+dvNr22x9LJRrQ3pZV58VsRismj+0uUOqPT
 w/1q6coA==;
Received: from [2602:306:37b0:7840:b51a:dd8c:5d76:65e]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIkoZ-0002be-AU; Mon, 30 Mar 2020 03:10:15 +0000
Subject: Re: [PATCH 7/9] powerpc/ps3: Add check for otheros image size
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1585340156.git.geoff@infradead.org>
 <e0dc92ba82a993c845f8d2bf3ace7465ef5ea996.1585340156.git.geoff@infradead.org>
 <CAMuHMdU1qLs1u3JuJM+r4jV0gGQuq4B11gbSDsX6JHUBFQAX3w@mail.gmail.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <076d65da-59c4-95c2-618b-8f0683b53fcf@infradead.org>
Date: Sun, 29 Mar 2020 20:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU1qLs1u3JuJM+r4jV0gGQuq4B11gbSDsX6JHUBFQAX3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Geert,

On 3/29/20 7:00 AM, Geert Uytterhoeven wrote:
>> --- a/arch/powerpc/boot/wrapper
>> +++ b/arch/powerpc/boot/wrapper
>>
>>      odir="$(dirname "$ofile.bin")"
>> -    rm -f "$odir/otheros.bld"
>> -    gzip -n --force -9 --stdout "$ofile.bin" > "$odir/otheros.bld"
>> +
>> +    # The ps3's flash loader has a size limit of 16 MiB for the uncompressed
>> +    # image.  If a compressed image that exceeded this limit is written to
>> +    # flash the loader will decompress that image until the 16 MiB limit is
>> +    # reached, then enter the system reset vector of the partially decompressed
>> +    # image.  No warning is issued.
>> +    rm -f "$odir"/{otheros,otheros-too-big}.bld
>> +    size=$(${CROSS}nm --no-sort --radix=d "$ofile" | egrep ' _end$' | cut -d' ' -f1)
>> +    bld="otheros.bld"
>> +    [ $size -le 16777216 ] || bld="otheros-too-big.bld"
>> +    gzip -n --force -9 --stdout "$ofile.bin" > "$odir/$bld"
>>      ;;
>>  esac
> 
> Why not print an error message and exit 1 instead, like is done for
> other fatal errors?

This is not really a fatal error for the entire build.  The default
make target will build both a vmlinux file and a .bld file.  The
.bld file is the one that can be programmed to the OtherOS flash
memory (bld = boot loader).  Even if the .bld file is too big, a
big vmlinux file from such a build would be completely fine for
petitboot to load.

It may be good to print an 'info' message though.  I'll post an
updated patch.

-Geoff


