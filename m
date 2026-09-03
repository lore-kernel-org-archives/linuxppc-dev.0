Return-Path: <linuxppc-dev+bounces-26500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9466CC624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 18:10:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbSLJ751Mz2yhD;
	Fri, 04 Sep 2026 04:10:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459000;
	cv=pass; b=jx74FDIv9vZ39ZoaCtjqZIkZCvij3QEzjh4TU3guKeUKJTGSz5+dTgfNAsEqF7rlPbM8/HhdfgS3iGCvQCknqthbLskwQKEUFAIqcR+Yarl0Iz+r/kWspGvjI1wlkQ4JYDGr46iN86XvOiETGzalV4xSWyBVrl32tzrvOqkZ1KhjIU8/BGw2zpf1yJgoMf9/JZXnciMmi32o0MkCsrFDs0RMFYqcDNWWD0tv3JaC95zcuXxIVUlZP/Ll3Weppa5dwEa1JbnOmvFNp1oy51ZNea2bNwfs6eRQ78zfOwkLf9OXgnfOms9JRgs70QTgRQ8H3XG36+IR7eDfQkcgtechmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459000; c=relaxed/relaxed;
	bh=4yLjprjTjRYbF/wVxB+bQ+ELdtKxFUy0kzJbPnOdacs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni4pL8hUqgppsMbOu/i75I3Vew+Qd92y8ZmLB1yTSfzJFDw/0xQ5KTJB3rjEkOWiCAOiu/ku5/wHRzIkj49KxyV8yZbN7LKp3ooC6wfX09EocnkeskfPqsEtESXbGwwqVZIkOjEltpp6JadyVHymGxWznGWX6OQ4c2h78YbRN9FCTUIAcvzBrnhrxxRHplLXIBaS0mJC2m6zhLmefs4t0rxGa31u8h3H/Si+MQ0iDg/QimwWQCvmnpW4VHLlBYtq03bs3XgYdw5kQJaDNRE1YmQpTINikOETNd7jzA2jksbncAhYmPOk2w72M+GDtEqD7UzAYVqcYm/DPD7+jnEZfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WGANXcLs; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=harsh.prateek.bora@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WGANXcLs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=harsh.prateek.bora@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSLH18Drz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:09:58 +1000 (AEST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c25ee9d1264so9305766b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 11:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788458994; cv=none;
        d=google.com; s=arc-20260327;
        b=QEJR93BMPCRrxqjTCu6H573O2KEHMCUUlbIa4F5+dPnd3jTnMtIVT4TR0guNVcU6xj
         nbCudhAHDaITHuC62bR/9sf/ZLh0QJ+S2Daj+NhnvQMLknu4Dr+oPdu5y9Kxj9BMusjp
         RuCtI34OsYbKhes4eC1K4gMeruBLqMZipLnzBMxxHpK/x4QMgbYoEjug4PBfxTlrfWbe
         YJYZHWaCKhEdmOsTEy0CtMpXlhMr1ogn73HNVrl6lq0EnWk1QPTKtpv6UnxJpLYCbmwn
         KXejSOyMEDfp4YzHrW9QLJPyYQSm0pMLlR/XLrGjLreLtsWZQGbiuZgH1t3WP58nZ/m4
         sQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4yLjprjTjRYbF/wVxB+bQ+ELdtKxFUy0kzJbPnOdacs=;
        fh=UTeP58xarP3vTnDE9gt1KfK/36zsEeTuq0fUgagdH/Y=;
        b=QjvZvpzSnCfOiiuC48d2XbL/r011Yvnzw3reGl+tIThvU4mWb1oYy/SkfCeOJtjp8S
         lNMKkQ+cFBCv7NxnqvaSrlThgossrRZPFTcJ8dOHhQl8igB9cxhlIht1tIO54mS5Oi5P
         MaDHtsf6Tx0LcH5NYSB25kYhv2rdMLeCdZNyQWLiVYQ53/ha7iyvskQqXJTSlvUwIqSC
         pYj85p6lGBt5xzcYAJDfwn4dF3oKpDC9ZTjLuZNXI+2tN+sPn24anGuIL4FxSXs3sGDD
         Slx2mKO2Rne0QJP2obJT2A9KtJolTyLj8f0TXWo7G5avA9Am3zYkQ4r2+0lYqF2Wfo3h
         T9yg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458994; x=1789063794; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yLjprjTjRYbF/wVxB+bQ+ELdtKxFUy0kzJbPnOdacs=;
        b=WGANXcLsOirgxT5lWrhT3qvSKVyAx5foZwFPe1PH8s4Szx4X9CHaAQrbB7ALj/L1rT
         N4GOatYAaeePWNFXi+F7lFcMvvndItDznh5ciyB9USIOjTQvrO3YSWALPNINgCGNjJWr
         iyopmDTbGgSynMKrz1uzw9Nj/PjfMDR/3cFSrhXY9VWOehrSM8+jGmKucqHIeYTUGn3N
         TQ60mRSf7tNHcpeyaKvJfY7WScjwe4Tj/R29UrWfqqSA/6AUktxaRymzpL8x25yuyBUa
         zHluwk8FeSIJSivFfKDbAGWBrW7ymWzYEpsK0dZnc6vFa3XGqsliDPPbWMD8OeBCJxiF
         UKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458994; x=1789063794;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4yLjprjTjRYbF/wVxB+bQ+ELdtKxFUy0kzJbPnOdacs=;
        b=Wupu3wL8YNEk2TrOAK99AypTSvAT95S68JsKY7wrE6czOXdUV2PkP7V46ZMjc481HK
         GGCwNb3vvMljH0Bdf0S/+clfnG3f3yPSu+rIhmVE3rabm139Jx41cLoC14jZe/GWMPTl
         Q8+5YlEhjitqAz+bld/g+ZMwLXljDet+l+Kt6y6MTJJqTb0U3rRX0MgHiXzC1szwCPg7
         ttE/cX5T3C5DHQIRx8lk9C7ibBnm4d8JHBYywDTqyaSfd247+fFW8uAPAXn2VJkemppV
         SlTQIQdqqvh7nhEM56F2P+hmvM5X+tpzMXYtVTaaZ8EylBd3zwoSZ6G0KLYuy3AfE/wK
         KCKg==
X-Gm-Message-State: AFuF++nkBc7XRa1O0N/5GMVGfuGMNagigt/+2GB0RaUnPP0/2rPzm8o6
	nfcdDx5lLrIgsh7jS4x9RaFQb/YTuoYbeOnP3bcHJkUrhvYSC9nK4Aldz9r6A/7tU5dZCMCMuWj
	wXpBpTl70bJe6/Tnato0SqDLs1l6sxR4=
X-Gm-Gg: AYBFou0yN54rqsQ8cP0lc/05vnQhI3+Du844jIPmUuhwGlOUZIRtotTJ/35h2jyDShy
	Fv8H/a4RHszVK2ABJdGwb2i5Ip2MDHELTnj2QzKbj+3PMzOrAbvGDIPzWVIgQ2AGqyNNdmkW0Gn
	PeDsVvRGO0q6pBhi21YlE2KwRpiBBMh+ZJ+4bPgd2YIF42qQjuR9vJ+6cy2nGktnoX9GR91JZZq
	YAn1K4ZWKXXMEU6Gye5MjNGTHlD+hjj9EzETJGxG52p3KBTnguh20Qn3967ESXN/V3st5QRD3P/
	mkFzOkm3Cc/ocsqiBu6lTIRT4VNj67dmEw3hDkMNvL74NSRRo8FIJbhB1TtYHgzQJzZOp0iACzt
	m
X-Received: by 2002:a17:907:c081:b0:c25:6230:dfcd with SMTP id
 a640c23a62f3a-c260c9e3320mr37319866b.15.1788458993569; Thu, 03 Sep 2026
 11:09:53 -0700 (PDT)
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
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Thu, 3 Sep 2026 23:39:40 +0530
X-Gm-Features: AcwNN1UPfhGf1_xnf5CwdkQCCZcfRhkMv7rOK2GFzJz3Ib7b4geTwHaA-ECmUKM
Message-ID: <CAEuJdmqPPYET2tjQmKCzamRr6aBhb4JNjBPN0R6G72w0KdLjKg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000001d39a065a980f69"

--00000000000001d39a065a980f69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Aug, 2026, 9:49=E2=80=AFam Ritesh Harjani (IBM), <ritesh.list@gm=
ail.com>
wrote:

> So the syscall return sequence is as follows:
> A syscall return to userspace is prepared and then a short asm sequence
> that actually does the RFI. Note that this asm range is restartable i.e.
> EE is still on, so an interrupt (e.g. decrementer or external interrupt)
> can hit while SRR/GPRs are being loaded. This is defined via:
>
> RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)
>
> This restart table then sends us to syscall_restart rather than resuming
> in the middle of the RFI. The same stub is also used if irq_happened
> already has a pending bit (soft-masked irq that has not been replayed
> yet (PowerPC special case of local_irq_disable())).
>
> Here is a bit of a flow of sequence of code to visualize:
>   syscall_exit_prepare
>       decide full-GPR restore (_TIF_RESTOREALL) for signal,
>       rt_sigreturn or syscall trace
>       save that in regs->exit_result and return it in r3
>            |
>            v
>   .Lsyscall_rst_start .. _end     EE still on
>       irq_happened set or interrupt in this range?
>            | no                         | yes
>            v                            v
>       cmpdi r3,0                  syscall_exit_restart
>       restore all / zero            replay irq, try exit again
>       volatiles; RFI                must return flags in r3
>                                     again for the same cmpdi
>
> Now r3 after prepare is the flags word, not the actual syscall return. A
> nested
> interrupt clobbers it, so the restart stub reloads RESULT into r3 and the
> C handler (syscall_exit_restart()) should put the flags back (because
> later asm
> checks whether r3 returned from C has _TIF_RESTOREALL set or not):
>         cmpdi r3, 0
>         bne     .Lsyscall_restore_regs
>
> Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into
> exit_result, but then it only returns the new sample and not the full
> regs->exit_result.
>
> That sample could be often 0 even when restore-all is still required:
>
>   - rt_sigreturn / syscall trace set the bit in prepare's local
>     ret and in exit_result. They never set exit_flags, which is
>     what restart samples.
>
>   - a signal does set exit_flags but restart clears it. A
>     second pass through the stub then returns 0 while
>     exit_result still has the bit.
>
> The asm as mentioned earlier then treats r3=3D=3D0 as the fast path and
> zeros r0/r4-r12. That means the userspace that needed the full register
> set could SIGSEGVs, (which could happen often in ld64.so.2 like while
> doing a parallel kernel build as reported by Venkat).
>
> So we should instead return the accumulated exit_result, like how we do
> in interrupt_exit_user_restart(). Note that prior to this commit
> 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for
> ptrace")
> we were returning regs->exit_result from syscall_exit_restart(), but
> this commit changed that behaviour.
>
> Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs
> for ptrace")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes:
> https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ib=
m.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> Sorry about the long commit msg. It took sometime for me to fully
> understand
> that complex path, so I thought I may as well document that properly.
>
>  arch/powerpc/kernel/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/interrupt.c
> b/arch/powerpc/kernel/interrupt.c
> index 5b88bf72786c..55f9c0c9922a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned
> long r3, struct pt_regs *reg
>         current_thread_info()->exit_flags &=3D ~_TIF_RESTOREALL;
>         regs->exit_result |=3D ret;
>
> -       return ret;
> +       return regs->exit_result;
>

