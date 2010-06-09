Return-Path: <penberg@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by ozlabs.org (Postfix) with ESMTP id D6116B7D29
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 20:07:02 +1000 (EST)
Received: by bwz18 with SMTP id 18so1559219bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Jun 2010 03:06:59 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <1276068001_13533@mail4.comsite.net>
References: <96933b66aa5f995746a34410ca63e5e8b84593cb.1275968594.git.joe@perches.com>
	<cover.1275968594.git.joe@perches.com>
	<1276068001_13533@mail4.comsite.net>
Date: Wed, 9 Jun 2010 13:06:59 +0300
Message-ID: <AANLkTimSgiMP8EZ57Eba00vGsVTA3QKRZbh1bNYavISv@mail.gmail.com>
Subject: Re: [PATCH 00/12] treewide: Remove unnecessary kmalloc casts
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Milton,

On Wed, Jun 9, 2010 at 10:20 AM, Milton Miller <miltonm@bga.com> wrote:
> However, in this case you are removing casts that, while not necessary
> for C, are indeed there for a reason.
>
> Specifically, they are of the form
> =A0 type *p;
> =A0 <code>
> =A0 p =3D (type *)kmalloc(sizeof(type), ...);
>
> For example, from the powerpc patch:
>> goto out;
>> }
>> - tmp_part =3D (struct nvram_partition *)
>> - kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
>> + tmp_part =3D kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
>> err =3D -ENOMEM;
>
> The reason they casts are present is to guard against someone changing
> the type of p at the top of the function and not changing the type at
> the kmalloc.

If you're worried about that...

[snip]

> There may have been discussion of doing the above vs
> =A0 p =3D kmalloc(sizeof(*p), ...);

...it's better to use this form. There's actually a mention of this in
"Chapter 14: Allocating memory" of Documentation/CodingStyle. The
guard is not really a guard as someone can still change the "sizeof"
part to something else and the cast from "void *" will silently ignore
it.

                        Pekka
