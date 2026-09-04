Return-Path: <linuxppc-dev+bounces-26585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA78FC624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNCm19Mhz2yr4;
	Sat, 05 Sep 2026 16:07:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788517108;
	cv=pass; b=cG7xNvzKUi0+ZyL9NTZl+B8fvL7dNzH4en4w1Gud5QyJTgUmfXNIdiI2uh8lv3UkWJNnekOHBOuJHUtJoxsJdKA6PkJZS5dmFy030jKGbcl1PnRbCTEB4voVZFgejj9e1Re4V7BWfGWguU/a9CLUYmJcBVV11JtHWhororYcdLHh5KpFAstGDm7jmuYamEfjIb/nwaLL8dWSvHuTtiLxib75hOqtZ+76CZe15bZvcElv59YM4x1EY/YCkKRQLkJjl13vIQH507rqKudyfTuE7qcTrwvuWAB4CnPhBXS/1qMSupQpbd2mbE3C4qx8vl8yVwE6rUrGD5E60VXG3RQsLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788517108; c=relaxed/relaxed;
	bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeTQwT2NEdf8+E+zy1Pb8sbgQ2cWhS9TN3RYRORakBz6wXqpNXi1AOjgFJwLAt3alMpPAxBsSsIPM9eN1Xk4Fihc8gNCV2Dzow7NHyP3HWZUIFmgLQSA8s3Dppev0e4VdiAARVY//vdcfwrRmy9q7Kpw7z1szOoUIq4OcFukyAImibGyE7yAYRssOOd/kZnxv4b+AfjVxxErICDWNPB/BAwP1TJMZUP6hDFmN2Cf/Nf4Kbm7Tq492cYIhbp3vJHPpWldfBZ3H/PXOsezhB6qvJZ+LcbHwZYyqFe4uVbzSnJdPRk97MH+C5W+haz4lRRTsgQcE9sql27izZ/fPoU3CQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grNnJKzl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com; envelope-from=aivazian.tigran@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grNnJKzl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com; envelope-from=aivazian.tigran@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com [IPv6:2607:f8b0:4864:20::b12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbsqk6B7Gz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 20:18:25 +1000 (AEST)
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-66fa996e65bso1479326d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 03:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788517102; cv=none;
        d=google.com; s=arc-20260327;
        b=nK4Xkyf2tIO+hQpdZlqIs7GlrH1IW87ObMKJvfharfNsTTK1CYmJZUPvzHoKjWgY3n
         fFKSXmNYius4Gf17sCvSO/GsiE2IoHdpIZJFYDvRH2N+My4D/0k1nT6okA70m8knqu3c
         Vn0pH3Ow8SjeiHXYxFJXnJsx90MPGiU9ewCom2wmIiMWfMXQbNUychIDO5jBbSxJsnJJ
         9Ux4HDRRFpSCVtsNqsj8NH5J5/H5WP3t7ZPgtHgav6h/urXvhEtsuvqgHNSl5EHwSD6k
         MdXvGsHLjpQXTndrZERvjz1+iJX1QJ49xCC8YjOq7h9vaN9tLQq+XGwEBnFNn+O/YseU
         9cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
        fh=1piiaMP3nYEqJEpCdP7rby8G8vpelBuOBitPedEx4eo=;
        b=qJLgHx3VytjVstQLEQeV0N20DABWWNJkVvE6zusl2QlPptCQWTfu6XGjA5q2iWtf/4
         naY4YVhdYJWuEyE1HfEhUIdGo6qf1040YbcsZpeddXf+pqxv4LKVBOcBRSXdXVKWb3mE
         dlwFvKci3dIaOtZyFTFYYlIpu+9kOKEYERlGfXYyfb3VE+r2AGwIfhk2UXyj7MrBy+pJ
         ehXP7IVpXHjyojVCXFz0icqhPPAA59SrOOqwnlWVKf0PpRXYMnMMbJSzMv3WixIFPT2F
         VGTeuqNpP3dvX8m0hKZtuepKt5Gok6XSMc87Oek5nalfdoX705RaIBUVXp8/I3gmmxbk
         ibcg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788517102; x=1789121902; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
        b=grNnJKzlvkJLAAoy+LwB3rP7OQ/TY4OqaXtCsuWnbG3yQB4OmsNVW8RC/XiIOhvhpK
         wLG5RhyDH3yQHolfNEBk9lVU5OimNdIUignPT1T7U3rhCEOEOhRaJmDG84/jRroPcn7d
         uhnX2BFJpvgK24QuoijAGLoqCbHcjWlnYyWJxSROcWdZCp4UR7Vy55hTUTSPjsx5ZSrD
         4ZdYyXXIR24ERNt+Kv9+2hLNmx1GzraDJpkfhPEjh3nphNHi74RbpoG7t0jOfyv8hoyb
         casosbkeGUL8fymsHI5xf9fM3oyVnr661GCbY6+q1tNezbHBDY7J6cJQ9xaglhwFOsww
         NmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788517102; x=1789121902;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
        b=jgm3FrenH5Ut7bIzrn6eJx/r7qhrRNuxXkEThPfu4VsYDDnpsxa1B9uNFGk1tshr9C
         KIAWK7+Hkm11qfsZ+sPXCfOnge+ctDhNwJoMLVTEDoOpiI3GUFRt7IYVxtU7wbay15+1
         e5w0YiK/2NpmOSWbecLpSsjolFmEloVSJIOtBMl8er5JzOZE+IR8LsAAnu4Y3Y9SqcUA
         UMYdN7spfyFR+kNUwEJrXAANw8aGmql7T/kFoTVIKnlBAY8+kS+os8Z8zY1Dw2BL8Z7D
         gW7U6NewyfZJifQTSKhQq/7qt7nvMh7WFuOvwT5jf12bvQovvBJ54IGm9A9bciHRwn/w
         jFMg==
