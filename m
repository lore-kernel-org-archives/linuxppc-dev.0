Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU profiling updated patch
Date: Thu, 15 Feb 2007 19:13:52 +0100
References: <1171497138.23691.8.camel@dyn9047021078.beaverton.ibm.com>
	<200702151537.51202.arnd@arndb.de> <45D4870C.9070908@us.ibm.com>
In-Reply-To: <45D4870C.9070908@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702151913.53594.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Carl Love <cel@us.ibm.com>, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 February 2007 17:15, Maynard Johnson wrote:
> >>+void spu_set_profile_private(struct spu_context * ctx, void * profile_=
info,
> >>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =
=A0 struct kref * prof_info_kref,
> >>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =
=A0 void (* prof_info_release) (struct kref * kref))
> >>+{
> >>+=A0=A0=A0=A0=A0ctx->profile_private =3D profile_info;
> >>+=A0=A0=A0=A0=A0ctx->prof_priv_kref =3D prof_info_kref;
> >>+=A0=A0=A0=A0=A0ctx->prof_priv_release =3D prof_info_release;
> >>+}
> >>+EXPORT_SYMBOL_GPL(spu_set_profile_private);
> >> =A0 =A0
> >>
> >
> >I think you don't need the profile_private member here, if you just use
> >container_of with ctx->prof_priv_kref in all users.
> > =A0
> >
> Sorry, I don't follow. We want the profile_private to be stored in the=20
> spu_context, don't we? =A0How else would I be able to do that? =A0And=20
> besides, wouldn't container_of need the struct name of profile_private? =
=A0
> SPUFS doesn't have access to the type.

The idea was to have spu_get_profile_private return the kref pointer,
and then change the user of that to do

+       if (!spu_info[spu_num] && the_spu) {
+               spu_info[spu_num] =3D container_of(
+				spu_get_profile_private(the_spu->ctx),
+				struct cached_info, cache_kref);
+               if (spu_info[spu_num])
+                       kref_get(&spu_info[spu_num]->cache_ref);
