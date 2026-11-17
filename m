Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F4606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rkgLZbei
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXBg0ycRz2xl0;
	Wed, 18 Nov 2026 04:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::231" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937387;
	cv=pass; b=ongdbtYkhyhdhSpHG4FbT8TQUVXbcPMpmiKf/H4PUR5KpDo8wRjOqHSY0JJWHYOs3t1tzk4QRPwpD6v4a5MeBDBUWiy5h4RjFb5ZR0LOz877YPok+l00yFtcDkqTENanJwNFb/GIX+TO9gXN1a0gDP8ppER5ZYsKQTeIwmYFIC9SlikOOlZNtfOYtyBvl1xEhptiyHrIDKMvixqbjr9dqBbo0FhCPY66dU7vYh/1pZu5caB90fm0JNgmg4uQ5Eu3EalhIZyCLkPbGaIU2dkZ7Ub5cfsILzpCg3CoM23xnZ7XImFXEM77nVd//8N2vTziYKoMXLu+CBsSwNriYmrmxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937387; c=relaxed/relaxed;
	bh=nvzZs1q5voEwvj1dbc4nqY6RN+HlKTD/o3FysXVRy+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVQnqjl0QxHiIz4RPKBrqTMpIv3VHYT1D0J0W7U7ZlJ+CWezroBYh5o7B8wh6VIDJMULptqtu1njOUvInXLcMsWhxiLlnHEigVrkEYl7+wkkCMjrvoWqRFDjc+lfuS6DQwvZozAk0BNrU1s1nbe73fLHU45BB3UG7pmjcUq6zwg/XJc3Lge/dIRv2ov1ciM5pf1rcigzp2nbPU0NrTMMlFMV70s80bxz1+VkZdictHU6ya5snggZIOhtZXfSOOqOz9uWBWNkXPTM206rTXbwSRX7b88O0UTvpUXQe2PPJOC8LAF1LpfkFeTaAqRmJMmLnMjyhEPx6ibDG7jHaPro0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rkgLZbei; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rkgLZbei;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXBf19mHz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:43:06 +1100 (AEDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso1678481fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:43:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937382; cv=none;
        d=google.com; s=arc-20260327;
        b=eL3xscF7ngDO/ahT9gYms+yl3a89xLeii83di2ppNw02L0L+vX382ZVEM9gUV27ptD
         rWc2LCQDOzvrp19HB+Tww7gQAh/+ADoVO4k/B8qUUlOZE9w0Hf4w+IwQXZxT3Mu87NfI
         xueiZr2TtsTvyjvGbg7Kn90fc3SRCtMr5/6GRNVIE0KH3ix4HvoW6pzAxpB+e9G0VCBs
         iut2+iZq63BYn6kFmbRBlC1RSjxXd+sG3Gh2+cpUxEwMZAKC8/Op6B8njOiNNv1E5zb2
         vJ9fPSgdc6II1YWslq58+P0mMrhuTnBOWYOA7CBG0yGvpqjiNZ5tnraCR7ZVNKOE2CVl
         vXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nvzZs1q5voEwvj1dbc4nqY6RN+HlKTD/o3FysXVRy+g=;
        fh=y4z+YIu6wFVcbctgudCM+rNcrz6YoZ0wyeglM5AFLPc=;
        b=OdoxX8j86jE5hsnBP1cwBdtLJpneCcem21VU0iczsvGF8Oq5+p4Q71kRxaiMWwsHnc
         GP7xLhT585rLqKWqIL2CfVdXJg1hDRoyHGWwcZuOYSkourVz28lK17BjdzDWpRvDkxNs
         qPlIAqEQ6sMC+/aAE5rcv7sY3rdfcvhOCkOwRcpmtCiUER/ldimauVrjM4McH6Xvktc1
         POprQfDZwC/iJZgwwGEBB+m5OVcEbO0EJfghNRcQw7Hd5c04E++3I1tfRp64aKYJZBKg
         cqtXLxcfmx5C8K2RErP8/6z8yvgQCrNvqK3bc2GEQP1rXgJQETR0rZtlSMDdpD0RO9v6
         NH8w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937382; x=1795542182; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nvzZs1q5voEwvj1dbc4nqY6RN+HlKTD/o3FysXVRy+g=;
        b=rkgLZbeiyT0D+YGrgrheJb940YlihL+I0Rb54T9vsqGxWOFXUVNOmFksw6N3wxzXzF
         4Hs23HXyZAnyhggQJzHTPafB2iE7c+syiyXI4N37OqsJMLIy9tlwTDRPNYlmLUiI1x7+
         GtdYlQo7P2A6OfGS6nHeipjxmmEz4YVZUUOPm3G/Etq0u2GW5pVHNR+69DvO+9XYMnla
         Iva0azlpMcL7oYbRQZuHPnK5XTpK5AqPBBmIGsOtL/lpFvvF7IC/HGzwycBxwTy+ZKOb
         he/K2Snex+rngm0lXtFRfnkPFOLQQC6O/19suUnxA2skphr3I3IulXngmd5KnQuLsORJ
         gg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937382; x=1795542182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvzZs1q5voEwvj1dbc4nqY6RN+HlKTD/o3FysXVRy+g=;
        b=hAJgwDFVH7mtnYC5IPbPghAje4mcExExv1G+TceBPsWbo+H58JBjtgVY9S7gcbFWbd
         vN1FOcjeR1eCqH8+zmJbOBDxbX/q2frFJcVHKOLuuLg2pP9hSmDaxxN4yG1GF28MJJN2
         pFvH8qCbphH5DHI3jH1jTXLm/c6a3tqvyt0N+cmHZ34QR0UqkF2/P1VzhluaC50iDUXZ
         hTIZ34Dn2Y5J/SFtz3EhIEp/24mzIynrEhmsDwJh9gPAMd/hQCWDbxg3ue0j4PVaJFZP
         zjCQ8G1gPIaU8cksBUcAPTq4SBnUdiQgQ2moNV2574RXFThujVDz6PBVxvij8aaDZyZT
         /Zxg==
X-Forwarded-Encrypted: i=1; AL+hErEqktSe9z44OK1UI04fMJDwfKCog8ZWn7SYrQ96us0LtlJVJa1mbuJd4N4C1VTY1PibfOPrDSX1KPzgqsk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z99OY5qhyxRbZ0+pAFHsKGRA6amgfF9DpOgNpHdpbhKIhIlkbPV
	B6qZwCvP9DZ8VIlI78p0OxjJmuy8adE+zp1EpD/lyhAjGAKCR2AuvINKtliA7C6vE0gAeE9QrMX
	DyU3mwDxGSvFscuBFJqqYSsv6KFMa75I=
X-Gm-Gg: AYBFou1wgtMm3rjsCpg0RPXSuhHu7RjI/tfx+iJFH7MlXc2H8IgLk6UKZJvwrmGsq3s
	IuoCQpACZuezpP67/US9+/kWyKc0tsYVbNmIuolpFSKoVDjOstrDMusB4WzId3KQ4FgsGti3Bvr
	cgH4noo37h0QkD09LY7etNNOfrgfvOTNTYFgq1rcz5X8foHv36BZ/mHRCtK25c8L3E2rt0U9xcd
	njMe4/YuF/fDaNxYM5c4rzaAF8mSGAcmb5R+zwx2oN5VmCKDM2uHMtwq2BP1DGjjprELmsoEZK4
	F8iD6n3eH2qJQvP7y1fcuTllPdZlHT22E0CWmsC/bxMBtdpOyf93uXG9S6bwb+nr69ApOXx5F/L
	pn1YwWxjZ/paIeFWUKrA2zuNRyWRfJQm+zJBwR6s4iFO00edIKE8U/IGRjSa7cneaslqZ7cc0rU
	N5fee6jabvVu+wmkGp0I2Jr61uIptl29RQWB+zgEwp2Rf9pIhSuihP8hE00fzXpURuukX/
X-Received: by 2002:a05:651c:a171:b0:3a6:5ec0:7977 with SMTP id
 38308e7fff4ca-3ae2b52e925mr48966131fa.22.1794937382329; Tue, 17 Nov 2026
 09:43:02 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
 <20261109-ppc32-perf-v1-7-a6e8a55b3b48@gmail.com> <3950cc84-93bf-4830-8a37-57f9739a84b0@linux.ibm.com>
In-Reply-To: <3950cc84-93bf-4830-8a37-57f9739a84b0@linux.ibm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:42:50 -0500
X-Gm-Features: AclHuK9QUI3yDbyT2B0UUj_KZN-ImAYjLn5ew9el98OjTN6HFOxuPodteoFnxMI
Message-ID: <CAEdQ38Hr-pdXs2XYyFr0ryFsdeQ4xC5W9yG_xfDBhN068cDtBg@mail.gmail.com>
Subject: Re: [PATCH 7/8] powerpc/perf: Use SIAR for sample addresses on 32-bit
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:11=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.co=
m>
wrote:> One question: the callchain still walks from regs (gpr[1],
link), but
> its first entry now comes from SIAR. Can SIAR and the interrupted PC
> end up on opposite sides of user/kernel? If so, would the callchain
> be affected? Something like perf record -g on a workload that switches
> between user and kernel often might show it.

Yes, it happens. I ran perf record -g -e cycles -c 1000000 on a loop
that does a little work in user space and then calls getppid(). Of
16953 samples, 3022 had SIAR and the interrupted PC in different
modes.

2193 had SIAR in the syscall exit path (__kuep_unlock,
ret_from_syscall, syscall_exit_finish, syscall_exit_prepare) and the
interrupted PC in user space. The exception is held off while MSR[EE]
is clear, so it's taken just after the rfi. The sample is marked as a
kernel sample, but the callchain is a user callchain that starts with
a kernel address, so perf can't resolve that entry, and the actual
user PC (in libc's syscall()) is missing.

801 had SIAR in the system call vector at 0xc00. That code runs with
translation off, so SIAR holds a real address. The interrupted PC was
in the kernel, but these were marked as user samples at a bogus
address.

The other 28 had SIAR in user space and the interrupted PC in the
kernel.

In v2 I'll use SIAR only when it's in the same mode as the
interrupted context and fall back to regs->nip otherwise, which is
what the code did before this patch:

static inline void perf_read_regs(struct pt_regs *regs)
{
        unsigned long siar =3D mfspr(SPRN_SIAR);

        regs->result =3D siar && is_kernel_addr(siar) =3D=3D !user_mode(reg=
s);
}

A real-mode vector address isn't a kernel address, so this covers the
0xc00 case too, and perf_get_misc_flags() no longer needs to look at
SIAR. With that change the same test had no mismatched samples out
of 18069. The share of samples in the kernel went from 44% to 46%
(perf stat puts it at 57% of cycles), so falling back to regs->nip
near the transitions doesn't lose anything.

Good catch, thanks.

