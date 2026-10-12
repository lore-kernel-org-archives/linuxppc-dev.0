Return-Path: <linuxppc-dev+bounces-29331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC62CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3TYf34C5z30NF;
	Tue, 13 Oct 2026 07:28:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::531" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791836886;
	cv=pass; b=bWRbTAO86voz6BGCQ++E6IvaGkAyKENEHihwVx4/MAWRyHtMwahR+CwXKS3FbI/gv0XbX/Jyrk3UfyE+xxE6ghZ96O/A8qebQPW0kfDN31YbDmDrZLPGxdGYqFYPBZdqqH/mCwWGxvTm9b/rYZoJ3E4YjSFzARP+eirPDsfg65f7FEeDWiNQ69zxDKv3tLef10yzI5hiE50krUM6tJnEly93Gt9ID21+PDQwqPlQwg8H9UanCuk5bZYoccJ6xAEhusqCVt0Ay1ZQ10GvX1CxYUteMSj7UFDXfxlBqXn5Nz7Y2UdOMctontvvoOQ9VfXCOV5+pxfbWWaMdW11Cbtrow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791836886; c=relaxed/relaxed;
	bh=IN1Nd1jOf1uIqNtCm/iqSeHZvrqnmZGz6JuPiV7jclo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+CcXcmfGhm/yFwCVVxH8+cHwxq/vYQNITCekuFqepE1BC5aQn+/OcDuFG95LrrufkVwZdxHWrc9nONSURBEo3PJWvYePj3bzYOz7EuYbtVTm3dYmACq7njs2TCHzCy+u3mHEr5j/w6JZKmKUka50AMEyFBPIX0GD6TolZE9ZmaTbbkk8hrQx8WFHWo5KHJ/SvY01BZ6T16MZIYhEmvaN1n/usFK8r5eRzM1b1OSSGqKn6ad5u500PmOAv2BvQLYmszL8vMu7RuxUubC8IP/CcDBKI+Zdu4/7xmFMyVW/XDhwSWMBXwZ9A03wcOBEZcztT3N+tMbIuP2Ae61as6uzA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pJx88FKN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pJx88FKN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3TYc67pYz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 07:28:03 +1100 (AEDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b1cc392d8bso1351540a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 13:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791836878; cv=none;
        d=google.com; s=arc-20260327;
        b=mclCMtYXz+aNFxv5PLNLaRtzsI7j3uPCRVlPT2lfa0Ss745/+YwLoJ6XdT3JCZyXGb
         t9cWp5Gc3Mhj2+2G/xmPIzmoLDsdopDooN4m8nHVm5GJJgs6XJUk9erXa6QdVmXO548C
         SntDJAJ8+dINzEi6lLNkYWkVxkCFyGp/zEQ9B8wPb6CQVkE2S2ffEJo05VSLG+vmYMJp
         AgwJ0O1zrshOdd64vnus4bKq4juHwqAAgbsmMrSElGVlJMsv9a7vCHsDCG6n3mqRE0Fn
         nu1Kvm/E6oOZntlIMWwbJZTetClsAzwXYac8p68O6ulk8bu5YYRnATNMTp7Weh8S/y58
         ILnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IN1Nd1jOf1uIqNtCm/iqSeHZvrqnmZGz6JuPiV7jclo=;
        fh=JTZ9cu29awM4EnLP6O2sUrrlQSUYp0sUyGKz5kVoD/w=;
        b=Juz/qOpA9qqEvfx+JaIqoYrGyvBf1VZuSEo9QhfI4fZrzTCnA//3I/o3T7ESrFN2NV
         bLHHbT8KVwICMtUhm0HEtnOuyzAcHIjnhnYS/jS/wCCNSNwbzhcGRGxQojFY2scUmZtT
         r8rS0DNeaUJHoGjSyvznFsSJcvAm2s6uqLa+VhWLCy9BM7jLVAIrSmIWqtAyMw30mQDp
         97ymJhm3Rj4pQwCp4MfY1D5+1JgcfTyb5FqnbRcYowU/B5aJEy6zeaJaiT1LORX6weL0
         vN39GonN/hMST4U2A0LKcgoNPIYktr4uYjp3lTnCZ3IGHRX+dewhYCurxAEeSYYstqmA
         YFnQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791836878; x=1792441678; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IN1Nd1jOf1uIqNtCm/iqSeHZvrqnmZGz6JuPiV7jclo=;
        b=pJx88FKNUc9YH5dRHDtDdCe3BB8W41BEXg9Kd7bKvcFT7+aoTZdHTKRjYo5uBLaBYP
         F6rHLmM1adi3TofpuT91jru4ovivAHjnTf2cBlp9nq3LtBV87tMWJsLp4AHNOYyKRVHG
         asvrF8qU/CSFnxF/wOkMLvRmlFMXE3j/SQ+cEFvZyZsGLEs4lBGKpdtNZM0dMZ7tEQhh
         KoBDGqozxsOTr3QpbwQ7ytIn44KiNtHAw0vERxOVoAxca/XvMY65jcwo+bFwO0plVJDF
         tUiHzh9nis1nQThT7M+UPnahRER/UguuNGI+nnbvPOLfGw9HiEBmxyS7Ed7jwPlWE1Np
         HDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836878; x=1792441678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IN1Nd1jOf1uIqNtCm/iqSeHZvrqnmZGz6JuPiV7jclo=;
        b=zHzvRXC3l9UJsCI06HIEmfsS2Pd99t5x7Bf+zfiQVMBcMPWri/shiZejxF9C/LL2vy
         32CJxIh7I8JkfGOEVyood3lxXW2vxZ2jym/5pCN8MOnth9IGprs+uDpAiLso7xsRPyzD
         /wqSGnCqEjakNnSTwCuM1lITWh6ejM6Ql8In6lP3gaqNWRQGr5/Oggrb6TGzY/5sEmJx
         +7P4eOyl+bUXzmvoPcQiP9UhoBO7b3LnFnDcIyDYxT9ECw3oEXCJTE/DXdwJphZ1RoU5
         45Jhmi1CGahRHXJAsbpPeFUEAFjEoYl5PuJff8f+jK98Ga6idDJBo4Yvhw2x9u52YGmq
         jhaA==
X-Gm-Message-State: AFq9FYKpHJpfiTjrOrgKZMgwx6/g0SbxkVYghEugrJWh+a3WiHGSv/9l
	+JeNVfNECuV2rgVJZDY4p/UZsI1p1OvTwkRHt8kx7/MOSct13bU8SsnxZIJxX4w4K3Blv+TTDtm
	2Js1plAhbVzSm9qsq8jP9qqYNZ01jTjA=
X-Gm-Gg: AYBFou3lrO5wnNNtg6jXA4uUKkoLoomMdvVLrCxJ8vz2MF3NGdIqPdoImJFPrmbXmwR
	3qEFIpU0yWgvWwpRfxFv7+J79WB0rz9z1HOsTPP6wrzz/I6W6TKU1qalAdrQw+oocYMaPUGWXbC
	jXiUkFNX0gqMYXyyjUyGIGJdpxQLmlRDks1++79omWRRUPM/Vt4u3mXdcDA3Zb/qrszVZO3ovIz
	3aqJS2DeJRvXa3cuqIreBqLJBvq7wHd8shU1XJYaARlj3TahaDG3hx/tTNovE53ot3HM/jjgXpB
	PIKVJVR8vs8fov2/ZK777GdsGlfaS92ZqOEskXJ3bL5t2KDMSeVYXuMkU0DmDYZKX84fv0L+VSw
	jUO9lf++S45V6Whsp5CdBEv01L5f0tEVHtOFZuyDIsEcFsf8CwMUnXB14v/uh6vimbz1B8j2Z+b
	9U2CrQi18see3R5lPmi8oscp2ZPb5PwNgr/G1LfF7srKhaSuyeGEULZotyNdcogmbx+A==
X-Received: by 2002:a05:6402:2498:b0:6aa:f187:26bc with SMTP id
 4fb4d7f45d1cf-6b17c4e9257mr8599396a12.39.1791836878084; Mon, 12 Oct 2026
 13:27:58 -0700 (PDT)
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
References: <20261012180052.55578-1-rosenp@gmail.com> <a877ad04-c4ed-4e32-a1eb-da524146be14@kernel.org>
 <CAKxU2N-VQ9fWGvdNvyZ7te1gp08qMSvbSpgLrKRkqDO+Y+bYwg@mail.gmail.com> <04d806cb-24dc-4597-ae03-6dbef11d0a86@kernel.org>
In-Reply-To: <04d806cb-24dc-4597-ae03-6dbef11d0a86@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Oct 2026 13:27:45 -0700
X-Gm-Features: AclHuK-PuBwSNNAvYqlgFuSYA3HSPeHQkO0IbmJgKlgWgfIF0-Rmq6V_xt21rwg
Message-ID: <CAKxU2N-2NSEzr-Cz5V23TWbH1SJLRnitMFFvSKZo9MbSggOQbw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/lib: prefetch ahead in __csum_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 11:38=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 12/10/2026 =C3=A0 20:28, Rosen Penev a =C3=A9crit :
> > On Mon, Oct 12, 2026 at 11:18=E2=80=AFAM Christophe Leroy (CS GROUP)
> > <chleroy@kernel.org> wrote:
> >>
> >>
> >>
> >> Le 12/10/2026 =C3=A0 20:00, Rosen Penev a =C3=A9crit :
> >>> __csum_partial() walks the buffer linearly and reads each cache line
> >>> exactly once. On cores without a hardware prefetcher, such as the 464=
FP
> >>> in the APM82181, every new line is therefore a demand miss that stall=
s
> >>> the loop. Packets received by non-coherent DMA are never in the cache=
,
> >>> so this is the common case for GRO checksum validation: when routing
> >>> TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 3=
0%
> >>> of all cycles and is the top entry in the profile.
> >>>
> >>> Issue a dcbt four cache lines (128 bytes) ahead in the main loop.
> >>> dcbt is only a hint and never faults, so prefetching past the end of
> >>> the buffer is harmless. Lines that are already cached, for example wh=
en
> >>> checksumming data the CPU just wrote, are left untouched.
> >>>
> >>> Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
> >>> routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
> >>> was toggled at runtime, in the same boot:
> >>>
> >>>                 LAN->WAN               WAN->LAN
> >>>                 Mbit/s  csum cycles    Mbit/s  csum cycles
> >>>     before      495     30.5%          439     27.2%
> >>>     after       599     15.3%          520     13.7%
> >>>
> >>> That is 58% less time spent in __csum_partial() per byte.
> >>>
> >>> The prefetch distance was chosen with an earlier, slower driver
> >>> configuration (median of 3, Mbit/s):
> >>>
> >>>     distance    LAN->WAN   WAN->LAN
> >>>     none        370        341
> >>>     64 bytes    430        381
> >>>     96 bytes    438        397
> >>>     128 bytes   438        385
> >>>     160 bytes   434        386
> >>>     256 bytes   423        383
> >>>
> >>> Prefetching the first lines before entering the loop made no
> >>> measurable difference and is not done.
> >>>
> >>> Assisted-by: LLM
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>
> >> csum_partial_copy_generic() does the same, so your patch makes sense.
> >>
> >> Wondering if you should use MAX_COPY_PREFETCH instead of hardcoding va=
lue 4.
> > li      r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */
> >
> > LLM comment:
> >
> > What changes per platform: MAX_COPY_PREFETCH is 4 on every 32-bit
> > config except 8xx, where it is 1. So 44x, 47x and e500mc behave
> > exactly as before; on the 44x (canyonlands) build the instruction is
> > still li r9, 128. The one difference is 8xx, which now prefetches 16
> > bytes ahead instead of 64. That fits how the copy routine already
> > treats 8xx, but I didn't benchmark it.
> >
> > My comment:
> > I don't have an 8xx device so I don't know if this works properly there=
 or not.
>
> I have an 885 and might do the test one day, but I won't have time
> during the coming weeks. Nevertheless I have the feeling it makes sense
> to implement something based on MAX_COPY_PREFETCH to resemble
> csum_partial_copy_generic()
I got a user to test this setup with MAX_COPY_PREFETCH

Using Sophos RED 15w, right after sysupgrade -n, got an iperf3 -c
result of ~633Mb/s with the suggested change, vs. ~583Mb/s with the
latest snapshot build from the web site, ie. without this PR.
>
> >>
> >> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> > I'll keep this in v3.
> >>
> >>> ---
> >>>    v2: reword commit message and retest numbers.
> >>>    arch/powerpc/lib/checksum_32.S | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checks=
um_32.S
> >>> index cd00b9bdd772..5a14d45c7b9d 100644
> >>> --- a/arch/powerpc/lib/checksum_32.S
> >>> +++ b/arch/powerpc/lib/checksum_32.S
> >>> @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
> >>>        bdnz    2b
> >>>    21: srwi.   r6,r4,4         /* # blocks of 4 words to do */
> >>>        beq     3f
> >>> +     li      r9,4*L1_CACHE_BYTES     /* prefetch distance */
> >>>        lwz     r0,4(r3)
> >>>        mtctr   r6
> >>>        lwz     r6,8(r3)
> >>> @@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
> >>>        lwzu    r8,16(r3)
> >>>        adde    r5,r5,r7
> >>>        bdz     23f
> >>> -22:  lwz     r0,4(r3)
> >>> +22:  dcbt    r3,r9
> >>> +     lwz     r0,4(r3)
> >>>        adde    r5,r5,r8
> >>>        lwz     r6,8(r3)
> >>>        adde    r5,r5,r0
> >>
>

