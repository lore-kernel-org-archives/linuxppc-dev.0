Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D0A367A66
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 09:03:01 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Johannes Berg <johannes@sipsolutions.net>
To: Ken Moffat <zarniwhoop@ntlworld.com>
In-Reply-To: <20060525224905.GA28647@deepthought.linux.bogus>
References: <1148553785.11759.12.camel@johannes.berg>
	<20060525123247.GA19308@deepthought.linux.bogus>
	<1148560908.11759.25.camel@johannes.berg>
	<20060525221111.GB27181@deepthought.linux.bogus>
	<1148595891.11759.48.camel@johannes.berg>
	<20060525224905.GA28647@deepthought.linux.bogus>
Content-Type: text/plain; charset=utf-8
Date: Fri, 26 May 2006 01:02:49 +0200
Message-Id: <1148598169.11759.65.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-25 at 23:49 +0100, Ken Moffat wrote:
> > >   CC [M]  /home/ken/snd-aoa/soundbus/core.o
> > > In file included from /home/ken/snd-aoa/soundbus/soundbus.h:12,
> > >                  from /home/ken/snd-aoa/soundbus/core.c:12:
> > > include/sound/pcm.h:59: warning: =E2=80=98struct snd_pcm_substream=E2=
=80=99 declared
> > > inside parameter list
> > > include/sound/pcm.h:59: warning: its scope is only this definition
> > > or declaration, which is probably not what you want
> > > include/sound/pcm.h:60: warning: =E2=80=98struct snd_pcm_substream=E2=
=80=99 declared
> > > inside parameter list
> >=20
> > Nah, those should not happen. What kernel are you building against?
> >=20
>  2.6.17-rc5.  I had similar messages when I first tried snd-aoa,
> which would have been around 2.6.16.5.

Hm, ok, I'm currently testing against 2.6.17-rc4 so that ought to be
fine unless they had a large alsa code drop which can't really be
between -rc4 and -rc5 :)

>  Must be the headers causing the problem then.  I wonder if it's
> somehow using userspace headers - I might have had some 'unvalidated'
> headers in /usr/include/sound [1].  Will take a look tomorrow,
> although I've installed alsa lib after building snd-aoa, so that
> probably updated the headers.

Very strange, I don't think it should be trying to include *anything*
from /usr/include for userspace. And the line numbers match the kernel
line numbers.

But looking at the header file again, I don't quite understand why it
should even work at all.

It (pcm.h) first uses struct snd_pcm_substream:
struct snd_pcm_ops {
        int (*open)(struct snd_pcm_substream *substream);
        int (*close)(struct snd_pcm_substream *substream);
(these are the lines that give the warnings above)

and then defines it much much later in line 344... Odd. I suppose gcc
4.1.0 is more struct. Try adding to pcm.h, around line 57, just the
definition like so:

struct snd_pcm_substream;

In any case, I don't think that's the actual problem. I think the point
is that your machine isn't supported yet, can you try the patch below?

But please let me know if _noheadphones is correct, it probably isn't
and you need to tell me what connectors you have on the outside of the
box.

johannes

--- snd-aoa.orig/aoa/fabrics/snd-aoa-fabric-layout.c	2006-05-26 01:01:17.18=
9771119 +0200
+++ snd-aoa/aoa/fabrics/snd-aoa-fabric-layout.c	2006-05-26 01:01:42.8197711=
19 +0200
@@ -80,6 +80,8 @@ struct layout {
=20
 MODULE_ALIAS("sound-layout-82");
 MODULE_ALIAS("sound-layout-45");
+MODULE_ALIAS("sound-layout-60");
+MODULE_ALIAS("sound-layout-61");
 MODULE_ALIAS("sound-layout-64");
 MODULE_ALIAS("sound-layout-65");
 MODULE_ALIAS("sound-layout-68");
@@ -161,6 +163,21 @@ static struct layout layouts[] =3D {
 		.connections =3D NULL /* TBD */,
 	  },
 	},
+	/* PowerMac9,1 */
+	{ .layout_id =3D 60,
+	  .flags =3D LAYOUT_FLAG_COMBO_LINEOUT_SPDIF,
+	  .codecs[0] =3D {
+		.name =3D "onyx",
+		.connections =3D onyx_connections_noheadphones,
+	  },
+	},
+	/* PowerMac9,1 */
+	{ .layout_id =3D 61,
+	  .codecs[0] =3D {
+		.name =3D "topaz",
+		.connections =3D NULL, /* TBD */
+	  },
+	},
 	/* PowerBook5,7 */
 	{ .layout_id =3D 64,
 	  .flags =3D LAYOUT_FLAG_COMBO_LINEOUT_SPDIF,
