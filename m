Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F0BC6783C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 13:58:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B97620868
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 13:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B97620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WqDL6Fl9zF3TC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 00:58:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WqBK0qGvzF3Sl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 00:56:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42WqBJ5C2rz9s3C;
 Sat, 13 Oct 2018 00:56:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: RFC.PATCH.00/11@lists.ozlabs.org,
 prom_init.cleanups.and.sanitization@gate.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 01/11] powerpc/prom_init: Make of_workarounds static
In-Reply-To: <20180531043349.24783-2-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
 <20180531043349.24783-2-benh@kernel.crashing.org>
Date: Sat, 13 Oct 2018 00:56:23 +1100
Message-ID: <87pnwf1d6g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> It's not used anywhere else
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/prom_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index f9d6befb55a6..d6f52cc141c3 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -88,7 +88,7 @@
>  #define OF_WORKAROUNDS	0
>  #else
>  #define OF_WORKAROUNDS	of_workarounds
> -int of_workarounds;
> +static int of_workarounds __promdata;

I don't have __promdata:

  arch/powerpc/kernel/prom_init.c:90:27: error: expected =E2=80=98=3D=E2=80=
=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=
=80=98__attribute__=E2=80=99 before =E2=80=98__promdata=E2=80=99
   static int of_workarounds __promdata;
                             ^~~~~~~~~~
  arch/powerpc/kernel/prom_init.c: In function =E2=80=98prom_claim=E2=80=99:
  arch/powerpc/kernel/prom_init.c:89:24: error: =E2=80=98of_workarounds=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98of_ir=
q_workarounds=E2=80=99?
   #define OF_WORKAROUNDS of_workarounds
                          ^
  arch/powerpc/kernel/prom_init.c:438:21: note: in expansion of macro =E2=
=80=98OF_WORKAROUNDS=E2=80=99
    if (align =3D=3D 0 && (OF_WORKAROUNDS & OF_WA_CLAIM)) {
                       ^~~~~~~~~~~~~~
  arch/powerpc/kernel/prom_init.c:89:24: note: each undeclared identifier i=
s reported only once for each function it appears in
   #define OF_WORKAROUNDS of_workarounds
                          ^
  arch/powerpc/kernel/prom_init.c:438:21: note: in expansion of macro =E2=
=80=98OF_WORKAROUNDS=E2=80=99
    if (align =3D=3D 0 && (OF_WORKAROUNDS & OF_WA_CLAIM)) {
                       ^~~~~~~~~~~~~~
  arch/powerpc/kernel/prom_init.c: In function =E2=80=98prom_setprop=E2=80=
=99:
  arch/powerpc/kernel/prom_init.c:89:24: error: =E2=80=98of_workarounds=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98of_ir=
q_workarounds=E2=80=99?
   #define OF_WORKAROUNDS of_workarounds
                          ^
  arch/powerpc/kernel/prom_init.c:544:8: note: in expansion of macro =E2=80=
=98OF_WORKAROUNDS=E2=80=99
    if (!(OF_WORKAROUNDS & OF_WA_LONGTRAIL))
          ^~~~~~~~~~~~~~
  arch/powerpc/kernel/prom_init.c: In function =E2=80=98prom_find_mmu=E2=80=
=99:
  arch/powerpc/kernel/prom_init.c:2072:3: error: =E2=80=98of_workarounds=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98of_ir=
q_workarounds=E2=80=99?
     of_workarounds =3D OF_WA_CLAIM;
     ^~~~~~~~~~~~~~
     of_irq_workarounds

cheers