X-Forwarded-Encrypted: i=1; AKwUvByczyX6v+aSI1WBtooygwHNO69A9AxjmV55hDT3BsrKnvq0YJBAkVS9pVazcvnnETWHWo3YTHUJLTu2Wbc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mX21Z/rbZ37rrH3d2xb+NEcJbla5nhK9eZe7KJ5a3mBAl2FJKN
	YR4GT+tC3YZSKvgrRsUm8kJtvTrZEnbAkIvviAkovmYHkadCu+zf/kubuXsaS5fEp38nraq7a+s
	HeezYr/bmkTgnW8AvEMb3QyxPpSd3jKw=
X-Gm-Gg: AYBFou1J23mWSrjBzV+mncowac63tj7mv7hJQI7ykKyiPLTQC8drb+2dzyczqhetBjY
	q4uFO1iitoAX63Xj0nyGEZ/IHtOxOP4W/1f3Ncd+hTiLSpbKo/yw+GGsoKUywNlrAPGIuN1zFv4
	fzgBUOjea4mVc+6gUxr04LHM+hpDfvrGxzQ7xXxDmtBSX0oBJc5AFnjRzhCyC77XOanu7h1XmOL
	rEQk50LH42+4dPEkq0WEW+9y2pvASgTFOc/9FHiewmYD1e215ucBU5imQJ0I5Zksypvcs/k1rQT
	ezC0glPmGk/JU+JdbUjPfMiRn9iZNK5Bo7NBItthg5rTF8HniQ72t9WE56lC5dNThw40FkGoiQB
	m
X-Received: by 2002:a53:c053:0:20b0:66f:a1b4:741c with SMTP id
 956f58d0204a3-66fb5958686mr1624093d50.12.1788517102415; Fri, 04 Sep 2026
 03:18:22 -0700 (PDT)
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
References: <20260904082954.48738-1-enelsonmoore@gmail.com> <apqXNCL4X_i6xy2Z@gremlin>
In-Reply-To: <apqXNCL4X_i6xy2Z@gremlin>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 4 Sep 2026 11:18:10 +0100
X-Gm-Features: AcwNN1X7ex5eCk4ouskYN2ChvEs-v8zBI8q8LI-VGa7gCcqGKoso7q1xSbR0jLY
Message-ID: <CAK+_RLm9HKkm8YCCanpOMxaMaAkt5eoxQBHBxC1-Xkvj=L=UsQ@mail.gmail.com>
Subject: Re: [PATCH] bfs: remove the filesystem
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jakub Kicinski <kuba@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Hisam Mehboob <hisamshar@gmail.com>, =?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, David Howells <dhowells@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Theodore Ts'o" <tytso@mit.edu>, 
	Catalin Iacob <iacobcatalin@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Andrew Lunn <andrew@lunn.ch>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 11:05, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> Based on Jan's feedback at [0] that closes the loop (it is indeed a
> maintenance headache):
>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> [0]:https://lore.kernel.org/all/35dsgpk5dsh6bm4xoblrq6hdslfvtuibl5grzag37cye2hgepk@rkrtkjxdyk5g/

Ok, I won't cry about it :)

In fact, if I may, I would like to say that it is a pleasure to be in
your (pl.) company once again. Looking at the list of people included
here -- some familiar, some unfamiliar -- I remember the younger days.
I have done my tiny share of contributing to the Linux kernel as best
as I could, but as I now grow older I can no longer maintain BFS
(older does not mean inactive, just active at other things), so if it
does give maintenance headache, by all means -- remove it :)

Acked-by: Tigran Aivazian <aivazian.tigran@gmail.com>

PS. This reminds me of d'Artagnan's phrase from the Soviet version of
"The Three Musketeers" -- "my consolation is that if I am to be
killed, I will be killed by a true musketeer" :)

