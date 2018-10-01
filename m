Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D8C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:59:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B5F208AE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B5F208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PHm46CVhzF3Dt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PHjw1LLRzF39F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 08:57:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42PHjv6788z9s3l;
 Tue,  2 Oct 2018 08:57:39 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id C2133EE78BF; Tue,  2 Oct 2018 08:57:39 +1000 (AEST)
Message-ID: <be6f825716aee4af524fe9a1ef1cfde12c15a607.camel@neuling.org>
Subject: Re: [v4] powerpc: Avoid code patching freed init sections
From: Michael Neuling <mikey@neuling.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Michael Ellerman
 <patch-notifications@ellerman.id.au>
Date: Tue, 02 Oct 2018 08:57:39 +1000
In-Reply-To: <0702294f-6a17-18aa-95f6-d97da4596dbd@c-s.fr>
References: <42GsbJ0Knkz9sCh@ozlabs.org>
 <0702294f-6a17-18aa-95f6-d97da4596dbd@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Haren Myneni <haren@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-01 at 13:25 +0200, Christophe LEROY wrote:
>=20
> Le 21/09/2018 =C3=A0 13:59, Michael Ellerman a =C3=A9crit :
> > On Fri, 2018-09-14 at 01:14:11 UTC, Michael Neuling wrote:
> > > This stops us from doing code patching in init sections after they've
> > > been freed.
> > >=20
> > > In this chain:
> > >    kvm_guest_init() ->
> > >      kvm_use_magic_page() ->
> > >        fault_in_pages_readable() ->
> > > 	 __get_user() ->
> > > 	   __get_user_nocheck() ->
> > > 	     barrier_nospec();
> > >=20
> > > We have a code patching location at barrier_nospec() and
> > > kvm_guest_init() is an init function. This whole chain gets inlined,
> > > so when we free the init section (hence kvm_guest_init()), this code
> > > goes away and hence should no longer be patched.
> > >=20
> > > We seen this as userspace memory corruption when using a memory
> > > checker while doing partition migration testing on powervm (this
> > > starts the code patching post migration via
> > > /sys/kernel/mobility/migration). In theory, it could also happen when
> > > using /sys/kernel/debug/powerpc/barrier_nospec.
> > >=20
> > > cc: stable@vger.kernel.org # 4.13+
> > > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> > > Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >=20
> > Applied to powerpc fixes, thanks.
> >=20
> > https://git.kernel.org/powerpc/c/51c3c62b58b357e8d35e4cc32f7b4e
> >=20
>=20
> This patch breaks booting on my MPC83xx board (book3s/32) very early=20
> (before console is active), provoking restart.
> u-boot reports a checkstop reset at restart.
>=20
> Reverting this commit fixes the issue.
>=20
> The following patch fixes the issue as well, but I think it is not the=
=20
> best solution. I still think the test should be in patch_instruction()=
=20
> instead of being in __patch_instruction(), see my comment on v2

Arrh, sorry.

Can you write this up as a real patch with a signed off by so mpe can take =
it?

Mikey

>=20
> Christophe
>=20
> diff --git a/arch/powerpc/lib/code-patching.c=20
> b/arch/powerpc/lib/code-patching.c
> index 6ae2777..6192fda 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -29,7 +29,7 @@ static int __patch_instruction(unsigned int=20
> *exec_addr, unsigned int instr,
>          int err;
>=20
>          /* Make sure we aren't patching a freed init section */
> -       if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
> +       if (*PTRRELOC(&init_mem_is_free) &&=20
> init_section_contains(exec_addr, 4)) {
>                  pr_debug("Skipping init section patching addr:=20
> 0x%px\n", exec_addr);
>                  return 0;
>          }
>=20
>=20
> Christophe
>=20
