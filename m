Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 47682DDEE4
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 09:04:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 2/2] Cell: Wrap master run control bit
Date: Sat, 8 Sep 2007 01:01:01 +0200
References: <46DD4783.9040103@am.sony.com> <200709050042.13926.arnd@arndb.de>
	<46E0A9E8.3050701@am.sony.com>
In-Reply-To: <46E0A9E8.3050701@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709080101.02043.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 September 2007, Geoff Levand wrote:
> >> @@ -178,6 +179,8 @@ struct spu_management_ops {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*enumerate_spus)(int (*fn)(void *da=
ta));
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*create_spu)(struct spu *spu, void =
*data);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*destroy_spu)(struct spu *spu);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0int (*enable_spu)(struct spu_context *ctx);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0int (*disable_spu)(struct spu_context *ctx);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*init_affinity)(void);
> >> =C2=A0};
> >=20
> > Also, I think you should make the return type of the callback
> > 'void' since the result is not used anywhere.
>=20
> Noguchi-san was hesitant to do this. =C2=A0I also thought lets leave it
> as is until we consider the unmapping support, as maybe a return
> value might make sense.=20

Sorry for having to reply twice on this. I first only got the
other mail because of a mail server hickup.

In general, I think we should follow the rule of keeping the interfaces
as simple as possible. If nobody is using the return value here,
we probably won't need it in the future either. And if we do, we
can still change it.

	Arnd <><