Thanks for the fix, Ritesh!
Are we leaving ret unused as well?

Otherwise,
Reviewed-by: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>

 }
>  #endif
>
> --
> 2.39.5
>
>
>

--00000000000001d39a065a980f69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 29 Aug, 2026, 9:49=E2=80=
=AFam Ritesh Harjani (IBM), &lt;<a href=3D"mailto:ritesh.list@gmail.com">ri=
tesh.list@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
So the syscall return sequence is as follows:<br>
A syscall return to userspace is prepared and then a short asm sequence<br>
that actually does the RFI. Note that this asm range is restartable i.e.<br=
>
EE is still on, so an interrupt (e.g. decrementer or external interrupt)<br=
>
can hit while SRR/GPRs are being loaded. This is defined via:<br>
<br>
RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)<br>
<br>
This restart table then sends us to syscall_restart rather than resuming<br=
>
in the middle of the RFI. The same stub is also used if irq_happened<br>
already has a pending bit (soft-masked irq that has not been replayed<br>
yet (PowerPC special case of local_irq_disable())).<br>
<br>
Here is a bit of a flow of sequence of code to visualize:<br>
=C2=A0 syscall_exit_prepare<br>
=C2=A0 =C2=A0 =C2=A0 decide full-GPR restore (_TIF_RESTOREALL) for signal,<=
br>
=C2=A0 =C2=A0 =C2=A0 rt_sigreturn or syscall trace<br>
=C2=A0 =C2=A0 =C2=A0 save that in regs-&gt;exit_result and return it in r3<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v<br>
=C2=A0 .Lsyscall_rst_start .. _end=C2=A0 =C2=A0 =C2=A0EE still on<br>
=C2=A0 =C2=A0 =C2=A0 irq_happened set or interrupt in this range?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| no=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| yes<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v<br>
=C2=A0 =C2=A0 =C2=A0 cmpdi r3,0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 syscall_exit_restart<br>
=C2=A0 =C2=A0 =C2=A0 restore all / zero=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 replay irq, try exit again<br>
=C2=A0 =C2=A0 =C2=A0 volatiles; RFI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 must return flags in r3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 again for the same cmp=
di<br>
<br>
Now r3 after prepare is the flags word, not the actual syscall return. A ne=
sted<br>
interrupt clobbers it, so the restart stub reloads RESULT into r3 and the<b=
r>
C handler (syscall_exit_restart()) should put the flags back (because later=
 asm<br>
checks whether r3 returned from C has _TIF_RESTOREALL set or not):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmpdi r3, 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bne=C2=A0 =C2=A0 =C2=A0.Lsyscall_restore_regs<b=
r>
<br>
Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into<b=
r>
exit_result, but then it only returns the new sample and not the full<br>
regs-&gt;exit_result.<br>
<br>
That sample could be often 0 even when restore-all is still required:<br>
<br>
=C2=A0 - rt_sigreturn / syscall trace set the bit in prepare&#39;s local<br=
>
=C2=A0 =C2=A0 ret and in exit_result. They never set exit_flags, which is<b=
r>
=C2=A0 =C2=A0 what restart samples.<br>
<br>
=C2=A0 - a signal does set exit_flags but restart clears it. A<br>
=C2=A0 =C2=A0 second pass through the stub then returns 0 while<br>
=C2=A0 =C2=A0 exit_result still has the bit.<br>
<br>
The asm as mentioned earlier then treats r3=3D=3D0 as the fast path and<br>
zeros r0/r4-r12. That means the userspace that needed the full register<br>
set could SIGSEGVs, (which could happen often in ld64.so.2 like while<br>
doing a parallel kernel build as reported by Venkat).<br>
<br>
So we should instead return the accumulated exit_result, like how we do<br>
in interrupt_exit_user_restart(). Note that prior to this commit<br>
263e5159e00a (&quot;powerpc: Fix exit_flags field placement in pt_regs for =
ptrace&quot;)<br>
we were returning regs-&gt;exit_result from syscall_exit_restart(), but<br>
this commit changed that behaviour.<br>
<br>
Fixes: 263e5159e00a (&quot;powerpc: Fix exit_flags field placement in pt_re=
gs for ptrace&quot;)<br>
Reported-by: Venkat Rao Bagalkote &lt;<a href=3D"mailto:venkat88@linux.ibm.=
com" target=3D"_blank" rel=3D"noreferrer">venkat88@linux.ibm.com</a>&gt;<br=
>
Closes: <a href=3D"https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9=
765819ad@linux.ibm.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.co=
m/</a><br>
Signed-off-by: Ritesh Harjani (IBM) &lt;<a href=3D"mailto:ritesh.list@gmail=
.com" target=3D"_blank" rel=3D"noreferrer">ritesh.list@gmail.com</a>&gt;<br=
>
---<br>
Sorry about the long commit msg. It took sometime for me to fully understan=
d<br>
that complex path, so I thought I may as well document that properly.<br>
<br>
=C2=A0arch/powerpc/kernel/interrupt.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrup=
t.c<br>
index 5b88bf72786c..55f9c0c9922a 100644<br>
--- a/arch/powerpc/kernel/interrupt.c<br>
+++ b/arch/powerpc/kernel/interrupt.c<br>
@@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned lon=
g r3, struct pt_regs *reg<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 current_thread_info()-&gt;exit_flags &amp;=3D ~=
_TIF_RESTOREALL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 regs-&gt;exit_result |=3D ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return regs-&gt;exit_result;<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for the fix,=
 Ritesh!</div><div dir=3D"auto">Are we leaving ret unused as well?</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Otherwise,</div><div dir=3D"auto=
">Reviewed-by: Harsh Prateek Bora &lt;<a href=3D"mailto:harsh.prateek.bora@=
gmail.com">harsh.prateek.bora@gmail.com</a>&gt;</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
=C2=A0}<br>
=C2=A0#endif<br>
<br>
--<br>
2.39.5<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000001d39a065a980f69--

