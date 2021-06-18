Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D31AC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 19:59:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC98660C3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 19:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC98660C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G68rR5V5sz3c5m
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 05:59:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZFwYmRIs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=luto@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZFwYmRIs; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G68qx3mZCz3btr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jun 2021 05:58:37 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62B7D60C3D;
 Fri, 18 Jun 2021 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624046313;
 bh=D7oBl/0a90lKe9pWfqLnpCpCt9G9AbWx/2EijH8CQy4=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=ZFwYmRIs2uRf1tIy8hT6Wi0I+iZUU7Gz+mTMkEZBflk9hqT2FNIz0/3iBhFoj0iYf
 zFbcLcIY3NG911o6doq5+lh9n4k8TAoWTjKvg7+suYYJ4Z//xJQ7SW/1Q6tZ5oqlqC
 KRbz/ZENYmXGbxnzQFHAaRU0My3Pe9jLWUrnEsHYt801nl7MUg4TJK/qYoS/6sOOgF
 RpP2phEll/ZETdKFJS/NSI2oES8OAx6Gar9IN3BHHe3jpi1DaLqPV47F9x/nt6ffIi
 44khMWq29Tid3SRb8+DbVNpwVwPkswRfo/BJbyWc3atNlPFDD1wWjPEPAoCIaK5MKa
 +kN/kviVn/f+w==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailauth.nyi.internal (Postfix) with ESMTP id 76E9127C0054;
 Fri, 18 Jun 2021 15:58:31 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute2.internal (MEProxy); Fri, 18 Jun 2021 15:58:31 -0400
X-ME-Sender: <xms:5PrMYBlHQAqPJ2MXq2Qyak_fOVrUUfPnnu6-RT3ciX-kg-OwuaadKw>
 <xme:5PrMYM3XQJ4XzCZ3F3O5Fay53NuM_iI9kgHATebsoEjhm9HGWNnBOTZ3OH0oX5JzE
 3G2peTv2DQWLWt3V2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedgudefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
 ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
 keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
 hugidrlhhuthhordhush
X-ME-Proxy: <xmx:5PrMYHpo2lEnk4FekOMIYzTGJykcFo4pECHNPSUBfjwwpXmLClL4lw>
 <xmx:5PrMYBmEN3WrJGHqGEzb3tBRKZ9mWJP_CtaCL15eJof7SXwUMV-4Hw>
 <xmx:5PrMYP14oXpVwlgZZq2YDhPPVOn73aa_6jm4u_TcRSTKCtxR94tCrw>
 <xmx:5_rMYG3I2j8dT_8N1EVton8OBNEx05Zk8bZO6IKJvPqlOaJQps5mAgg2Ux4h-JQ9>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 8510651C0060; Fri, 18 Jun 2021 15:58:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <1d617df2-57fa-4953-9c75-6de3909a6f14@www.fastmail.com>
In-Reply-To: <593983567.12619.1624033908849.JavaMail.zimbra@efficios.com>
References: <cover.1623813516.git.luto@kernel.org>
 <07a8b963002cb955b7516e61bad19514a3acaa82.1623813516.git.luto@kernel.org>
 <827549827.10547.1623941277868.JavaMail.zimbra@efficios.com>
 <26196903-4aee-33c4-bed8-8bf8c7b46793@kernel.org>
 <593983567.12619.1624033908849.JavaMail.zimbra@efficios.com>
Date: Fri, 18 Jun 2021 12:58:07 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: =?UTF-8?Q?Re:_[PATCH_8/8]_membarrier:_Rewrite_sync=5Fcore=5Fbefore=5Fuse?=
 =?UTF-8?Q?rmode()_and_improve_documentation?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
 Paul Mackerras <paulus@samba.org>, stable <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Fri, Jun 18, 2021, at 9:31 AM, Mathieu Desnoyers wrote:
> ----- On Jun 17, 2021, at 8:12 PM, Andy Lutomirski luto@kernel.org wro=
te:
>=20
> > On 6/17/21 7:47 AM, Mathieu Desnoyers wrote:
> >=20
> >> Please change back this #ifndef / #else / #endif within function fo=
r
> >>=20
> >> if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE)) {
> >>   ...
> >> } else {
> >>   ...
> >> }
> >>=20
> >> I don't think mixing up preprocessor and code logic makes it more r=
eadable.
> >=20
> > I agree, but I don't know how to make the result work well.
> > membarrier_sync_core_before_usermode() isn't defined in the !IS_ENAB=
LED
> > case, so either I need to fake up a definition or use #ifdef.
> >=20
> > If I faked up a definition, I would want to assert, at build time, t=
hat
> > it isn't called.  I don't think we can do:
> >=20
> > static void membarrier_sync_core_before_usermode()
> > {
> >    BUILD_BUG_IF_REACHABLE();
> > }
>=20
> Let's look at the context here:
>=20
> static void ipi_sync_core(void *info)
> {
>     [....]
>     membarrier_sync_core_before_usermode()
> }
>=20
> ^ this can be within #ifdef / #endif
>=20
> static int membarrier_private_expedited(int flags, int cpu_id)
> [...]
>                if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
>                         return -EINVAL;
>                 if (!(atomic_read(&mm->membarrier_state) &
>                       MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_REA=
DY))
>                         return -EPERM;
>                 ipi_func =3D ipi_sync_core;
>=20
> All we need to make the line above work is to define an empty ipi_sync=
_core
> function in the #else case after the ipi_sync_core() function definiti=
on.
>=20
> Or am I missing your point ?

Maybe?

My objection is that an empty ipi_sync_core is a lie =E2=80=94 it doesn=E2=
=80=99t sync the core.  I would be fine with that if I could have the co=
mpiler statically verify that it=E2=80=99s not called, but I=E2=80=99m u=
ncomfortable having it there if the implementation is actively incorrect=
.
