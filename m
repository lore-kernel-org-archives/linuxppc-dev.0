Return-Path: <SRS0=EbLt=GW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3BDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 19:04:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AEC216FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 19:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AEC216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKwB71h2bzDr1c
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 04:09:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=198.54.127.110;
 helo=mta-14-3.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
X-Greylist: delayed 172392 seconds by postgrey-1.36 at bilbo;
 Wed, 20 Jan 2021 04:07:41 AEDT
Received: from MTA-14-3.privateemail.com (mta-14-3.privateemail.com
 [198.54.127.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKw7x0s43zDqwY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 04:07:40 +1100 (AEDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
 by mta-14.privateemail.com (Postfix) with ESMTP id 361E1800C4;
 Tue, 19 Jan 2021 12:07:36 -0500 (EST)
Received: from localhost (unknown [10.20.151.206])
 by mta-14.privateemail.com (Postfix) with ESMTPA id EA729800BF;
 Tue, 19 Jan 2021 17:07:35 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v3 1/8] powerpc/uaccess: Add unsafe_copy_from_user
From: "Christopher M. Riedl" <cmr@codefail.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Michael Ellerman"
 <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 19 Jan 2021 11:02:23 -0600
Message-Id: <C8NAORBNJH4S.KKQFN1HWO8XH@geist>
In-Reply-To: <148f85e2-a49e-062a-6627-cb46bf6eab14@csgroup.eu>
X-Virus-Scanned: ClamAV using ClamSMTP
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

On Tue Jan 19, 2021 at 6:33 AM CST, Christophe Leroy wrote:
>
>
> Le 19/01/2021 =C3=A0 03:11, Michael Ellerman a =C3=A9crit :
> > "Christopher M. Riedl" <cmr@codefail.de> writes:
> >> On Mon Jan 11, 2021 at 7:22 AM CST, Christophe Leroy wrote:
> >>> Le 09/01/2021 =C3=A0 04:25, Christopher M. Riedl a =C3=A9crit :
> >>>> Implement raw_copy_from_user_allowed() which assumes that userspace =
read
> >>>> access is open. Use this new function to implement raw_copy_from_use=
r().
> >>>> Finally, wrap the new function to follow the usual "unsafe_" convent=
ion
> >>>> of taking a label argument.
> >>>
> >>> I think there is no point implementing raw_copy_from_user_allowed(), =
see
> >>> https://github.com/linuxppc/linux/commit/4b842e4e25b1 and
> >>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/8c74fc9ce8131=
cabb10b3e95dc0e430f396ee83e.1610369143.git.christophe.leroy@csgroup.eu/
> >>>
> >>> You should simply do:
> >>>
> >>> #define unsafe_copy_from_user(d, s, l, e) \
> >>> unsafe_op_wrap(__copy_tofrom_user((__force void __user *)d, s, l), e)
> >>>
> >>
> >> I gave this a try and the signal ops decreased by ~8K. Now, to be
> >> honest, I am not sure what an "acceptable" benchmark number here
> >> actually is - so maybe this is ok? Same loss with both radix and hash:
> >>
> >> 	|                                      | hash   | radix  |
> >> 	| ------------------------------------ | ------ | ------ |
> >> 	| linuxppc/next                        | 118693 | 133296 |
> >> 	| linuxppc/next w/o KUAP+KUEP          | 228911 | 228654 |
> >> 	| unsafe-signal64                      | 200480 | 234067 |
> >> 	| unsafe-signal64 (__copy_tofrom_user) | 192467 | 225119 |
> >>
> >> To put this into perspective, prior to KUAP and uaccess flush, signal
> >> performance in this benchmark was ~290K on hash.
> >=20
> > If I'm doing the math right 8K is ~4% of the best number.
> >=20
> > It seems like 4% is worth a few lines of code to handle these constant
> > sizes. It's not like we have performance to throw away.
> >=20
> > Or, we should chase down where the call sites are that are doing small
> > constant copies with copy_to/from_user() and change them to use
> > get/put_user().
> >=20
>
> Christopher, when you say you gave it a try, is I my series or only the
> following ?
>
> #define unsafe_copy_from_user(d, s, l, e) \
> unsafe_op_wrap(__copy_tofrom_user((__force void __user *)d, s, l), e)
>

I only used the above to replace this patch in my series (so none of my
changes implementing raw_copy_from_user_allowed() are included).

>
> Because I see no use of unsafe_copy_from_user() that would explain that.
>
> Christophe

